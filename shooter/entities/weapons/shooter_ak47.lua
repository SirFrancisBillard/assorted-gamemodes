AddCSLuaFile()

sound.Add({
	name = "Shooter_AK47.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {156, 165},
	sound = "weapons/ak47/ak47-1.wav"
})

SWEP.Base = "shooter_base"

SWEP.PrintName = "AK-47"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "b"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "crossbow"
SWEP.IronHoldType = "ar2"

SWEP.WorldModel = Model( "models/weapons/w_rif_ak47.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_rif_ak47.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound( "Shooter_AK47.Single" )
SWEP.Primary.Recoil = 5
SWEP.Primary.Damage = 45
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.09

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

SWEP.IronsightsPos = Vector(-6.6, -15.801, 2.759)
SWEP.IronsightsAng = Angle(2.4, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 1.6397, -5.089, 4 )
SWEP.LoweredAng = Angle( -17.2767, 28.3565, -0.4145 )

SWEP.IdlePos = Vector(-4.321, 0, -2.881)
SWEP.IdleAng = Angle(0, 0, 0)

if CLIENT then
	killicon.AddFont( "shooter_ak47", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end