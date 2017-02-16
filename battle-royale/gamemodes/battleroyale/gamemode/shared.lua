GM.Name = "Battle Royale"
GM.Author = "Sir Francis Billard"
GM.Email = "sirfrancisbillard@gmail.com"
GM.Website = "https://github.com/SirFrancisBillard/battle-royale"

DeriveGamemode("sandbox")

include("sh_config.lua")

-- Perk enums
PERK_NONE = 1
PERK_BOXER = 2
PERK_CANNIBAL = 3
PERK_GRINDER = 4
PERK_LOOTER = 5
PERK_MASKSMAN = 6
PERK_PSYCHO = 7
PERK_RAGE = 8

function GM:Initialize()
	-- this seems like a fucking stupid idea
	-- but TFA won't get off his ass and fix
	-- his shit, so I have to hide the errors
	-- his shitty addon creates
	hook.Remove("MenuDrawLuaErrors")
	-- jk bby I love you and your addons but
	-- please accept a PR or two to fix this
end

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
				if tr.Entity.is_looted then
					ply:ChatPrint("There is nothing on this corpse.")
					return
				end
				tr.Entity.is_looted = true
				ply:SetArmor(math.min(ply:Armor() + tr.Entity.loot_armor))
				for k, v in pairs(tr.Entity.loot_weapons) do
					ply:Give(v)
				end
				for k, v in pairs(tr.Entity.loot_ammo) do
					ply:GiveAmmo(v, k)
				end
			end
		end
	end
end

function GM:CanProperty(ply, property, ent)
	return ply:IsAdmin()
end
