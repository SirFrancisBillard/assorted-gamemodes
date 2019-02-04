DEFINE_BASECLASS("player_prisonbase")

local PLAYER = {}

PLAYER.DisplayName = "Prisoner"

local PrisonerModels = {}

for i = 1, 9 do
	PrisonerModels[#PrisonerModels + 1] = "models/player/Group01/male_0" .. i .. ".mdl"
end

function PLAYER:SetModel()
	local modelname = PrisonerModels[math.random(#PrisonerModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0.6, 0))
	self.Player:SetupHands()
end

player_manager.RegisterClass("player_prisoner", PLAYER, "player_prisonbase")