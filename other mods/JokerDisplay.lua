if not (JokerDisplay and BalatroGardens) then return end

---@type table<string, JDJokerDefinition>
BalatroGardens.JokerDisplay = {
    One_On_One = {
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                }
            }
        },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text_face_cards", colour = lighten(G.C.ORANGE, 0.35) },
            { text = ")" },
        },
        calc_function = function(card)
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            local ranks = {}

            if text ~= "Unknown" then
                for i = 1, #scoring_hand do
                    local _c = scoring_hand[i]
                    local condition = (
                        function (ranks, id)
                            local temp = false
                            for _, rank in ipairs(ranks) do temp = rank == id and true or temp end
                            return temp
                        end
                    ) (ranks, _c:get_id())

                    if _c:is_face() and not condition then ranks[#ranks+1] = _c:get_id() end
                end
            end

            card.joker_display_values.x_mult = #ranks >= 2 and card.ability.extra.Xmult or 1
            card.joker_display_values.localized_text_face_cards = localize("k_different_face_cards")
        end
    },
    Misery = {
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                }
            }
        },
        calc_function = function(card)
            local playing_hand = next(G.play.cards)
            local count = 0
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_hand or not playing_card.highlighted then
                    if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:is_face() then
                        count = count + 1
                    end
                end
            end
            card.joker_display_values.x_mult = 1 + card.ability.extra.Xmult_gain * count
        end
    },
    Fragile = {},
    Flutter = {
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
                }
            }
        }
    },
    Lost = {},
    Infinity = {},
    Tremor = {},
    Frozen = {},
    Clouded = {
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
                }
            }
        }
    }
}

for name, def in pairs(BalatroGardens.JokerDisplay) do
    local key = BalatroGardens.Jokers[name].key
    JokerDisplay.Definitions[key] = def
end