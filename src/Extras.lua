-- Decks

--- Infinite Tremors
SMODS.Back {
    key = "infinite_tremors",
	atlas = "Extras",
	pos = { x = 0, y = 0 },
    config = { jokers = { "j_baga_infinity", "j_baga_tremor" } }
}

--- Frozen Clouds
SMODS.Back {
    key = "frozen_clouds",
    atlas = "Extras",
    pos = { x = 1, y = 0 },
    config = { ante_scaling = 2, jokers = { "j_baga_frozen", "j_baga_clouded" } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.ante_scaling } }
    end
}

--- Fluttering Black Petals
SMODS.Back {
    key = "fluttering_petals",
    atlas = "Extras",
    pos = { x = 2, y = 0 },
    config = { jokers = { "j_baga_flutter", "j_baga_black_lotus" } }
}

-- Enhancements

--- Wounded
SMODS.Enhancement {
    key = "wounded",
    atlas = "Extras",
    pos = { x = 0, y = 0 },
    config = { extra = { Xmult = 2, min = 1, decay = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.decay } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card == card and card.ability.extra.Xmult - card.ability.extra.decay <= card.ability.extra.min then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    SMODS.destroy_cards(card)
                    return true
                end
            }))
        end
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if card.ability.extra.Xmult - card.ability.extra.decay >= card.ability.extra.min then
                card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.decay
                ret = {
                    message = "-X"..card.ability.extra.decay,
                    colour = G.C.MULT
                }
            end
            ret.xmult = card.ability.extra.Xmult
            return ret
        end
    end
}

--- Lost
SMODS.Enhancement {
    key = "lost",
    atlas = "Extras",
    pos = { x = 0, y = 0 },
    config = { extra = { upgrade_odds = 2, lost_odds = 4 } },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.upgrade_odds, card.ability.extra.lost_odds } }
    end,
    calculate = function(self, card, context)
        
        
        -- Upgrade hand level
        if context.cardarea == G.play and context.before and pseudorandom("lost") < G.GAME.probabilities.normal / card.ability.extra.upgrade_odds then
            level_up_hand(card, G.GAME.last_hand_played)
        end
        -- Destroy self
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom("glass") < G.GAME.probabilities.normal / card.ability.extra.lost_odds then
            return {
                message = "Lost!",
                remove = true
            }
        end
    end,
}

-- Gradients

--- Clouded Cloud
SMODS.Gradient {
    key = "clouded_cloud",
    colours = {
        HEX("0e0d12"),
        HEX("30312c"),
        HEX("373737"),
        HEX("6a6a69")
    },
    cycles = 20
}

--- Clouded Lightning
SMODS.Gradient {
    key = "clouded_lightning",
    colours = {
        HEX("713ba7"),
        HEX("b490d5")
    }
}

--- Frozen Ice
SMODS.Gradient {
    key = "frozen_ice",
    colours = {
        HEX("325372"),
        HEX("30a8cd"),
        HEX("bbe0f2")
    }
}

--- Infinity Ring
SMODS.Gradient {
    key = "infinity_ring",
    colours = {
        HEX("c52f16"),
        HEX("ba2113"),
        HEX("f3976e")
    }
}

--- Tremor bat
SMODS.Gradient {
    key = "tremor_bat",
    colours = {
        HEX("000000"),
        HEX("5a5a5a"),
        HEX("fefefe"),
        HEX("5a5a5a")
    }
}

-- Ownerships

--- Pluto
SMODS.Consumable:take_ownership(
    "pluto", {
	atlas = "Pluto",
    pos = { x = 0, y = 0 }
    },
    false
)

-- Vouchers

--- Glory
SMODS.Voucher {
    key = "glory",
    atlas = "Vouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { addition = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.addition } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(card.ability.extra.addition)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.addition

        -- Apply discards change
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.addition
        ease_discard(card.ability.extra.addition)
    end
}

--- Victory
SMODS.Voucher {
    key = "victory",
    atlas = "Vouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { addition = 1 } },
    requires = { "v_baga_glory" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.addition } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(card.ability.extra.addition)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.addition

        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                end
                return true
            end,
        }))
    end
}