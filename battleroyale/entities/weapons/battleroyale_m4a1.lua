AddCSLuaFile()

GAMEMODE:RegisterAmmo("m4a1")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "M4A1"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "battleroyale_m4a1"

SWEP.Primary.Cone = 0.002
SWEP.Primary.Delay = 0.1
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 0.6
SWEP.Primary.Sound = Sound("Weapon_M4A1.Single")

SWEP.HoldType = "ar2"
SWEP.IronType = "ar2"
SWEP.SprintType = "passive"

SWEP.ViewModelPos = Vector(-0.44, 0, -1)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.IronSightsPos = Vector(-8.09 + 0.5, -4.5, 0.56)
SWEP.IronSightsAng = Vector(2.75, -3.97 + 1.65, -3.8)
