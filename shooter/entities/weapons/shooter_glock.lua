AddCSLuaFile()

sound.Add({
	name = "Shooter_Glock.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {135, 145},
	sound = "^weapons/pistol/pistol_fire3.wav"
})

SWEP.Base = "shooter_base"

SWEP.PrintName = "Glock"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "c"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"

SWEP.WorldModel = Model( "models/weapons/w_pist_glock18.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_pist_glock18.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound( "Shooter_Glock.Single" )
SWEP.Primary.Recoil = 0.8 * 4
SWEP.Primary.Damage = 10 * 1.8
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.09
SWEP.Primary.Delay = 0.12

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 60

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

SWEP.IronsightsPos = Vector( -5.75, -3.3101, 2.9 )
SWEP.IronsightsAng = Angle( 0, 0, 0 )
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 0, -20, -10 )
SWEP.LoweredAng = Angle( 70, 0, 0 )

SWEP.SuicidePos = Vector(-3.36, -36.361, 4.519)
SWEP.SuicideAng = Angle(-18.8, 108.4, 0)

SWEP.LeanYawOffset = 0.15

if CLIENT then
	killicon.AddFont( "shooter_glock", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end