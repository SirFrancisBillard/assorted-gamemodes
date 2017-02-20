
ENUM_CURRENT = 0

-- function similar to the one for equipment
-- in ttt, so i don't have to change each
-- number every single time i add an enum
-- that isn't at the end of the list
local function NextEnum()
	ENUM_CURRENT = ENUM_CURRENT + 1
	return ENUM_CURRENT
end

-- declare enumerations first, they don't have any dependencies
PERK_NONE = NextEnum()
PERK_ACROBAT = NextEnum()
PERK_BOXER = NextEnum()
PERK_CANNIBAL = NextEnum()
PERK_GRINDER = NextEnum()
PERK_LOOTER = NextEnum()
PERK_MARKSMAN = NextEnum()
PERK_PEACEMAKER = NextEnum()
PERK_PSYCHO = NextEnum()
PERK_QUARTERMASTER = NextEnum()
PERK_RAGE = NextEnum()
PERK_REGEN = NextEnum()

-- used for quick perk validation
-- (to be validated) < PERK_MAX
PERK_MAX = ENUM_CURRENT

-- make these the old way because they are
-- way too simple to require a function
GENDER_MALE = "male"
GENDER_FEMALE = "female"

-- soundscripts
sound.Add({
	name = "Bullet_Impact.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {95, 110},
	sound = "battle-royale/headshot.wav"
})

sound.Add({
	name = "Kevlar.Equip",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 100,
	pitch = {95, 110},
	sound = "battle-royale/armor.wav"
})

sound.Add({
	name = "Loot.Open",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 100,
	pitch = {95, 110},
	sound = "battle-royale/loot.wav"
})

local eatsounds = {}
for i = 1, 9 do
	table.insert(eatsounds, "battle-royale/food/eat" .. i .. ".wav")
end
sound.Add({
	name = "Food.Eat",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {95, 110},
	sound = eatsounds
})

local blocksounds = {}
for i = 1, 3 do
	table.insert(blocksounds, "physics/concrete/concrete_impact_hard" .. i .. ".wav")
end
sound.Add({
	name = "Block.Place",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {95, 110},
	sound = blocksounds
})

local breaksounds = {}
for i = 2, 3 do
	table.insert(breaksounds, "physics/concrete/concrete_break" .. i .. ".wav")
end
sound.Add({
	name = "Block.Break",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 200,
	pitch = {95, 110},
	sound = breaksounds
})

GM.PerkInfo = {
	[PERK_NONE] = {
		name = "None",
		desc = "No perk selected"
	},
	[PERK_ACROBAT] = {
		name = "Acrobat",
		desc = "Take very little fall damage"
	},
	[PERK_BOXER] = {
		name = "Boxer",
		desc = "Deal more damage with fists."
	},
	[PERK_CANNIBAL] = {
		name = "Cannibal",
		desc = "Eat corpses to regain health." -- fuckin' metal
	},
	[PERK_GRINDER] = {
		name = "Grinder",
		desc = "Gain 25% of damage dealt as armor."
	},
	[PERK_LOOTER] = {
		name = "Looter",
		desc = "Receive better loot more often."
	},
	[PERK_MARKSMAN] = {
		name = "Marksman",
		desc = "Deal more damage with headshots."
	},
	[PERK_PEACEMAKER] = {
		name = "Peacemaker",
		desc = "Deal more damage with pistols."
	},
	[PERK_PSYCHO] = {
		name = "Psycho",
		desc = "Deal more damage with blades."
	},
	[PERK_QUARTERMASTER] = {
		name = "Quartermaster",
		desc = "Spawn with nearly infinite ammo."
	},
	[PERK_RAGE] = {
		name = "Rage",
		desc = "Deal more damage the more you are injured."
	},
	[PERK_REGEN] = {
		name = "Regen",
		desc = "Automatically heal when on low health."
	}
}

-- general configuration
GM.Config = {
	LootcrateCooldown = 60,
	CorpseDespawnTime = 60,
}

