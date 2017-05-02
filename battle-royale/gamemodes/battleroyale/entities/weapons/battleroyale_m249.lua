AddCSLuaFile()

GAMEMODE:RegisterAmmo("m249")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "M249"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "battleroyale_m249"

SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = 0.06
SWEP.Primary.Damage = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 0.4
SWEP.Primary.SoundNear = Sound("Weapon_M249.Near")
SWEP.Primary.SoundFar = Sound("Weapon_M249.Far")

SWEP.HoldType = "crossbow"
SWEP.IronType = "crossbow"
SWEP.SprintType = "passive"

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.IronSightsPos = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.CrosshairRadius = 8
