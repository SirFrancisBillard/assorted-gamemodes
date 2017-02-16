
GM.Config = {
	LootcrateCooldown = 60,
	CorpseDespawnTime = 60,
}

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
	-- scope
	["tfa_nmrih_m16_ch"] = "tfa_nmrih_m16_rt",
	["tfa_nmrih_sako_is"] = "tfa_nmrih_sako",
	-- extended mag
	["tfa_nmrih_rug1022"] = "tfa_nmrih_rug1022_25",
	-- bayonet (why tho)
	["tfa_nmrih_sks_nb"] = "tfa_nmrih_sks",
}

-- Player models (HL2 rebels for now)
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
