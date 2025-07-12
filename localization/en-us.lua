return {
    descriptions = {
        Back = {
            b_baga_infinite_tremors = {
                name = "Infinite Tremors Deck",
                text = {
                    "Start run with",
                    "{C:baga_infinity_ring}Infinity{} and {C:baga_tremor_bat}Tremor"
                }
            },
            b_baga_frozen_clouds = {
                name = "Frozen Clouds Deck",
                text = {
                    "Start run with",
                    "{C:baga_frozen_ice}Frozen{} and {C:baga_clouded_lightning}Clouded",
                    "{C:red}X#1#{} base Blind size"
                }
            },
            b_baga_fluttering_petals = {
                name = "Fluttering Petals Deck",
                text = {
                    "Start run with",
                    "{C:rare}Flutter{} and {C:uncommon}Black Lotus"
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
            },
            m_baga_lost = {
                name = "Lost Card",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "upgrade played hand level",
                    "{C:green}#1# in #3#{} chance to",
                    "be destroyed",
                    "no rank or suit"
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
                    "{C:green}#1# in #2#{} chance to",
                    "add {C:dark_edition}Polychrome{} or {C:dark_edition}Negative",
                    "to a random joker at",
                    "the end of round",
                }
            },
            j_baga_frozen = {
                name = "{C:baga_frozen_ice}Frozen",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "add your highest mult",
                    "of the round to {C:mult}mult",
                    "{C:inactive}(Currently: {C:mult}+#3#{}{C:inactive})"
                }
            },
            j_baga_clouded = {
                name = "{C:baga_clouded_lightning}Clouded",
                text = {
                    "{X:baga_clouded_cloud,V:1,E:1,s:1.1}CLOUDED"
                    --,"{C:green}#1# in #2#{} chance to",
                    --"multiply (if not, add)",
                    --"#3#% to #4#% of blind to mult"
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