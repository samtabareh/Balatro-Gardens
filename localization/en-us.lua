return {
    descriptions = {
        Back = {
            b_baga_infinite_tremors = {
                name = "Infinite Tremors Deck",
                text = {
                    "Start run with",
                    "{C:baga_infinity_ring}Infinity{} and {C:baga_tremor_bat}Tremor"
                }
            }
        },
        Joker = {
            -- Uncommons
            j_baga_one_on_one = {
                name = "One on One",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if hand",
                    "has scoring {C:attention}face{} cards",
                    "with different {C:attention}ranks",
                    "{C:inactive}(ex: {C:attention}J, Q or Q, K{C:inactive})",
                }
            },
            j_baga_misery = {
                name = "Misery",
                text = {
                    "Each {C:attention}face{} card held in",
                    "hand counts as {X:mult,C:white}X#1#{} Mult",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})"
                }
            },

            -- Rares
            j_baga_fragile = {
                name = "Fragile",
                text = {
                    "All played {C:attention}face{} cards",
                    "become {C:attention}Glass{} cards",
                    "when scored",
                }
            },
            j_baga_flutter = {
                name = "Flutter",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult for",
                    "every {C:attention}destroyed{} playing card",
                    "resets when {C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                }
            },
            j_baga_lost = {
                name = "Lost",
                text = {
                    "Destroys {C:attention}2 random",
                    "cards held in hand at",
                    "the end of round"
                }
            },
            -- Ghosts

            j_baga_infinity = {
                name = "{C:baga_infinity_ring}Infinity",
                text = {
                    "{E:2}Guarantees{} {C:attention}listed{} {C:green,E:1,S:1.1}probabilities",
                    "{C:green}1 in #1#{} chance to be",
                    "destroyed at end of round",
                    "{C:inactive}(It's own probability can't change)",
                }
            },
            j_baga_tremor = {
                name = "{C:baga_tremor_bat}Tremor",
                text = {
                    "{C:green}#1# in number of owned",
                    "{C:green}Jokers (#2#){} chance to add",
                    "{C:dark_edition}Negative{} to a random Joker",
                    "at the end of round",
                }
            },
            j_baga_frozen = {
                name = "{C:baga_frozen_ice}Frozen",
                text = {
                    "Makes the Joker",
                    "to the left {C:attention}Frozen",
                    "at the start of round"
                }
            },
            j_baga_clouded = {
                name = "{C:baga_clouded_lightning}Clouded",
                text = {
                    "Each owned Joker adds",
                    "{X:mult,C:white}1X-5X{} Mult to this card",
                    "based on its rarity",
                    "{C:inactive}(Currently {X:mult,C:white}#1#X{C:inactive} Mult)"
                }
            },
        },
        Other = {
            baga_frozen = {
                name = "Frozen",
                text = {
                    "Freezes round-based",
                    "Jokers and Stickers",
                    "for {C:attention}#1#{} round"
                }
            }
        },
        Planet = {
            c_pluto = {
                name = "UP"
            }
        },
        Spectral = {
            c_baga_lethal = {
                name = "Lethal",
                text = {
                    "Destroys up to",
                    "{C:attention}#1#{} selected cards",
                }
            },
            c_baga_dig = {
                name = "Dig",
                text = {
                    "Creates a {C:baga_ghost,E:1}Ghost{} Joker",
                    "{C:inactive}(Must have room)",
                }
            }
        },
        Tarot = {
            c_baga_lotus = {
                name = "The Lotus",
                text = {
                    "Create {C:attention}#1#{} copy of",
                    "{C:attention}#2#{} selected card",
                    "in your hand",
                }
            },
            c_baga_ripped = {
                name = "The Ripped",
                text = {
                    "Destroys a {C:attention}random Joker{} and",
                    "gives {X:money,C:white}#1#X{} of its sell price"
                }
            }
        },
        Voucher = {
            v_baga_glory = {
                name = "Glory",
                text = {
                    "{C:attention}+#1#{} Ante,",
                    "{C:dark_edition}-#2#{} Joker Slot",
                }
            },
            v_baga_victory = {
                name = "Victory",
                text = {
                    "{C:dark_edition}+#1#{} Joker Slots",
                }
            },
        }
    },
    
    misc = {
        dictionary = {
            k_baga_ghost = "Ghost",
            k_different_face_cards = "Different Face Cards",
            k_fragile_card = "Card of Me",
            k_frozen = "Frozen!",
            k_lost = "Lost!",
            k_unfrozen = "Unfrozen!",
            k_to_infinity = "Went To Infinity!",
        },
        labels = {
            baga_ghost = "Ghost",
            baga_frozen = "Frozen"
        }
    }
}