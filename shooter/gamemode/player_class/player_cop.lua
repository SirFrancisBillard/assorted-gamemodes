DEFINE_BASECLASS("player_citizen")

local PLAYER = {}

PLAYER.DisplayName = "Cop"

function PLAYER:Loadout()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_hands")
	self.Player:Give("weapon_taser")
	self.Player:Give("lite_beretta")
	self.Player:GiveAmmo(9999, "pistol")
end

local CopModels = {"models/player/gasmask.mdl", "models/player/riot.mdl", "models/player/swat.mdl", "models/player/urban.mdl"}

function PLAYER:SetModel()
	local modelname = CopModels[math.random(#CopModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(0, 0, 1))
end

function PLAYER:Spawn()
	self.Player:SetHasKeycard(true)

	self:SetModel()

	self.Player:SetWalkSpeed(150)
	self.Player:SetRunSpeed(250)
end

player_manager.RegisterClass("player_cop", PLAYER, "player_citizen")
