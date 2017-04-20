AddCSLuaFile()

game.AddAmmoType({name = "prisonak47"})
if CLIENT then
	language.Add("prisonak47_ammo", "AK-47 Bullets")
end

SWEP.Base = "prison_baseweapon"

SWEP.PrintName = "AK-47"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.]]

SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "prisonak47"

SWEP.Primary.Cone = 0.008
SWEP.Primary.Delay = 0.1
SWEP.Primary.Damage = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 0.8
SWEP.Primary.SoundNear = Sound("Weapon_AK47.Near")
SWEP.Primary.SoundFar = Sound("Weapon_AK47.Far")

SWEP.HoldType = "ar2"

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)
