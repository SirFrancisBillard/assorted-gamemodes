AddCSLuaFile()

GAMEMODE:RegisterAmmo("deagle")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "Deagle"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "battleroyale_deagle"

SWEP.Primary.Cone = 0.003
SWEP.Primary.Delay = 0.4
SWEP.Primary.Damage = 60
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 2
SWEP.Primary.Sound = Sound("Weapon_Deagle.Single")

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)


SWEP.IronSightsPos = Vector(-6.35, -7.5, 2.02)
SWEP.IronSightsAng = Vector(0.51, 0, 0)
