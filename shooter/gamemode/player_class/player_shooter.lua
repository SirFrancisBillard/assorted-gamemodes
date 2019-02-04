DEFINE_BASECLASS("player_citizen")

local PLAYER = {}

PLAYER.DisplayName = "Shooter"

function PLAYER:Loadout()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_hands")
	self.Player:Give("lite_beretta")
	self.Player:Give("lite_ak47")
	self.Player:GiveAmmo(9999, "smg1")
end

local ShooterModels = {"models/player/alyx.mdl", "models/player/eli.mdl", "models/player/p2_chell.mdl", "models/player/monk.mdl", "models/player/kleiner.mdl"}

function PLAYER:SetModel()
	local modelname = ShooterModels[math.random(#ShooterModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0, 0))
	self.Player:SetupHands()
end

player_manager.RegisterClass("player_shooter", PLAYER, "player_citizen")
