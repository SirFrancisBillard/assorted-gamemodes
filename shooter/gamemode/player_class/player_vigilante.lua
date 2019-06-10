DEFINE_BASECLASS("player_citizen")

local PLAYER = {}

PLAYER.DisplayName = "Vigilante"
PLAYER.WalkSpeed = 120
PLAYER.RunSpeed = 200

function PLAYER:Loadout()
	self.Player:StripWeapons()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_hands")
	self.Player:Give("shooter_revolver")
	self.Player:GiveAmmo(9999, "pistol")
end

local VigiModels = {"models/player/barney.mdl"}

function PLAYER:SetModel()
	local modelname = VigiModels[math.random(#VigiModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(math.random(2) - 1, math.random(2) - 1, math.random(2) - 1))
end

function PLAYER:Spawn()
	self:SetModel()
	self:Loadout()

	self.Player:SetWalkSpeed(self.WalkSpeed)
	self.Player:SetRunSpeed(self.RunSpeed)

	self.Player:SetMaxHealth(120)
	self.Player:SetHealth(120)

	self.Player:SetSpecialClass(CLASS_NULL)
end

player_manager.RegisterClass("player_vigilante", PLAYER, "player_citizen")
