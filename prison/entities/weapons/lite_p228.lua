AddCSLuaFile()

SWEP.Base = "lite_base"

SWEP.PrintName = "P228"
SWEP.Category = "Lite Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "y"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"

SWEP.WorldModel = Model( "models/weapons/w_pist_p228.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_pist_p228.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound( "Weapon_P228.Single" )
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Damage = 12
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.13

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 13
SWEP.Primary.DefaultClip = 13

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.25
SWEP.Spread.IronsightsMod = 0.2
SWEP.Spread.CrouchMod = 0.6
SWEP.Spread.AirMod = 1.2
SWEP.Spread.RecoilMod = 0.05
SWEP.Spread.VelocityMod = 0.5

SWEP.IronsightsPos = Vector( -5.9613, -3.3101, 2.706 )
SWEP.IronsightsAng = Angle( 0, 0, 0 )
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 0, -20, -10 )
SWEP.LoweredAng = Angle( 70, 0, 0 )

if CLIENT then
	killicon.AddFont( "lite_p228", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end