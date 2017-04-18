DEFINE_BASECLASS("player_default")

local PLAYER = {}

PLAYER.DisplayName = "Citizen"
PLAYER.WalkSpeed = 150
PLAYER.RunSpeed = 250

function PLAYER:Loadout()
	self.Player:RemoveAllAmmo()

	self.Player:Give("prison_fists")
end

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Bool", 0, "HasKeycard")
	self.Player:NetworkVar("Entity", 0, "OwnedVehicle")
end

function PLAYER:Spawn()
	self.Player:SetHasKeycard(false)

	self:SetModel()
	self.Player:SetupHands()

	self.Player:SetWalkSpeed(150)
	self.Player:SetRunSpeed(250)
end

player_manager.RegisterClass("player_prisonbase", PLAYER, "player_default")
