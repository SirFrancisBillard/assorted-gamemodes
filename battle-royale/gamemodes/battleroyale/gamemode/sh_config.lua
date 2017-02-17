
ENUM_CURRENT = 1

-- function similar to the one for equipment
-- in ttt, so i don't have to change each
-- number every single time i add an enum
-- that isn't at the end of the list
local function NextEnum()
	return ENUM_CURRENT
	ENUM_CURRENT = ENUM_CURRENT + 1
end

-- declare enumerations first, they don't
-- have any dependencies
PERK_NONE = NextEnum()
PERK_ACROBAT = NextEnum()
PERK_BOXER = NextEnum()
PERK_CANNIBAL = NextEnum()
PERK_GRINDER = NextEnum()
PERK_LOOTER = NextEnum()
PERK_MARKSMAN = NextEnum()
PERK_PSYCHO = NextEnum()
PERK_RAGE = NextEnum()

-- used for quick perk validation
-- (to be validated) < PERK_MAX
PERK_MAX = ENUM_CURRENT

GM.PerkInfo = {
	PERK_NONE = {
		name = "None",
		desc = "No perk selected"
	},
	PERK_BOXER = {
		name = "Boxer",
		desc = "Deal more damage with fists."
	},
	PERK_CANNIBAL = {
		name = "Cannibal",
		desc = "Eat corpses to regain health." -- fuckin' metal
	},
	PERK_GRINDER = {
		name = "Grinder",
		desc = "Gain 25% of damage dealt as armor."
	},
	PERK_LOOTER = {
		name = "Looter",
		desc = "Loot corpses for their weapons and equipment."
	},
	PERK_MARKSMAN = {
		name = "Marksman",
		desc = "Deal more damage with DMRs and revolvers."
	},
	PERK_PSYCHO = {
		name = "Psycho",
		desc = "Deal more damage with blades."
	},
	PERK_RAGE = {
		name = "Rage",
		desc = "Deal more damage the more you are injured."
	}
}

-- general configuration
GM.Config = {
	LootcrateCooldown = 60,
	CorpseDespawnTime = 60,
}

-- stuff you can get from containers
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
		["tfa_nmrih_superx3"] = true,
		["tfa_nmrih_m92fs"] = true,
		["tfa_nmrih_mp5"] = true
	},
}

-- weapon types
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

-- ammo types
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

-- guns that can be modded
GM.ModdableGuns = {
	-- scope
	["tfa_nmrih_m16_ch"] = "tfa_nmrih_m16_rt",
	["tfa_nmrih_sako_is"] = "tfa_nmrih_sako",

	-- extended mag
	["tfa_nmrih_rug1022"] = "tfa_nmrih_rug1022_25",

	-- bayonet (why tho)
	["tfa_nmrih_sks_nb"] = "tfa_nmrih_sks",
}

-- player models
GM.PlayerModels = {
	-- minihack:
	-- seperate groups of similar models into
	-- tables so they don't have a huge chance
	-- of being picked over other models
	{
		"models/player/group03/male_01.mdl",
		"models/player/Group03/Male_02.mdl",
		"models/player/Group03/male_03.mdl",
		"models/player/Group03/Male_04.mdl",
		"models/player/Group03/Male_05.mdl",
		"models/player/Group03/Male_06.mdl",
		"models/player/Group03/Male_07.mdl",
		"models/player/Group03/Male_08.mdl",
		"models/player/Group03/Male_09.mdl"
	},
	{
		-- less female models, sexism smh
		"models/player/Group03/Female_01.mdl",
		"models/player/Group03/Female_02.mdl",
		"models/player/Group03/Female_03.mdl",
		"models/player/Group03/Female_04.mdl",
		"models/player/Group03/Female_06.mdl"
	},
	{
		"models/player/arctic.mdl",
		"models/player/guerilla.mdl",
		"models/player/leet.mdl",
		"models/player/phoenix.mdl"
	},
	{
		"models/player/dod_american.mdl",
		"models/player/dod_german.mdl"
	},
	"models/player/alyx.mdl",
	"models/player/eli.mdl",
	"models/player/magnusson.mdl",
	"models/player/monk.mdl"
}
