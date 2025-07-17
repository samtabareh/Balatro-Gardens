-- Jokers

local atlas = ""
---@type integer | string
local rarity = 0

--- Uncommons

atlas = "j_Uncommons"
rarity = 2

---- One on One
SMODS.Joker {
    key = "one_on_one",
    blueprint_compat = true,
    rarity = rarity,
    cost = 6,
    atlas = atlas,
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

---- Fragile
SMODS.Joker {
    key = "fragile",
    blueprint_compat = false,
    rarity = rarity,
    cost = 6,
    atlas = atlas,
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

---- Misery
SMODS.Joker {
    key = "misery",
    blueprint_compat = true,
    rarity = rarity,
    cost = 7,
    atlas = atlas,
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

--- Rares

atlas = "j_Rares"
rarity = 3

---- Flutter
SMODS.Joker {
    key = "flutter",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = rarity,
    cost = 7,
    atlas = atlas,
    pos = { x = 0, y = 0 },
    config = { extra = { Xmult = 1, Xmult_gain = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + #context.removed * card.ability.extra.Xmult_gain
            return { message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } } }
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss and card.ability.extra.Xmult > 1 then
                card.ability.extra.Xmult = 1
                return {
                    message = localize("k_reset"),
                    colour = G.C.RED
                }
            end
        end

        if context.joker_main then
            return { Xmult = card.ability.extra.Xmult }
        end
    end
}

---- Lost
SMODS.Joker {
    key = "lost",
    blueprint_compat = true,
    rarity = rarity,
    cost = 7,
    atlas = atlas,
    pos = { x = 0, y = 0 },
    config = { extra = { destroyed_cards = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroyed_cards } }
    end,
    calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			for i = 1, card.ability.extra.destroyed_cards do
                -- Select a random card from hand to destroy
                local _card = pseudorandom_element(G.hand.cards, pseudoseed("baga_lost"))
                
                if _card then
                    G.E_MANAGER:add_event(Event({
                            trigger = "before",
                            delay = 0.25,
                            func = function()
                                _card:start_dissolve(nil, true)
                                return true
                            end,
                    }))
                end
            end
            return { message = "Lost!" }
		end
	end
}

--- Ghosts

rarity = "baga_ghost"
atlas = "j_Ghosts"

SMODS.Rarity {
    key = "ghost",
    loc_txt = {},
    default_weight = 0,
    badge_colour = HEX("00a49d"),
    get_weight = function(self, weight, object_type) return weight end
}

---- Infinity
SMODS.Joker {
    key = "infinity",
    blueprint_compat = false,
    rarity = rarity,
    cost = 20,
    atlas = atlas,
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    config = { extra = { odds = 1000 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.denominator
            }
        end
        if context.end_of_round and context.game_over == false and
        context.main_eval and not context.blueprint and
        pseudorandom("baga_infinity") < 1 / card.ability.extra.odds then
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
}

---- Tremor
SMODS.Joker {
    key = "tremor",
    blueprint_compat = true,
    rarity = rarity,
    cost = 20,
    atlas = atlas,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    loc_vars = function(self, info_queue, card)
        -- Only shows negative tooltip if it isnt negative itself
        if card.edition then
            if not card.edition.negative then
                info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
            end
        else info_queue[#info_queue + 1] = G.P_CENTERS.e_negative end

        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, G.jokers and #G.jokers.cards or 1, "baga_tremor")
        return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and
        SMODS.pseudorandom_probability(card, "baga_tremor", 1, #G.jokers.cards, "baga_tremor") then
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

---- Frozen
SMODS.Joker {
    key = "frozen",
    rarity = rarity,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 20,
    atlas = atlas,
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    loc_vars = function(self, info_queue, card)
        if not is_joker_frozen({ card = card }) and SMODS.Stickers and SMODS.Stickers.baga_frozen then
            info_queue[#info_queue+1] = { key = SMODS.Stickers.baga_frozen.key, set = "Other", vars = SMODS.Stickers.baga_frozen:loc_vars(info_queue, card).vars }
        end
        
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
            end
            
            local compatible = other_joker and other_joker ~= card and is_freezable(other_joker)
            
            local main_end = {
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
        if context.setting_blind then
            -- Finding Joker
            local joker
            for i = 1, #G.jokers.cards do if card == G.jokers.cards[i] then joker = G.jokers.cards[i - 1] end end
            
            

            -- Applying sticker
            if joker and is_freezable(joker) then
                SMODS.Stickers.baga_frozen:apply(joker, true)
            end

            return {
                message = "Frozen!",
                colour = G.C.FROZEN_ICE
            }
        end
    end
}

---- Clouded
SMODS.Joker {
    key = "clouded",
    blueprint_compat = true,
    rarity = rarity,
    cost = 20,
    atlas = atlas,
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
        for i = 1, #G.jokers.cards do
                local joker = G.jokers.cards[i]
                ---@type integer | string
                local joker_rarity = joker.config.center.rarity
    
                -- For when a jokers rarity is modded
                if type(joker_rarity) == "string" then
                    if card.ability.extra.Xmult_gain[joker_rarity] == nil then joker_rarity = 1
                    else joker_rarity = card.ability.extra.Xmult_gain[joker_rarity] end
                end
                
                card.ability.extra.Xmult = card.ability.extra.Xmult + joker_rarity
            end

        if context.joker_main then
            return { Xmult = card.ability.extra.Xmult }
        end
    end
}