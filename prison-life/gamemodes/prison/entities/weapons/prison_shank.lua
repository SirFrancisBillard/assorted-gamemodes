AddCSLuaFile()

SWEP.PrintName = "Shank"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Stab.]]

SWEP.ViewModel = "models/weapons/cstrike/c_knife.mdl"
SWEP.WorldModel = "models/weapons/w_knife.mdl"
SWEP.UseHands = true

SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false

SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.6
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 4
SWEP.Primary.Sound = Sound("Weapon_357.Single")

SWEP.HoldType = "knife"

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)
