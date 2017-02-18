GM.Name = "Battle Royale"
GM.Author = "Sir Francis Billard"
GM.Email = "sirfrancisbillard@gmail.com"
GM.Website = "https://github.com/SirFrancisBillard/battle-royale"

DeriveGamemode("sandbox")

include("sh_config.lua")

sound.Add({
	name = "Bullet_Impact.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {95, 110},
	sound = "rust/headshot.wav"
})

function GM:Initialize()
	-- this seems like a fucking stupid idea
	-- but TFA won't get off his ass and fix
	-- his shit, so I have to hide the errors
	-- his shitty addon creates
	hook.Remove("DrawOverlay", "MenuDrawLuaErrors")
	-- jk bby I love you and your addons but
	-- please accept a PR or two to fix this

	if SERVER then
		local function RegenPlayers()
			for k, v in pairs(self.RegenPlayers) do
				if v and IsValid(k) and k:IsPlayer() and k:Alive() and k:GetNWInt("br_perk", PERK_NONE) == PERK_REGEN and k:Health() < k:GetMaxHealth() then
					k:SetHealth(math.Clamp(k:Health() + 5, 0, k:GetMaxHealth()))
				end
			end
		end
		timer.Create("br_regentimer", 5, 0, RegenPlayers)
	end
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
