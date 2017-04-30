AddCSLuaFile()

GAMEMODE:RegisterAmmo("m249")

SWEP.Base = "prison_baseweapon"

SWEP.PrintName = "M249"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "battleroyale_m249"

SWEP.Primary.Cone = 0.008
SWEP.Primary.Delay = 0.04
SWEP.Primary.Damage = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 0.8
SWEP.Primary.SoundNear = Sound("Weapon_M249.Near")
SWEP.Primary.SoundFar = Sound("Weapon_M249.Far")

SWEP.HoldType = "ar2"

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)
