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
        Enhanced = {
            m_baga_wounded = {
                name = "Wounded Card",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "-{X:mult,C:white}X#2#{} every trigger",
                    "Destroyed when {X:mult,C:white}Xmult{}",
                    "reaches 1"
                },
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
                    "{C:inactive}(ex: {C:attention}J Q, Q K{C:inactive})",
                }
            },
            j_baga_fragile = {
                name = "Fragile",
                text = {
                    "All played {C:attention}face{} cards",
                    "become {C:attention}Wounded{} cards",
                    "when scored",
                }
            },
            j_baga_misery = {
                name = "Misery",
                text = {
                    "Each {C:attention}face{} card held",
                    "in hand adds {X:mult,C:white}X#1#{} Mult"
                }
            },
            -- Rares

            j_baga_flutter = {
                name = "Flutter",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "for every {C:attention}destroyed{} card, resets",
                    "when {C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                }
            },
            j_baga_lost = {
                name = "Lost",
                text = {
                    "Destroys {C:attention}2 random{} cards",
                    "held in hand at",
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
                    "Freezes values of round-based",
                    "Jokers and Stickers",
                    "for {C:attention}#1#{} round"
                }
            }
        },
        Planet = {
            c_pluto = {
                name = "UP",
                text = {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips"
                }
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
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}#2#",
                }
            }
        }
    },
    
    misc = {
        dictionary = {
            k_baga_ghost = "Ghost"
        },
        labels = {
            baga_ghost = "Ghost",
            baga_frozen = "Frozen"
        }
    }
}