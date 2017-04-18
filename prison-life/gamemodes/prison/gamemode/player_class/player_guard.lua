DEFINE_BASECLASS("player_prisonbase")

local PLAYER = {}

PLAYER.DisplayName = "Guard"

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
	self.Player:SetupHands()
end

function PLAYER:Spawn()
	self.Player:SetHasKeycard(false)

	self:SetModel()
	self.Player:SetupHands()

	self.Player:SetWalkSpeed(150)
	self.Player:SetRunSpeed(250)
end

player_manager.RegisterClass("player_guard", PLAYER, "player_prisonbase")
