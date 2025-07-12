-- Spectrals

--- Dig
SMODS.Consumable {
    key = "dig",
    set = "Spectral",
    atlas = "Consumables",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    hidden = true,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.add_card({ set = "Joker", rarity = "baga_ghost" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    -- Copy pasted from Soul (VanillaRemade) lol
    draw = function(self, card, layer)
        if (layer == "card" or layer == "both") and card.sprite_facing == "front" then
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            G.shared_soul.role.draw_major = card
            G.shared_soul:draw_shader("dissolve", 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            G.shared_soul:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end
}
