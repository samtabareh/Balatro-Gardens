-- Extras

local atlas = "Extras"

--- Decks

---- Infinite Tremors
SMODS.Back {
    key = "infinite_tremors",
	atlas = atlas,
	pos = { x = 0, y = 0 },
    config = { jokers = { "j_baga_infinity", "j_baga_tremor" } }
}

--- Gradients

---- Clouded Cloud
SMODS.Gradient {
    key = "clouded_cloud",
    colours = {
        HEX("0e0d12"),
        HEX("30312c"),
        HEX("373737"),
        HEX("6a6a69")
    }
}

---- Clouded Lightning
SMODS.Gradient {
    key = "clouded_lightning",
    colours = {
        HEX("713ba7"),
        HEX("b490d5")
    }
}

---- Frozen Ice
SMODS.Gradient {
    key = "frozen_ice",
    colours = {
        HEX("325372"),
        HEX("30a8cd"),
        HEX("bbe0f2")
    }
}

---- Infinity Ring
SMODS.Gradient {
    key = "infinity_ring",
    colours = {
        HEX("c52f16"),
        HEX("ba2113"),
        HEX("f3976e")
    }
}

---- Tremor Bat
SMODS.Gradient {
    key = "tremor_bat",
    colours = {
        HEX("000000"),
        HEX("fefefe")
    }
}

--- Stickers

---- Frozen
SMODS.Sticker {
    key = "frozen",
    badge_colour = HEX("afe4f2"),
    atlas = atlas,
    pos = { x = 2, y = 0 },
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { 1 } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.repetition and not context.individual then
            card:calculate_frozen()
        end
    end
}

function Card:calculate_frozen()
    if not G.jokers then return end
    
    -- Dont unfreeze if its gonna be frozen again (aka next joker is j_baga_frozen)
    local joker
    for i = 1, #G.jokers.cards do if G.jokers.cards[i] == self then joker = G.jokers.cards[i + 1] end end
    
    if joker and joker.ability.name == "j_baga_frozen" then return end

    -- Unfreeze
    if self.ability.baga_frozen then
        self.ability.baga_frozen = false
        card_eval_status_text(self, "extra", nil, nil, nil, {
            message = "Unfrozen!",
            colour = G.C.FROZEN_ICE,
            delay = 0.45
        })
    end
end

--- Vouchers

atlas = "Vouchers"

---- Glory
SMODS.Voucher {
    key = "glory",
    atlas = atlas,
    pos = { x = 0, y = 0 },
    config = { extra = { antes = 1, slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.antes, card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(card.ability.extra.antes)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.antes

        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.slots - card.ability.extra.slots
                end
                return true
            end,
        }))
    end
}

---- Victory
SMODS.Voucher {
    key = "victory",
    atlas = atlas,
    pos = { x = 0, y = 0 },
    config = { extra = { slots = 3 } },
    requires = { "v_baga_glory" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.slots + card.ability.extra.slots
                end
                return true
            end,
        }))
    end
}