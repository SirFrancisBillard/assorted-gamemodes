DEFINE_BASECLASS("player_prisonbase")

local PLAYER = {}

PLAYER.DisplayName = "Criminal"

function PLAYER:Loadout()
	self.Player:RemoveAllAmmo()

	self.Player:Give("prison_fists")
	self.Player:Give("prison_lockpick")
	self.Player:Give("lite_ak47")
	self.Player:GiveAmmo(9999, "smg1")
end

local CriminalModels = {"models/player/alyx.mdl", "models/player/eli.mdl", "models/player/p2_chell.mdl", "models/player/monk.mdl", "models/player/kleiner.mdl"}

function PLAYER:SetModel()
	local modelname = CriminalModels[math.random(#CriminalModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0, 0))
	self.Player:SetupHands()
end

player_manager.RegisterClass("player_criminal", PLAYER, "player_prisonbase")
