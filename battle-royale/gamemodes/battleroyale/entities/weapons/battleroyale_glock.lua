AddCSLuaFile()

GAMEMODE:RegisterAmmo("glock")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "Glock-18"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 18
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "battleroyale_glock"

SWEP.Primary.Cone = 0.01
SWEP.Primary.Delay = 0.14
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 0.8
SWEP.Primary.SoundNear = Sound("Weapon_Glock.Near")
SWEP.Primary.SoundFar = Sound("Weapon_Glock.Far")

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.CrosshairRadius = 6

SWEP.IronSightsPos = Vector(-5.77, -6.6, 2.7)
SWEP.IronSightsAng = Vector(0.9, 0, 0)
