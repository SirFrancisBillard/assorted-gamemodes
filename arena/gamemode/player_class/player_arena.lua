DEFINE_BASECLASS("player_default")

local PLAYER = {}

PLAYER.DisplayName = "Player"
PLAYER.WalkSpeed = 250
PLAYER.RunSpeed = 250

function PLAYER:Loadout()
	self.Player:StripWeapons()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_handgun")
	self.Player:SelectWeapon("weapon_handgun")
end

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Int", 0, "Kevlar")
	self.Player:NetworkVar("Int", 1, "Killstreak")
end

function PLAYER:Spawn()
	self.Player:SetKevlar(0)
	self.Player:SetKillstreak(0)

	self.Player:SetCanZoom(false)
	self.Player:SetNoCollideWithTeammates(false)

	self:SetModel()

	self.Player:SetWalkSpeed(self.WalkSpeed)
	self.Player:SetRunSpeed(self.RunSpeed)
end

function PLAYER:SetModel()
	local mdl_choice = GAMEMODE.PlayerModels[math.random(1, #GAMEMODE.PlayerModels)]
	self.Player:SetModel(mdl_choice[math.random(1, #mdl_choice)])
	self.Player.model_table = mdl_choice
end

player_manager.RegisterClass("player_arena", PLAYER, "player_default")
