AddCSLuaFile()

sound.Add({
	name = "Shooter_M3.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105},
	sound = "weapons/m3/m3-1.wav"
})

SWEP.Base = "shooter_base_shotgun"

SWEP.PrintName = "Shotgun"
SWEP.Category = "Shooter Weapons"
SWEP.DrawWeaponInfoBox = false
SWEP.IconLetter = "k"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"
SWEP.IronHoldType = "ar2"

SWEP.WorldModel = Model( "models/weapons/w_shot_m3super90.mdl" )
SWEP.ViewModel = Model( "models/weapons/cstrike/c_shot_m3super90.mdl" )
SWEP.ViewModelFOV = 55
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.Sound = Sound( "Weapon_M3.Single" )
SWEP.Primary.Recoil = 14
SWEP.Primary.Damage = 30 / 1.4
SWEP.Primary.NumShots = 16
SWEP.Primary.Cone = 0.06
SWEP.Primary.Delay = 0.9

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 8

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.25
SWEP.Spread.IronsightsMod = 0.75
SWEP.Spread.CrouchMod = 0.6
SWEP.Spread.AirMod = 1.2
SWEP.Spread.RecoilMod = 0.05
SWEP.Spread.VelocityMod = 0.5

--SWEP.IronsightsPos = Vector( -7.65, -5, 2.8 )
--SWEP.IronsightsAng = Angle( 1, 0, 0 )
SWEP.IronsightsPos = Vector(-7.64, -9.681, 3.48)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.8

SWEP.LoweredPos = Vector( 1.6397, -5.089, 4 )
SWEP.LoweredAng = Angle( -17.2767, 28.3565, -0.4145 )

SWEP.LeanYawOffset = 0
SWEP.UseIronsightsRecoil = false

if CLIENT then
	killicon.AddFont( "shooter_m3", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end