DEFINE_BASECLASS("player_prisonbase")

local PLAYER = {}

PLAYER.DisplayName = "Criminal"

local CriminalModels = {"models/player/alyx.mdl", "models/player/eli.mdl", "models/player/p2_chell.mdl", "models/player/monk.mdl", "models/player/kleiner.mdl"}

function PLAYER:SetModel()
	local modelname = CriminalModels[math.random(#CriminalModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0, 0))
	self.Player:SetupHands()
end

player_manager.RegisterClass("player_criminal", PLAYER, "player_prisonbase")