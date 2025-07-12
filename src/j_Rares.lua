-- Rare Jokers

--- Flutter
SMODS.Joker {
    key = "flutter",
    blueprint_compat = true,
    rarity = 3,
    cost = 6,
    atlas = "j_Rares",
    pos = { x = 0, y = 0 },
    config = { extra = { Xmult = 1, Xmult_mod = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            -- messages appear on cards not the joker lol (nvm i fixed it with message_card, thanks VanillaRemade)
            return {
                message = "X"..card.ability.extra.Xmult,
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.joker_main then
            return { Xmult = card.ability.extra.Xmult }
        end
    end
}

--- Ripper
SMODS.Joker {
    key = "rip",
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    atlas = "j_Rares",
    pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers
        --and not context.blueprint and not context.retrigger_joker
        then
			local _card = pseudorandom_element(G.hand.cards, pseudoseed("baga_rip"))
			if _card then
				G.E_MANAGER:add_event(Event({
						trigger = "before",
						delay = 0.25,
						func = function()
                            _card:start_dissolve(nil, true)
							return true
						end,
				}))
				return {
                    message = "Ripped!",
                    colour = HEX("a4ba00")
                }
			end
		end
	end
}

--- Lost Inside
SMODS.Joker {
    key = "lost_inside",
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    atlas = "j_Rares",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_baga_lost
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            -- Make it lost
            context.other_card:set_ability("m_baga_lost", nil, true)
        end
    end
}