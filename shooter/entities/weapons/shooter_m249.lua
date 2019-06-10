AddCSLuaFile()

sound.Add({
	name = "Shooter_M249.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {115, 125},
	sound = "weapons/m249/m249-1.wav"
})

SWEP.Base = "shooter_base"

SWEP.PrintName = "M249"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "z"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model( "models/weapons/w_mach_m249para.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_mach_m249para.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound( "Shooter_M249.Single" )
SWEP.Primary.Recoil = 2
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.06
SWEP.Primary.Delay = 0.09

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 150
SWEP.Primary.DefaultClip = 150

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.5
SWEP.Spread.IronsightsMod = 0.35
SWEP.Spread.CrouchMod = 0.8
SWEP.Spread.AirMod = 1.5
SWEP.Spread.RecoilMod = 0.05
SWEP.Spread.VelocityMod = 1

SWEP.IronsightsPos = Vector(-5.961, 0, 2.279)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.8
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector( 1.6397, -5.089, 4 )
SWEP.LoweredAng = Angle( -17.2767, 28.3565, -0.4145 )

SWEP.LeanYawOffset = 0

if CLIENT then
	killicon.AddFont( "shooter_m249", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end