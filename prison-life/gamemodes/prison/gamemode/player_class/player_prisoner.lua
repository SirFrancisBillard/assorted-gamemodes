DEFINE_BASECLASS("player_prisonbase")

local PLAYER = {}

PLAYER.DisplayName = "Prisoner"
PLAYER.WalkSpeed = 150
PLAYER.RunSpeed = 250

local PrisonerModels = {}

for i = 1, 9 do
	PrisonerModels[#PrisonerModels + 1] = "models/player/Group01/male_0" .. i .. ".mdl"
end

function PLAYER:SetModel()
	local modelname = PrisonerModels[math.random(#PrisonerModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0.565, 0))
end

player_manager.RegisterClass("player_prisoner", PLAYER, "player_prisonbase")