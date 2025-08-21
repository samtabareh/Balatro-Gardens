-- Consumables

local atlas = "Consumables"

--- Tarots

---- Lotus
SMODS.Consumable {
    key = "lotus",
    set = "Tarot",
    atlas = atlas,
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1, extra = { cards = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards, card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        -- Thanks VanillaRemade
        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_dissolve = nil
                local new_cards = {}
                for i = 1, card.ability.extra.cards do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards + 1] = _card
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
    end
}

---- Ripped
SMODS.Consumable {
    key = "ripped",
    set = "Tarot",
    atlas = atlas,
    pos = { x = 2, y = 0 },
    config = { extra = { cost_mult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cost_mult } }
    end,
    use = function(self, card, area, copier)
        local deletable_jokers = {}
        for _, joker in pairs(G.jokers.cards) do
            if not SMODS.is_eternal(joker, card) then deletable_jokers[#deletable_jokers + 1] = joker end
        end

        local chosen_joker = pseudorandom_element(deletable_jokers, "baga_ripped")
        if not chosen_joker then return end

        local given_dollars = chosen_joker.cost * card.ability.extra.cost_mult / 2

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.5,
            func = function()
                chosen_joker:start_dissolve(nil)
                ease_dollars(given_dollars)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
    end
}

--- Spectrals

---- Lethal
SMODS.Consumable {
    key = "lethal",
    set = "Spectral",
    atlas = atlas,
    pos = { x = 0, y = 1 },
    config = { max_highlighted = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)
    end
}

--- Dig
SMODS.Consumable {
    key = "dig",
    set = "Spectral",
    atlas = atlas,
    pos = { x = 1, y = 1 },
    hidden = true,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.add_card({ set = "Joker", rarity = "baga_ghost" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    draw = function(self, card, layer)
        if (layer == "card" or layer == "both") and card.sprite_facing == "front" then
            card.children.center:draw_shader("booster", nil, card.ARGS.send_to_shader)
        end
    end
}

-- Thanks VanillaRemade 
SMODS.DrawStep {
    key = "baga_ghost",
    order = 50,
    func = function(card)
        if card.config.center.key == "c_baga_dig" and (card.config.center.discovered or card.bypass_discovery_center) then
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            BalatroGardens.ghost.role.draw_major = card
            BalatroGardens.ghost:draw_shader("dissolve", 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            BalatroGardens.ghost:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end,
    conditions = { vortex = false, facing = "front" },
}

--- Planets

---- Pluto
SMODS.Consumable:take_ownership(
    "pluto", {
    atlas = atlas,
    pos = { x = 0, y = 0 }
    },
    false
)

atlas = "Planets"

---- Eris
SMODS.Consumable:take_ownership(
    "eris", {
        atlas = atlas,
        pos = { x = 0, y = 0 }
    },
    true
)

---- Ceres
SMODS.Consumable:take_ownership(
    "ceres", {
        atlas = atlas,
        pos = { x = 1, y = 0 }
    },
    true
)

---- Planet X
SMODS.Consumable:take_ownership(
    "planet_x", {
        atlas = atlas,
        pos = { x = 2, y = 0 }
    },
    true
)

---- Mercury
SMODS.Consumable:take_ownership(
    "mercury", {
        atlas = atlas,
        pos = { x = 3, y = 0 }
    },
    true
)

---- Venus
SMODS.Consumable:take_ownership(
    "venus", {
        atlas = atlas,
        pos = { x = 0, y = 1 }
    },
    true
)

---- Earth
SMODS.Consumable:take_ownership(
    "earth", {
        atlas = atlas,
        pos = { x = 1, y = 1 }
    },
    true
)

---- Mars
SMODS.Consumable:take_ownership(
    "mars", {
        atlas = atlas,
        pos = { x = 2, y = 1 }
    },
    true
)

---- Jupiter
SMODS.Consumable:take_ownership(
    "jupiter", {
        atlas = atlas,
        pos = { x = 3, y = 1 }
    },
    true
)

---- Saturn
SMODS.Consumable:take_ownership(
    "saturn", {
        atlas = atlas,
        pos = { x = 0, y = 2 }
    },
    true
)

---- Uranus
SMODS.Consumable:take_ownership(
    "uranus", {
        atlas = atlas,
        pos = { x = 1, y = 2 }
    },
    true
)

---- Neptune
SMODS.Consumable:take_ownership(
    "neptune", {
        atlas = atlas,
        pos = { x = 2, y = 2 }
    },
    true
)

---- Black Hole
SMODS.Consumable:take_ownership(
    "black_hole", {
        atlas = atlas,
        pos = { x = 3, y = 2 }
    },
    true
)
