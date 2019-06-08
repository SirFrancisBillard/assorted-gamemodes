AddCSLuaFile()

sound.Add({
	name = "Shooter_MP5.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {160, 180},
	sound = "weapons/pistol/pistol_fire2.wav"
})

SWEP.Base = "shooter_base"

SWEP.PrintName = "MP5"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "x"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "crossbow"
SWEP.IronHoldType = "ar2"

SWEP.WorldModel = Model( "models/weapons/w_smg_mp5.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_smg_mp5.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound( "Shooter_MP5.Single" )
SWEP.Primary.Recoil = 0.7
SWEP.Primary.Damage = 25 / 2
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = 0.09 * 0.7

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

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

SWEP.IronsightsPos = Vector( -5.25, -3, 1.5 )
SWEP.IronsightsAng = Angle( 2, 0, 0 )
SWEP.IronsightsPos = Vector(-5.361, -6.321, 2.16)
SWEP.IronsightsAng = Angle(0.7, -0.12, 0)

SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 1.6397, -5.089, 2.4904 )
SWEP.LoweredAng = Angle( -17.2767, 28.3565, -0.4145 )

SWEP.IdlePos = Vector(-2.5, 0, -2.881)
SWEP.IdleAng = Angle(0, 0, 0)

SWEP.LeanYawOffset = 0.3

if CLIENT then
	killicon.AddFont( "shooter_mp5", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end