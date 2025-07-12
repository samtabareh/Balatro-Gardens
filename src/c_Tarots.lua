-- Tarots

--- Misery
SMODS.Consumable {
    key = "lethal",
    set = "Tarot",
    atlas = "Consumables",
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1, mod_conv = "m_baga_wounded" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = "name_text", set = "Enhanced", key = card.ability.mod_conv } } }
    end,
}

--- Dig
SMODS.Consumable {
    key = "dig",
    set = "Tarot",
    atlas = "Consumables",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    config = { extra = { odds = 25 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_baga_lost
    end,
    use = function(self, card, area, copier)
        if pseudorandom("baga_dig") < G.GAME.probabilities.normal / card.ability.extra.odds then
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
        else -- No soul joker, make lost card
            local card_to_lose = pseudorandom_element(G.hand.cards, pseudoseed("random_lost"))
            
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
                delay = 0.15,
                func = function()
                    card_to_lose:flip()
                    play_sound("card1", percent)
                    card_to_lose:juice_up(0.3, 0.3)
                    return true
                end
            }))
            delay(0.2)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    card_to_lose:set_ability("m_baga_lost")
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    card_to_lose:flip()
                    play_sound("tarot2", percent, 0.6)
                    card_to_lose:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit and G.hand and #G.hand.cards > 0
    end,
    -- Copy pasted from soul lol
    draw = function(self, card, layer)
        if (layer == "card" or layer == "both") and card.sprite_facing == "front" then
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            G.shared_soul.role.draw_major = card
            G.shared_soul:draw_shader("dissolve", 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            G.shared_soul:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end
}