AddCSLuaFile()

sound.Add({
	name = "Shooter_Pistol.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {125, 135},
	sound = "weapons/fiveseven/fiveseven-1.wav"
})

sound.Add({
	name = "Shooter_Pistol.Silenced",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_TALKING,
	pitch = {130, 140},
	sound = "weapons/m4a1/m4a1-1.wav"
})

SWEP.Base = "shooter_base"

SWEP.PrintName = "Pistol"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "u"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"

SWEP.WorldModel = Model( "models/weapons/w_pist_fiveseven.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_pist_fiveseven.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.SilencedSound = Sound( "Shooter_Pistol.Silenced" )
SWEP.Primary.Sound = Sound( "Shooter_Pistol.Single" )
SWEP.Primary.Recoil = 0.8 * 4
SWEP.Primary.Damage = 10 * 1.8
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.12

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20

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

SWEP.IronsightsPos = Vector(-5.961, 0, 2.799)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 0, -20, -10 )
SWEP.LoweredAng = Angle( 70, 0, 0 )

SWEP.SuicidePos = Vector(-3.36, -36.361, 4.519)
SWEP.SuicideAng = Angle(-18.8, 108.4, 0)

SWEP.LeanYawOffset = 0.15

if CLIENT then
	killicon.AddFont( "shooter_pistol", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end