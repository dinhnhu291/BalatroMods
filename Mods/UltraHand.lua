--- STEAMODDED HEADER

--- MOD_NAME: UltraHand Extended

--- MOD_ID: UltraHandExtended

--- MOD_AUTHOR: [Xioxin, Modified]

--- MOD_DESCRIPTION: Spawn cards/vouchers directly from collection with separate toggles.

----------------------------------------------

------------MOD CODE -------------------------

G.X_CHEAT_SETTINGS = {
    spawn = false,
    voucher_spawn = false
}
local CardClickRef = Card.click;
function Card:click()
	if G.OVERLAY_MENU then
		local _card = self;
		local center = _card.config.center;
		if G.X_CHEAT_SETTINGS.spawn then
			if _card.ability.set == 'Joker' and G.jokers then
				add_joker(_card.config.center.key)
				_card:set_sprites(_card.config.center)
			end
			if _card.ability.consumeable and G.consumeables then
				add_joker(_card.config.center.key)
				_card:set_sprites(_card.config.center)
			end
			-- Voucher Collection
            if center.set == 'Voucher' then
              if G.X_CHEAT_SETTINGS.voucher_spawn then
                local voucher_area = G.shop_vouchers or G.consumeables
                local card = SMODS.create_card({
                    set = 'Voucher',
                    key = center.key,
                    area = voucher_area,
                    skip_materialize = true,
                    allow_duplicates = true
                })
                card.shop_voucher = true
                card:redeem()
                card:remove()
                _card:set_sprites(center)
                return
              else
                unlock_card(center)
                _card:set_sprites(center)
              end
		else
			unlock_card(_card.config.center)
            _card:set_sprites(_card.config.center)
		end
	end
	CardClickRef(self)
end
-------------------------------------------------
-- Joker Collection Toggle
-------------------------------------------------
local spawnToggleLabel = 'Click on card to spawn'

local createYourCollectionJokersRef = create_UIBox_your_collection_jokers;
function create_UIBox_your_collection_jokers()
	local contents = createYourCollectionJokersRef()
	local spawn_toggle = create_toggle({label = spawnToggleLabel, ref_table = G.X_CHEAT_SETTINGS, ref_value = 'spawn'})
	table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, #contents.nodes[1].nodes[1].nodes[1].nodes + 1, spawn_toggle)
	return contents
end

local createYourCollectionTarotsRef = create_UIBox_your_collection_tarots;
function create_UIBox_your_collection_tarots()
	local contents = createYourCollectionTarotsRef()
	local spawn_toggle = create_toggle({label = spawnToggleLabel, ref_table = G.X_CHEAT_SETTINGS, ref_value = 'spawn'})
	table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, #contents.nodes[1].nodes[1].nodes[1].nodes + 1, spawn_toggle)
	return contents
end

local createYourCollectionPlanetsRef = create_UIBox_your_collection_planets;
function create_UIBox_your_collection_planets()
	local contents = createYourCollectionPlanetsRef()
	local spawn_toggle = create_toggle({label = spawnToggleLabel, ref_table = G.X_CHEAT_SETTINGS, ref_value = 'spawn'})
	table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, #contents.nodes[1].nodes[1].nodes[1].nodes + 1, spawn_toggle)
	return contents
end

local createYourCollectionSpectralsRef = create_UIBox_your_collection_spectrals;
function create_UIBox_your_collection_spectrals()
	local contents = createYourCollectionSpectralsRef()
	local spawn_toggle = create_toggle({label = spawnToggleLabel, ref_table = G.X_CHEAT_SETTINGS, ref_value = 'spawn'})
	table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, #contents.nodes[1].nodes[1].nodes[1].nodes + 1, spawn_toggle)
	return contents
end
        
-------------------------------------------------
-- Voucher Collection Toggle
-------------------------------------------------
if create_UIBox_your_collection_vouchers then
    local createYourCollectionVouchersRef =
        create_UIBox_your_collection_vouchers
    function create_UIBox_your_collection_vouchers()
        local contents = createYourCollectionVouchersRef()
        local spawn_toggle = create_toggle({
            label = 'Spawn Voucher',
            ref_table = G.X_CHEAT_SETTINGS,
            ref_value = 'voucher_spawn'
        })
        table.insert(
            contents.nodes[1].nodes[1].nodes[1].nodes,
            #contents.nodes[1].nodes[1].nodes[1].nodes + 1,
            spawn_toggle
        )
        return contents
    end
end
----------------------------------------------
------------MOD CODE END----------------------
