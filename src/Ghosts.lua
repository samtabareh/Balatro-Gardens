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
    cost = 20,
    atlas = "j_Ghosts",
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    config = { extra = { odds = 1000, multiplier = 1000000000 } },
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
                return { message = "Went To Infinity!" }
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
    cost = 20,
    atlas = "j_Ghosts",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = { extra = { odds = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if G.jokers then card.ability.extra.odds = #G.jokers.cards end

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
                            { "e_negative" })
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
    cost = 20,
    atlas = "j_Ghosts",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        local index = 0
        local debuff_joker = nil
        local copy_joker = nil

        for i = 1, #G.jokers.cards do
            if card == G.jokers.cards[i] then index = i end
        end
        copy_joker = G.jokers.cards[index - 1]
        debuff_joker = G.jokers.cards[index + 1]
        
        -- Debuffs the next joker
        if debuff_joker and not debuff_joker.debuff then
            SMODS.debuff_card(debuff_joker, true, "frozen")
        end

        -- To clean up old debuffed joker(s) (that aren't the next joker)
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            if joker.debuff and joker ~= G.jokers.cards[index + 1] then SMODS.debuff_card(joker, false, "frozen") end
        end
        
        -- Copies the joker before
        local ret = SMODS.blueprint_effect(card, copy_joker, context)
        if ret then
            ret.colour = G.C.FROZEN_ICE
        end

        return ret
    end
}

--- Clouded
SMODS.Joker {
    key = "clouded",
    blueprint_compat = true,
    rarity = "baga_ghost",
    cost = 20,
    atlas = "j_Ghosts",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    config = {
        extra = {
            Xmult = 0,
            Xmult_gain = {
                ["baga_ghost"] = 5,
                ["cry_cursed"] = 2,
                ["cry_epic"] = 3,
                ["cry_exotic"] = 5
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        card.ability.extra.Xmult = 0

        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            local rarity = joker.config.center.rarity

            -- For when a jokers rarity is modded
            if type(rarity) == "string" then
                if card.ability.extra.Xmult_gain[rarity] == nil then rarity = 1
                else rarity = card.ability.extra.Xmult_gain[rarity] end
            end
            
            card.ability.extra.Xmult = card.ability.extra.Xmult + rarity
        end
        
        if context.joker_main then
            return { Xmult = card.ability.extra.Xmult }
        end
    end
}