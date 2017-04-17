DEFINE_BASECLASS("player_prisonbase")

local PLAYER = {}

PLAYER.DisplayName = "Criminal"
PLAYER.WalkSpeed = 150
PLAYER.RunSpeed = 250

local CriminalModels = {"models/player/alyx.mdl", "models/player/eli.mdl", "models/player/p2_chell.mdl", "models/player/monk.mdl", "models/player/kleiner.mdl"}

function PLAYER:SetModel()
	local modelname = CriminalModels[math.random(#CriminalModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0, 0))
end

player_manager.RegisterClass("player_criminal", PLAYER, "player_prisonbase")