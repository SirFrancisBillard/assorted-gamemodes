AddCSLuaFile()

sound.Add({
	name = "Shooter_44.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {125, 130},
	sound = "weapons/357/357_fire2.wav"
})

SWEP.Base = "shooter_base"

SWEP.PrintName = ".44 Magnum"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "f"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"
SWEP.IronHoldType = "revolver"

SWEP.WorldModel = Model( "models/weapons/w_357.mdl" )
SWEP.ViewModel = Model( "models/weapons/c_357.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound( "Shooter_44.Single" )
SWEP.Primary.Recoil = 24
SWEP.Primary.Damage = 80
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = 0.4

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

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

SWEP.IronsightsPos = Vector(-4.72, 0, 0.6)
SWEP.IronsightsAng = Angle(0.1, -0.201, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 0, -20, -13 )
SWEP.LoweredAng = Angle( 70, 0, 0 )

SWEP.SuicidePos = Vector(-3.36, -36.361, 4.519)
SWEP.SuicideAng = Angle(-18.8, 108.4, 0)

SWEP.IdlePos = Vector(-2.76, 0, -2.08)
SWEP.IdleAng = Angle(0, 0, 0)

SWEP.LeanYawOffset = 0.09

if CLIENT then
	killicon.AddFont( "shooter_revolver", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end