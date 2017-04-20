AddCSLuaFile()

game.AddAmmoType({name = "prisondeagle"})
if CLIENT then
	language.Add("prisondeagle_ammo", "Deagle Bullets")
end

SWEP.Base = "prison_baseweapon"

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
SWEP.Primary.Ammo = "prisondeagle"

SWEP.Primary.Cone = 0.003
SWEP.Primary.Delay = 0.4
SWEP.Primary.Damage = 60
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 2
SWEP.Primary.SoundNear = Sound("Weapon_Deagle.Near")
SWEP.Primary.SoundFar = Sound("Weapon_Deagle.Far")

SWEP.HoldType = "revolver"

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)
