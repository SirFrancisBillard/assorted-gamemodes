DEFINE_BASECLASS("player_prisonbase")

local PLAYER = {}

PLAYER.DisplayName = "Guard"
PLAYER.WalkSpeed = 150
PLAYER.RunSpeed = 250

function PLAYER:Loadout()
	self.Player:RemoveAllAmmo()

	self.Player:Give("prison_fists")
	self.Player:Give("prison_glock")
	self.Player:Give("prison_cuffs")
	self.Player:Give("prison_taser")
end

local CopModels = {"models/player/gasmask.mdl", "models/player/riot.mdl", "models/player/swat.mdl", "models/player/urban.mdl"}

function PLAYER:SetModel()
	local modelname = CopModels[math.random(#CopModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(0, 0, 1))
end

player_manager.RegisterClass("player_guard", PLAYER, "player_prisonbase")