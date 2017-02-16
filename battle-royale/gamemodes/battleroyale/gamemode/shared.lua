GM.Name = "Battle Royale"
GM.Author = "Sir Francis Billard"
GM.Email = "bgambla69@muslim.kz"
GM.Website = "furryhub.co.uk"

DeriveGamemode("sandbox")

-- Perk enums
PERK_NONE = 0
PERK_PSYCHO = 1
PERK_MASKSMAN = 2
PERK_BOXER = 3
PERK_RAGE = 4
PERK_CANNIBAL = 5
PERK_LOOTER = 6

function GM:Initialize() end

function GM:KeyRelease(ply, key)
	-- should probably move this to init.lua
	-- all the code is run serverside anyway
	if SERVER and IsValid(ply) and ply:IsPlayer() and key == IN_USE then
		local tr = util.TraceLine({
			start  = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 84,
			filter = ply,
			mask   = MASK_SHOT
		});

		if tr.Hit and IsValid(tr.Entity) and tr.Entity.player_corpse then
			local perk = ply:GetNWInt("br_perk", PERK_NONE)
			if perk == PERK_CANNIBAL and ply:Health() < ply:GetMaxHealth() then
				ply:SetHealth(math.Clamp(ply:Health() + 20, 0, ply:GetMaxHealth()))
				-- ply:EmitSound("eating sound from rust or something")
				SafeRemoveEntity(tr.Entity)
			end
			if perk == PERK_LOOTER then
				for k, v in pairs(tr.Entity.loot_weapons) do
					ply:Give(v)
				end
			end
		end
	end
end