-- stuff everybody spawns with
GM.DefaultWeapons = {
	["weapon_fists"] = true,
	["weapon_buildingtool"] = true
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

		["ent_kevlar"] = true,
		["ent_kevlar"] = true,
		["ent_kevlar"] = true,

		["weapon_moddingkit"] = true,
		["weapon_moddingkit"] = true
	},
	Okay = {
		["tfa_nmrih_tnt"] = true,
		["tfa_nmrih_mp5"] = true,
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

		["ent_kevlar"] = true,
		["ent_kevlar"] = true,
		["ent_kevlar"] = true,

		["ent_ammobox"] = true,
		["ent_ammobox"] = true,
		["ent_ammobox"] = true,

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
		["tfa_nmrih_mp5"] = true,
		["tfa_nmrih_870"] = true
	}
}

-- weapon types
GM.WeaponTypes = {
	Blades = {
		["tfa_nmrih_asaw"] = true,
		["tfa_nmrih_chainsaw"] = true,
		["tfa_nmrih_cleaver"] = true,
		["tfa_nmrih_kknife"] = true,
		["tfa_nmrih_hatchet"] = true,
		["tfa_nmrih_machete"] = true,
		["tfa_nmrih_fireaxe"] = true
	},
	Pistols = {
		["tfa_nmrih_asaw"] = true,
		["tfa_nmrih_chainsaw"] = true,
		["tfa_nmrih_cleaver"] = true,
		["tfa_nmrih_kknife"] = true,
		["tfa_nmrih_hatchet"] = true,
		["tfa_nmrih_machete"] = true,
		["tfa_nmrih_fireaxe"] = true
	},
	Melee = {
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
		["tfa_nmrih_wrench"] = true
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

-- upgrade levels on blocks
GM.UpgradeLevels = {
	[1] = {
		name = "Scaffold",
		cost = 10,
		health = 20,
		mat = ""
	},
	[2] = {
		name = "Wood",
		cost = 75,
		health = 200,
		mat = "phoenix_storms/wood"
	},
	[3] = {
		name = "Stone",
		cost = 200,
		health = 500,
		mat = "brick/brick_model"
	},
	[4] = {
		name = "Sheet Metal",
		cost = 500,
		health = 1000,
		mat = "models/props_pipes/GutterMetal01a"
	},
	[5] = {
		name = "Armored",
		cost = 1000,
		health = 5000,
		mat = "phoenix_storms/dome"
	}
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

-- hurt sounds
GM.HurtSounds = {
	[HITGROUP_HEAD] = {
		Sound("physics/flesh/flesh_squishy_impact_hard1.wav"),
		Sound("physics/flesh/flesh_squishy_impact_hard2.wav"),
		Sound("physics/flesh/flesh_squishy_impact_hard3.wav"),
		Sound("physics/flesh/flesh_squishy_impact_hard4.wav")
	},
	[GENDER_MALE] = {
		["generic"] = {
			Sound("vo/npc/male01/pain01.wav"),
			Sound("vo/npc/male01/pain02.wav"),
			Sound("vo/npc/male01/pain03.wav"),
			Sound("vo/npc/male01/pain04.wav"),
			Sound("vo/npc/male01/pain05.wav"),
			Sound("vo/npc/male01/pain06.wav"),
			Sound("vo/npc/male01/pain07.wav"),
			Sound("vo/npc/male01/pain08.wav"),
			Sound("vo/npc/male01/pain09.wav"),
			Sound("vo/ravenholm/monk_pain01"),
			Sound("vo/ravenholm/monk_pain02"),
			Sound("vo/ravenholm/monk_pain03"),
			Sound("vo/ravenholm/monk_pain04"),
			Sound("vo/ravenholm/monk_pain05"),
			Sound("vo/ravenholm/monk_pain06"),
			Sound("vo/ravenholm/monk_pain07"),
			Sound("vo/ravenholm/monk_pain08"),
			Sound("vo/ravenholm/monk_pain09"),
			Sound("vo/ravenholm/monk_pain10"),
			Sound("vo/ravenholm/monk_pain12"),
			Sound("vo/npc/male01/moan01.wav"),
			Sound("vo/npc/male01/moan02.wav"),
			Sound("vo/npc/male01/moan03.wav"),
			Sound("vo/npc/male01/moan04.wav"),
			Sound("vo/npc/male01/moan05.wav")
		},
		[HITGROUP_LEFTARM] = {
			Sound("vo/npc/male01/myarm01.wav"),
			Sound("vo/npc/male01/myarm02.wav")
		},
		[HITGROUP_LEFTLEG] = {
			Sound("vo/npc/male01/myleg01.wav"),
			Sound("vo/npc/male01/myleg02.wav")
		},
		[HITGROUP_STOMACH] = {
			Sound("vo/npc/male01/mygut02.wav"),
			Sound("vo/npc/male01/hitingut01.wav"),
			Sound("vo/npc/male01/hitingut02.wav")
		}
	},
	[GENDER_FEMALE] = {
		["generic"] = {
			Sound("vo/npc/female01/pain01.wav"),
			Sound("vo/npc/female01/pain02.wav"),
			Sound("vo/npc/female01/pain03.wav"),
			Sound("vo/npc/female01/pain04.wav"),
			Sound("vo/npc/female01/pain05.wav"),
			Sound("vo/npc/female01/pain06.wav"),
			Sound("vo/npc/female01/pain07.wav"),
			Sound("vo/npc/female01/pain08.wav"),
			Sound("vo/npc/female01/pain09.wav"),
			Sound("vo/npc/female01/moan01.wav"),
			Sound("vo/npc/female01/moan02.wav"),
			Sound("vo/npc/female01/moan03.wav"),
			Sound("vo/npc/female01/moan04.wav"),
			Sound("vo/npc/female01/moan05.wav")
		},
		[HITGROUP_LEFTARM] = {
			Sound("vo/npc/female01/myarm01.wav"),
			Sound("vo/npc/female01/myarm02.wav")
		},
		[HITGROUP_LEFTLEG] = {
			Sound("vo/npc/female01/myleg01.wav"),
			Sound("vo/npc/female01/myleg02.wav")
		},
		[HITGROUP_STOMACH] = {
			Sound("vo/npc/female01/mygut02.wav"),
			Sound("vo/npc/female01/hitingut01.wav"),
			Sound("vo/npc/female01/hitingut02.wav")
		}
	}
}

GM.HurtSounds[GENDER_MALE][HITGROUP_RIGHTARM] = GM.HurtSounds[GENDER_MALE][HITGROUP_LEFTARM]
GM.HurtSounds[GENDER_MALE][HITGROUP_RIGHTLEG] = GM.HurtSounds[GENDER_MALE][HITGROUP_LEFTLEG]

GM.HurtSounds[GENDER_FEMALE][HITGROUP_RIGHTARM] = GM.HurtSounds[GENDER_FEMALE][HITGROUP_LEFTARM]
GM.HurtSounds[GENDER_FEMALE][HITGROUP_RIGHTLEG] = GM.HurtSounds[GENDER_FEMALE][HITGROUP_LEFTLEG]

-- player models
GM.PlayerModels = {
	-- minihack:
	-- seperate groups of similar models into
	-- tables so they don't have a huge chance
	-- of being picked over other models
	{
		gender = GENDER_MALE,
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
		gender = GENDER_FEMALE,
		"models/player/Group03/Female_01.mdl",
		"models/player/Group03/Female_02.mdl",
		"models/player/Group03/Female_03.mdl",
		"models/player/Group03/Female_04.mdl",
		"models/player/Group03/Female_06.mdl"
	},
	{
		gender = GENDER_MALE,
		"models/player/arctic.mdl",
		"models/player/guerilla.mdl",
		"models/player/leet.mdl",
		"models/player/phoenix.mdl"
	},
	{
		gender = GENDER_FEMALE,
		"models/player/alyx.mdl"
	},
	{
		gender = GENDER_MALE,
		"models/player/eli.mdl"
	},
	{
		gender = GENDER_MALE,
		"models/player/magnusson.mdl"
	},
	{
		gender = GENDER_MALE,
		"models/player/monk.mdl"
	}
}
