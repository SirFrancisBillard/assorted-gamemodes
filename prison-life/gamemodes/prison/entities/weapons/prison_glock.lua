AddCSLuaFile()

game.AddAmmoType({name = "prisonglock"})
if CLIENT then
	language.Add("prisonglock_ammo", "Glock Bullets")
end

SWEP.Base = "prison_baseweapon"

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
SWEP.Primary.Ammo = "prisonglock"

SWEP.Primary.Cone = 0.01
SWEP.Primary.Delay = 0.14
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 0.2
SWEP.Primary.SoundNear = Sound("Weapon_Pistol.Near")
SWEP.Primary.SoundFar = Sound("Weapon_Pistol.Far")

SWEP.HoldType = "revolver"

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)
