AddCSLuaFile()

GAMEMODE:RegisterAmmo("mp5")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "MP5"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "battleroyale_mp5"

SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = 0.08
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 0.2
SWEP.Primary.Sound = Sound("Weapon_MP5.Single")

SWEP.HoldType = "ar2"
SWEP.IronType = "ar2"
SWEP.SprintType = "passive"

SWEP.ViewModelPos = Vector(-0.44, 0, -1)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.IronSightsPos = Vector(-5.3, -7, 2.1)
SWEP.IronSightsAng = Vector(0.9, 0.1, 0)

SWEP.CrosshairRadius = 8
