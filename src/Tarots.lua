-- Tarots

--- Misery
SMODS.Consumable {
    key = "ripped",
    set = "Tarot",
    atlas = "Consumables",
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1, mod_conv = "m_baga_wounded" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = "name_text", set = "Enhanced", key = card.ability.mod_conv } } }
    end
}

--- Misery
SMODS.Consumable {
    key = "lotus",
    set = "Tarot",
    atlas = "Consumables",
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local new_card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                new_card:add_to_deck()
                
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, new_card)
                
                G.hand:emplace(new_card)
                new_card:start_materialize(nil, true)
                
                SMODS.calculate_context( { playing_card_added = true, cards = { new_card } } )
                return true
            end
        }))
    end
}
