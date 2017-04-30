AddCSLuaFile()

game.AddAmmoType({name = "prisonlifeammogeneric"})
if CLIENT then
	language.Add("prisonlifeammogeneric_ammo", "Bullets")
end

SWEP.PrintName = "Prison Life Base Weapon"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.
Weapon description.]]

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "prisonlifeammogeneric"

SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.6
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 4
SWEP.Primary.SoundNear = Sound("Weapon_357.Single")
SWEP.Primary.SoundFar = false
SWEP.Primary.Force = 40
SWEP.Primary.Tracer = 1
SWEP.Primary.TracerType = "Pistol"
SWEP.Primary.Distance = 56756

local SnapSound = Sound("Bullet.Snap")

SWEP.Primary.Callback = function(ply, tr, dmg)
	sound.Play(SnapSound, tr.HitPos)
end

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false

SWEP.HoldType = "revolver"

SWEP.CSMuzzleFlashes = true
SWEP.CSMuzzleX = true

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.ReloadRate = 1

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Reloading")
	self:NetworkVar("Bool", 1, "NeedsReload")
	self:NetworkVar("Int", 0, "ReloadTimer")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	self:SetReloading(false)
	self:SetNeedsReload(false)
	self:SetReloadTimer(0)
end

function SWEP:CanPrimaryAttack()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 and not self:GetReloading()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:ShootEffects()

	self:EmitSound(self.Primary.SoundNear)
	if CLIENT then
		local dist = LocalPlayer():GetShootPos():DistToSqr(self:GetPos())

		if self.Primary.SoundFar and dist < 1000000 or self.Owner == LocalPlayer() then
			self:EmitSound(self.Primary.SoundFar)
		end
	end

	local bullet = {}
	bullet.Num = self.Primary.NumShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Tracer = self.Primary.Tracer
	bullet.Force = self.Primary.Force
	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.TracerType
	bullet.Spread = Vector(self.Primary.Cone, self.Primary.Cone, 0)
	bullet.Distance = self.Primary.Distance
	bullet.Callback = self.Primary.Callback

	self.Owner:FireBullets(bullet)
	self.Owner:ViewPunch(Angle(math.Rand(-0.2, -0.1) * self.Primary.Recoil, math.Rand(-0.1, 0.1) * self.Primary.Recoil, 0))

	if SERVER then
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - self.Primary.Recoil
		self.Owner:SetEyeAngles(eyeang)
	end

	if self.Owner:GetAmmoCount(self.Primary.Ammo) > self.Primary.DefaultClip then
		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end

	self.Owner:RemoveAmmo(1, self.Primary.Ammo)

	if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
		self:SetNeedsReload(true)
	end
end

function SWEP:CanSecondaryAttack() return false end

function SWEP:Reload()
	if not IsFirstTimePredicted() or self.Owner:GetAmmoCount(self.Primary.Ammo) >= self.Primary.DefaultClip or self:GetReloading() then return end

	self:SendWeaponAnim(ACT_VM_RELOAD)
	self.Owner:GetViewModel():SetPlaybackRate(self.ReloadRate)
	self.Owner:SetAnimation(PLAYER_RELOAD)

	self:SetReloadTimer(CurTime() + self:SequenceDuration() * (1 / self.ReloadRate))
	self:SetReloading(true)
end

function SWEP:Think()
	if self:GetNeedsReload() then
		self:SetNeedsReload(false)
		self:Reload()
	end

	if self:GetReloading() and self:GetReloadTimer() <= CurTime() then
		self:SetReloading(false)
		self:SetReloadTimer(0)

		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end
end

function SWEP:Deploy()
	self:SetReloading(false)
	self:SetReloadTimer(0)
end

function SWEP:GetViewModelPosition(pos, ang)
	local Offset = self.ViewModelPos

	if self.ViewModelAng then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), self.ViewModelAng.x)
		ang:RotateAroundAxis(ang:Up(), self.ViewModelAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.ViewModelAng.z)
	end

	local r = ang:Right()
	local u = ang:Up()
	local f = ang:Forward()

	pos = pos + Offset.x * r
	pos = pos + Offset.y * f
	pos = pos + Offset.z * u

	return pos, ang
end

if CLIENT then
	SWEP.CrosshairRadius = 4
	SWEP.CrosshairColor = Color(0, 255, 0, 255)

	function SWEP:DrawHUD()
		surface.DrawCircle(ScrW() / 2, ScrH() / 2, self.CrosshairRadius, self.CrosshairColor)
	end
end
