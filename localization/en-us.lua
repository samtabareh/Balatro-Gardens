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
            j_baga_black_lotus = {
                name = "Black Lotus",
                text = {
                    "Retrigger a {C:attention}random{} played",
                    "card used in scoring",
                    "{C:attention}#1#{} additional times"
                }
            },
            j_baga_one_on_one = {
                name = "One on One",
                text = {
                    "{C:green}#1# in #2#{} chance to make",
                    "each played {C:attention}face{} card",
                    "{C:attention}Wounded{}"
                }
            },
            j_baga_flutter = {
                name = "Flutter",
                text = {
                    "This Joker gains",
                    "{X:mult,C:white}X#1#{} Mult every time",
                    "a {C:attention}card{} is scored",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },
            j_baga_rip = {
                name = "Rip It Apart",
                text = {
                    "Destroy 1 random card",
                    "{C:attention}held in hand{} at",
                    "the end of round"
                }
            },
            j_baga_lost_inside = {
                name = "Lost Inside",
                text = {
                    "The {C:attention}first{} played card",
                    "used in scoring becomes {C:attention}Lost{}"
                }
            },
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
                    "Copies ability of {C:attention}Joker{}",
                    "to the left, debuffs",
                    "{C:attention}Joker{} to the right"
                }
            },
            j_baga_clouded = {
                name = "{C:baga_clouded_lightning}Clouded",
                text = {
                    "Each owned joker adds",
                    "{X:mult,C:white}1X-5X{} Mult to this card",
                    "based on its rarity",
                    "{C:inactive}(Currently {X:mult,C:white}#1#X{C:inactive} Mult)"
                }
            },
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
        }
    },
    
    misc = {
        dictionary = {
            k_baga_ghost = "Ghost"
        },
        labels = {
            baga_ghost = "Ghost"
        }
    }
}