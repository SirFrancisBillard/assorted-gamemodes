GM.Name = "Battle Royale"
GM.Author = "Sir Francis Billard"
GM.Email = "sirfrancisbillard@gmail.com"
GM.Website = "https://github.com/SirFrancisBillard/battle-royale"

DeriveGamemode("sandbox")

GM.LootTable = {
	Bad = {
		["tfa_nmrih_asaw"] = true,
		["tfa_nmrih_bat"] = true,
		["tfa_nmrih_chainsaw"] = true,
		["tfa_nmrih_bcd"] = true,
		["tfa_nmrih_cleaver"] = true,
		["tfa_nmrih_crowbar"] = true,
		["tfa_nmrih_zippo"] = true,
		["tfa_nmrih_etool"] = true,
		["tfa_nmrih_fireaxe"] = true,
		["tfa_nmrih_fext"] = true,
		["tfa_nmrih_fubar"] = true,
		["tfa_nmrih_hatchet"] = true,
		["tfa_nmrih_kknife"] = true,
		["tfa_nmrih_lpipe"] = true,
		["tfa_nmrih_machete"] = true,
		["tfa_nmrih_maglite"] = true,
		["tfa_nmrih_pickaxe"] = true,
		["tfa_nmrih_sledge"] = true,
		["tfa_nmrih_spade"] = true,
		["tfa_nmrih_wrench"] = true,

		["weapon_moddingkit"] = true,
		["weapon_moddingkit"] = true,
		["weapon_moddingkit"] = true
	},
	Okay = {
		["tfa_nmrih_tnt"] = true,
		["tfa_nmrih_mp5"] = true,
		["tfa_nmrih_870"] = true,
		["tfa_nmrih_rug1022"] = true,
		["tfa_nmrih_sks_nb"] = true,
		["tfa_nmrih_sako_is"] = true,
		["tfa_nmrih_sks_nb"] = true,
		["tfa_nmrih_frag"] = true,
		["tfa_nmrih_mac10"] = true,
		["tfa_nmrih_500a"] = true,

		["tfa_nmrih_m92fs"] = true,
		["tfa_nmrih_m92fs"] = true,
		["tfa_nmrih_1911"] = true,
		["tfa_nmrih_1911"] = true,
		["tfa_nmrih_sv10"] = true,
		["tfa_nmrih_sv10"] = true,
		["tfa_nmrih_mkiii"] = true,
		["tfa_nmrih_flaregun"] = true,
		["tfa_nmrih_flaregun"] = true,
		["tfa_nmrih_molotov"] = true,
		["tfa_nmrih_molotov"] = true,
		["tfa_nmrih_g17"] = true,
		["tfa_nmrih_g17"] = true,
		["tfa_nmrih_1892"] = true,
		["tfa_nmrih_1892"] = true,
		["tfa_nmrih_sw686"] = true,
		["tfa_nmrih_sw686"] = true,

		["weapon_dropgrenade"] = true,
		["weapon_dropgrenade"] = true,
		["weapon_dropgrenade"] = true
	},
	Good = {
		["tfa_nmrih_cz"] = true,
		["tfa_nmrih_m16_ch"] = true,
		["tfa_nmrih_fal"] = true,
		["tfa_nmrih_jae700"] = true,
		["tfa_nmrih_tnt"] = true,
		["tfa_nmrih_superx3"] = true
	},
}

-- Weapon types
GM.WeaponTypes = {
	Blades = {
		["tfa_nmrih_asaw"] = true,
		["tfa_nmrih_chainsaw"] = true,
		["tfa_nmrih_cleaver"] = true,
		["tfa_nmrih_kknife"] = true,
		["tfa_nmrih_hatchet"] = true,
		["tfa_nmrih_machete"] = true
	},
	Marksman = {
		["tfa_nmrih_jae700"] = true,
		["tfa_nmrih_sako"] = true,
		["tfa_nmrih_m16_rt"] = true,
		["tfa_nmrih_sw686"] = true
	}
}

-- Ammo types
GM.AmmoTypes = {
	-- bullets
	["pistol"] = 20,
	["buckshot"] = 8,
	["smg1"] = 30,
	["ar2"] = 30,
	["sniperpenetratedround"] = 10,
	-- irregular
	["nmrih_flare"] = 6,
	["gasoline"] = 400,
	["tnt"] = 2,
	["frag"] = 4,
	["molly"] = 4,
	["co2"] = 400,
	["propane"] = 400,
	["lighter"] = 1
}

-- Guns that can be modded
GM.ModdableGuns = {
	-- scopes
	["tfa_nmrih_m16_ch"] = "tfa_nmrih_m16_rt",
	["tfa_nmrih_sako_is"] = "tfa_nmrih_sako",
	-- extended mags
	["tfa_nmrih_rug1022"] = "tfa_nmrih_rug1022_25",
	-- bayonet
	["tfa_nmrih_sks_nb"] = "tfa_nmrih_sks",
}

-- Player models
GM.PlayerModels = {
	"models/player/Group03/Female_01.mdl",
	"models/player/Group03/Female_02.mdl",
	"models/player/Group03/Female_03.mdl",
	"models/player/Group03/Female_04.mdl",
	"models/player/Group03/Female_06.mdl",
	"models/player/group03/male_01.mdl",
	"models/player/Group03/Male_02.mdl",
	"models/player/Group03/male_03.mdl",
	"models/player/Group03/Male_04.mdl",
	"models/player/Group03/Male_05.mdl",
	"models/player/Group03/Male_06.mdl",
	"models/player/Group03/Male_07.mdl",
	"models/player/Group03/Male_08.mdl",
	"models/player/Group03/Male_09.mdl"
}

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
