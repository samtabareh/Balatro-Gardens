-- Rare Jokers

--- Flutter
SMODS.Joker {
    key = "flutter",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 3,
    cost = 7,
    atlas = "j_Rares",
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

--- Lost
SMODS.Joker {
    key = "lost",
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    atlas = "j_Rares",
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
