-- Uncommon Jokers

--- One on One
SMODS.Joker {
    key = "one_on_one",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "j_Uncommons",
    pos = { x = 0, y = 0 },
    config = { extra = { Xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local ranks = {}
            for i = 1, #context.scoring_hand do
                local _c = context.scoring_hand[i]
                if _c:is_face() and not ranks[_c:get_id()] then ranks[_c:get_id()] = 1 end
            end
            if #ranks >= 2 then
                return { Xmult = card.ability.extra.Xmult }
            end
        end
    end
}

--- Fragile
SMODS.Joker {
    key = "fragile",
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = "j_Uncommons",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_baga_wounded
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local worked = false
            
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    worked = true
                    scored_card:set_ability("m_baga_wounded", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if worked then return { message = "Scarred!" } end
        end
    end
}

--- Misery
SMODS.Joker {
    key = "misery",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = "j_Uncommons",
    pos = { x = 0, y = 0 },
    config = { extra = { Xmult = 1, Xmult_gain = 0.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after then
            card.ability.extra.Xmult = 1
        end
        
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_face() and not context.blueprint then
            if context.other_card.debuff then
                return {
                    message = localize("k_debuffed"),
                    colour = G.C.RED
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.add
            end
        end

        if context.joker_main then
            return { Xmult = card.ability.extra.Xmult }
        end
    end
}
