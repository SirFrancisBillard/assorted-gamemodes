AddCSLuaFile()

SWEP.HoldType = "grenade"

SWEP.PrintName = "Airdrop Signal"
SWEP.Category = "Battle Royale"
SWEP.Slot = 3

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54

SWEP.IconLetter = "Q"

SWEP.Base = "weapon_br_basegrenade"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_eq_smokegrenade.mdl"
SWEP.WorldModel = "models/weapons/w_eq_smokegrenade.mdl"

SWEP.Weight = 5
SWEP.AutoSpawnable = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
	return "ent_dropnade_proj"
end
