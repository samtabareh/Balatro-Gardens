-- Rarity

SMODS.Rarity {
    key = "ghost",
    loc_txt = {},
    default_weight = 0,
    badge_colour = HEX("00a49d"),
    get_weight = function(self, weight, object_type) return weight end
}

-- Ghost Jokers

--- Infinity
SMODS.Joker {
    key = "infinity",
    blueprint_compat = false,
    rarity = "baga_ghost",
    cost = 8,
    atlas = "j_Ghosts",
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    config = { extra = { odds = 1000, multiplier = 1000 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, card.ability.extra.multiplier } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if pseudorandom("baga_infinity") < 1 / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = "Went To Infinity!"
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * card.ability.extra.multiplier
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / card.ability.extra.multiplier
        end
    end
}

--- Tremor
SMODS.Joker {
    key = "tremor",
    blueprint_compat = true,
    rarity = "baga_ghost",
    cost = 8,
    atlas = "j_Ghosts",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        -- To not make a mess of info boxes if it has an edition
        if card.edition then
            if not card.edition.polychrome then info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome end
            if not card.edition.negative then info_queue[#info_queue + 1] = G.P_CENTERS.e_negative end
        else
            info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
            info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        end
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and
        pseudorandom("baga_tremor") < G.GAME.probabilities.normal / card.ability.extra.odds then
            local eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
            local joker = pseudorandom_element(eligible_jokers, pseudoseed("random_tremor"))
            if joker then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        local edition = poll_edition(nil, nil, false, true,
                            { "e_polychrome", "e_negative" })
                        joker:set_edition(edition, true)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end,
}

--- Frozen
SMODS.Joker {
    key = "frozen",
    blueprint_compat = true,
    rarity = "baga_ghost",
    cost = 8,
    atlas = "j_Ghosts",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    config = { mult = 0, extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.mult } }
    end,
    calculate = function(self, card, context)
        -- At end of round, reset mult
        if context.main_eval and not context.blueprint then
            -- Reset mult at end of round
            if context.end_of_round and context.game_over == false then
                card.ability.mult = 0
                return {
                    message = "Reset!",
                    colour = HEX("a7cee6")
                }
            end
            -- Set mult after hand is done IF mult is higher 
            if context.after and mult and mult > card.ability.mult then
                card.ability.mult = mult
                return {
                    message = "New Mult!",
                    colour = HEX("a7cee6")
                }
            end
        end
        -- Add mult (probably)
        if
        context.joker_main and
        pseudorandom("baga_frozen") < G.GAME.probabilities.normal / card.ability.extra.odds
        then
            return {
                mult = card.ability.mult
            }
        end
    end
}

--- Clouded
----  1 in 3 chance to multiply mult by (2 in 3 to add to mult, but value is x5) 2 to 5.
SMODS.Joker {
    key = "clouded",
    blueprint_compat = true,
    rarity = "baga_ghost",
    cost = 8,
    atlas = "j_Ghosts",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    config = { extra = { odds = 3, min = 2, max = 5, multiplier = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX("b490d5") } } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.blind then
            local ret = {}
            -- Get mult
            -- Assign Xmult or mult
            if pseudorandom("baga_clouded") < G.GAME.probabilities.normal / card.ability.extra.odds then
                ret = { Xmult = pseudorandom("baga_clouded", card.ability.extra.min, card.ability.extra.max) }
            else
                ret = { mult = pseudorandom("baga_clouded",
                card.ability.extra.min*card.ability.extra.multiplier,
                card.ability.extra.max*card.ability.extra.multiplier)
            }
            end
            return ret
        end
    end
}