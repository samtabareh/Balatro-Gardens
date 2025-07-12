-- Uncommon Jokers

--- Black Lotus
SMODS.Joker {
    key = "black_lotus",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "j_Uncommons",
    pos = { x = 0, y = 0 },
    config = { extra = { repetitions = 3, chosen_card = {} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions, card.ability.extra.chosen_card } }
    end,
    calculate = function(self, card, context)
        -- Chooses card
        if context.before then
            card.ability.extra.chosen_card = pseudorandom_element(context.scoring_hand, pseudoseed("random_trigger"))
        end
        -- Triggers card
        if context.repetition and context.cardarea == G.play and card.ability.extra.chosen_card and context.other_card == card.ability.extra.chosen_card then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}

--- One on One
SMODS.Joker {
    key = "one_on_one",
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    atlas = "j_Uncommons",
    pos = { x = 0, y = 0 },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_baga_wounded
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local lost = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() and pseudorandom("baga_one_on_one") < G.GAME.probabilities.normal / card.ability.extra.odds then
                    lost = lost + 1
                    scored_card:set_ability("m_baga_wounded", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if lost > 0 then
                return {
                    message = "Lost!",
                    colour = HEX("f50402")
                }
            end
        end
    end
}