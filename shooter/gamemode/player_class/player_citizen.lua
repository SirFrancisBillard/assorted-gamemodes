DEFINE_BASECLASS("player_default")

local PLAYER = {}

PLAYER.DisplayName = "Citizen"
PLAYER.WalkSpeed = 150
PLAYER.RunSpeed = 250

CLASS_EMOBITCH = 1
CLASS_FATASS = 2
CLASS_VIRGIN = 3
CLASS_THOT = 4
CLASS_BLACK = 5

gCitizenClasses = {
	[CLASS_EMOBITCH] = {
		models = {"models/player/p2_chell.mdl"},
		weps = {"weapon_selfharm"},
	},
	[CLASS_FATASS] = {
		models = {"models/player/monk.mdl"},
		weps = {"weapon_eatfood"},
	},
	[CLASS_VIRGIN] = {
		models = {"models/player/kleiner.mdl"},
		weps = {"weapon_melon"},
	},
	[CLASS_THOT] = {
		models = {"models/player/alyx.mdl"},
		weps = {"weapon_thotphone"},
	},
	[CLASS_BLACK] = {
		models = {"models/player/eli.mdl"},
		weps = {"weapon_glocknig"},
	},
}

function PLAYER:Loadout()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_hands")
end

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Int", 0, "SpecialClass")
end

function PLAYER:SetModel(modelname)
	local modelname = CitizenModels[math.random(#ShooterModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0, 0))
	self.Player:SetupHands()
end

function PLAYER:Spawn()
	self:SetModel()

	self.Player:SetWalkSpeed(150)
	self.Player:SetRunSpeed(250)
end

player_manager.RegisterClass("player_citizen", PLAYER, "player_default")
