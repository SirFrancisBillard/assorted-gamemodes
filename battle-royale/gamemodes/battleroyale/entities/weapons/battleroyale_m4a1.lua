AddCSLuaFile()

GAMEMODE:RegisterAmmo("m4a1")

SWEP.Base = "prison_baseweapon"

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
SWEP.Primary.SoundNear = Sound("Weapon_M4A1.Near")
SWEP.Primary.SoundFar = Sound("Weapon_M4A1.Far")

SWEP.HoldType = "ar2"

SWEP.ViewModelPos = Vector(-0.44, 0, -1)
SWEP.ViewModelAng = Vector(0, 0, 0)
