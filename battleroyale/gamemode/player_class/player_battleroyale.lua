DEFINE_BASECLASS("player_default")

local PLAYER = {}

PLAYER.DisplayName = "Player"
PLAYER.WalkSpeed = 150
PLAYER.RunSpeed = 250

function PLAYER:Loadout()
	self.Player:StripWeapons()
	self.Player:RemoveAllAmmo()

	-- default stuff
	for k, v in pairs(GAMEMODE.DefaultWeapons) do
		if v then
			self.Player:Give(k)
		end
	end

	self.Player:SelectWeapon("battleroyale_fists")
end

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Int", 0, "Resources")
	self.Player:NetworkVar("Int", 1, "Killstreak")
end

function PLAYER:Spawn()
	self.Player:SetResources(0)

	self:SetModel()

	self.Player:SetWalkSpeed(150)
	self.Player:SetRunSpeed(250)
end

function PLAYER:SetModel()
	local mdl_choice = GAMEMODE.PlayerModels[math.random(1, #GAMEMODE.PlayerModels)]
	self.Player:SetModel(mdl_choice[math.random(1, #mdl_choice)])
	self.Player.model_table = mdl_choice
end

player_manager.RegisterClass("player_battleroyale", PLAYER, "player_default")
