DEFINE_BASECLASS("player_citizen")

local PLAYER = {}

PLAYER.DisplayName = "Security Guard"
PLAYER.WalkSpeed = 120
PLAYER.RunSpeed = 200

function PLAYER:Loadout()
	self.Player:StripWeapons()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_hands")
	if math.random(3) == 1 then
		self.Player:Give("shooter_revolver")
	else
		self.Player:Give("shooter_pistol")
	end
	self.Player:GiveAmmo(9999, "pistol")
end

local GuardModels = {"models/player/odessa.mdl"} --, "models/player/mossman_arctic.mdl"}

function PLAYER:SetModel()
	local modelname = GuardModels[math.random(#GuardModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(0, 0, 1))
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

player_manager.RegisterClass("player_guard", PLAYER, "player_citizen")
