AddCSLuaFile()

GAMEMODE:RegisterAmmo("pistol")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "Pistol"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "battleroyale_pistol"

SWEP.Primary.Cone = 0.005
SWEP.Primary.Delay = 0.25
SWEP.Primary.Damage = 25
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 1
SWEP.Primary.SoundNear = Sound("Weapon_Pistol.Near")
SWEP.Primary.SoundFar = Sound("Weapon_Pistol.Far")

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.IronSightsPos = Vector(-5.92, -6.2, 3)
SWEP.IronSightsAng = Vector(-0.5, 0.07, 0)
