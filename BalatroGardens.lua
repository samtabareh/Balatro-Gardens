-- Balatro Gardens

BalatroGardens = BalatroGardens or {}
BalatroGardens.mod_path = ""..SMODS.current_mod.path

-- Digs Ghost

local gaup_ref = Game.update
function Game:update(dt)
	gaup_ref(self, dt)
	if not G.SETTINGS.paused and G.ASSET_ATLAS["baga_Consumables"] and
    BalatroGardens and not BalatroGardens.ghost then
        BalatroGardens.ghost = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["baga_Consumables"], { x = 2, y = 1 })
    end
end



-- Frozen Sticker

BalatroGardens.freezable_jokers = {
        "The Idol",
        "Ancient Joker",
        "Castle",
        "Mail-In Rebate",
        "Invisible Joker",
        "Hit the Road",
        "Popcorn",
        "Turtle Bean",
        "Egg",
        "To Do List"
}

function is_freezable(card)
    local compatible = false
    if card then
        if card.ability.rental or card.ability.perishable then compatible = true end

        for _, joker in ipairs(BalatroGardens.freezable_jokers) do
            if compatible then break end
            if joker == card.ability.name then compatible = true end
        end
    end
    return compatible
end

function is_joker_frozen(t)
    if not G.jokers then return false end

    if t.name then
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            if joker.ability.name == t.name and joker.ability.baga_frozen then return true end
        end
        return false
    elseif t.card then return t.card.ability.baga_frozen
    else return false end
end

-- Overrides

local care_ref = Card.calculate_rental
function Card:calculate_rental()
    if is_joker_frozen({ card = self }) then return end
    care_ref(self)
end

local cape_ref = Card.calculate_perishable
function Card:calculate_perishable()
    if is_joker_frozen({ card = self }) then return end
    cape_ref(self)
end

local reid_ref = reset_idol_card
function reset_idol_card()
    if is_joker_frozen({ name = "The Idol" }) then return end
    reid_ref()
end

local rean_ref = reset_ancient_card
function reset_ancient_card()
    if is_joker_frozen({ name = "Ancient Joker" }) then return end
    rean_ref()
end

local reca_ref = reset_castle_card
function reset_castle_card()
    if is_joker_frozen({ name = "Castle" }) then return end
    reca_ref()
end

local rema_ref = reset_mail_rank
function reset_mail_rank()
    if is_joker_frozen({ name = "Mail-In Rebate" }) then return end
    rema_ref()
end

-- Load all the files
for _, file in ipairs(NFS.getDirectoryItems(BalatroGardens.mod_path.."src")) do
    assert(SMODS.load_file("src/"..file))()
end
