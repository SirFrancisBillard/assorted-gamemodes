AddCSLuaFile()

SWEP.Base = "shooter_base"

SWEP.PrintName = "Desert Eagle"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "f"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"
SWEP.IronHoldType = "revolver"

SWEP.WorldModel = Model( "models/weapons/w_pist_deagle.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_pist_deagle.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound( "Weapon_Deagle.Single" )
SWEP.Primary.Recoil = 24
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = 0.4

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 7

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

SWEP.IronsightsPos = Vector(-6.361, -10.48, 2)
SWEP.IronsightsAng = Angle(0.5, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 0, -20, -13 )
SWEP.LoweredAng = Angle( 70, 0, 0 )

SWEP.SuicidePos = Vector(-3.36, -36.361, 4.519)
SWEP.SuicideAng = Angle(-18.8, 108.4, 0)

SWEP.LeanYawOffset = 0.3

if CLIENT then
	killicon.AddFont( "shooter_deagle", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end