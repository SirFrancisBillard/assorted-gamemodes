DEFINE_BASECLASS("player_citizen")

local PLAYER = {}

PLAYER.DisplayName = "Cop"
PLAYER.WalkSpeed = 120
PLAYER.RunSpeed = 200

function PLAYER:Loadout()
	self.Player:StripWeapons()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_hands")
	self.Player:Give("shooter_deagle")
	self.Player:GiveAmmo(9999, "pistol")
	self.Player:Give("shooter_mp5")
	self.Player:GiveAmmo(9999, "smg1")
end

local CopModels = {"models/player/gasmask.mdl", "models/player/riot.mdl", "models/player/swat.mdl", "models/player/urban.mdl"}

function PLAYER:SetModel()
	local modelname = CopModels[math.random(#CopModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(0, 0, 1))
end

function PLAYER:Spawn()
	self:SetModel()

	self.Player:SetWalkSpeed(self.WalkSpeed)
	self.Player:SetRunSpeed(self.RunSpeed)

	self.Player:SetMaxHealth(120)
	self.Player:SetHealth(120)
end

player_manager.RegisterClass("player_cop", PLAYER, "player_citizen")
