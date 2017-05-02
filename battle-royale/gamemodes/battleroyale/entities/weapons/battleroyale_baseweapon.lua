AddCSLuaFile()

GAMEMODE:RegisterAmmo("generic")

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
SWEP.Primary.Ammo = "battleroyale_generic"

SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.6
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 4
SWEP.Primary.SoundNear = Sound("Weapon_357.Single")
SWEP.Primary.SoundFar = Sound("Weapon_357.Single")
SWEP.Primary.Force = 40
SWEP.Primary.Tracer = 1
SWEP.Primary.TracerType = "Pistol"
SWEP.Primary.Distance = 56756

SWEP.CrosshairRadius = 4
SWEP.CrosshairColor = Color(0, 255, 0, 255)

local SnapSound = Sound("Bullet.Snap")

SWEP.Primary.Callback = function(ply, tr, dmg)
	sound.Play(SnapSound, tr.HitPos)
end

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Secondary.Delay = 0.2

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false

SWEP.HoldType = "pistol"
SWEP.IronType = "revolver"
SWEP.SprintType = "passive"

SWEP.CSMuzzleFlashes = true
SWEP.CSMuzzleX = true

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, 0)
SWEP.SprintAng = Vector(-10, 25, 0)

SWEP.NoSights = false
SWEP.ReloadRate = 1

function SWEP:LowerWeapon()
	return self.Owner:GetVelocity():Length() > self.Owner:GetWalkSpeed() * 1.2 or not self.Owner:OnGround()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Ironsights")
	self:NetworkVar("Bool", 1, "Reloading")
	self:NetworkVar("Bool", 2, "NeedsReload")
	self:NetworkVar("Int", 0, "ReloadTimer")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	self:SetIronsights(false)
	self:SetReloading(false)
	self:SetNeedsReload(false)
	self:SetReloadTimer(0)

	self.CurViewModelPos = Vector(self.ViewModelPos.x, self.ViewModelPos.y, self.ViewModelPos.z)
	self.CurViewModelAng = Vector(self.ViewModelAng.x, self.ViewModelAng.y, self.ViewModelAng.z)
end

function SWEP:CanPrimaryAttack()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 and not self:GetReloading() and not self:LowerWeapon()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:ShootEffects()

	if SERVER and type(GAMEMODE.Gunshot) == "function" then
		GAMEMODE:Gunshot(self)
	end

	local cone = self.Primary.Cone
	if self:GetIronsights() then
		cone = cone * 0.8
	end

	local bullet = {}
	bullet.Num = self.Primary.NumShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Tracer = self.Primary.Tracer
	bullet.Force = self.Primary.Force
	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.TracerType
	bullet.Spread = Vector(cone, cone, 0)
	bullet.Distance = self.Primary.Distance
	bullet.Callback = self.Primary.Callback

	local recoil = self.Primary.Recoil
	if self:GetIronsights() then
		recoil = recoil * 0.8
	end

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

function SWEP:CanSecondaryAttack()
	return not self:LowerWeapon() and not self.NoSights
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	self:SetIronsights(not self:GetIronsights())
end

function SWEP:Reload()
	if not IsFirstTimePredicted() or self.Owner:GetAmmoCount(self.Primary.Ammo) >= self.Primary.DefaultClip or self:GetReloading() then return false end

	self:SendWeaponAnim(ACT_VM_RELOAD)
	self.Owner:GetViewModel():SetPlaybackRate(self.ReloadRate)
	self.Owner:SetAnimation(PLAYER_RELOAD)

	self:SetReloadTimer(CurTime() + self:SequenceDuration() * (1 / self.ReloadRate))
	self:SetReloading(true)

	return true
end

function SWEP:Think()
	if self:LowerWeapon() and not self:GetReloading() then
		self:SetHoldType(self.SprintType)

		self.CurViewModelPos = LerpVector(FrameTime() * 5, self.CurViewModelPos, self.SprintPos)
		self.CurViewModelAng = LerpVector(FrameTime() * 5, self.CurViewModelAng, self.SprintAng)
	elseif self:GetIronsights() and not self:GetReloading() then
		self:SetHoldType(self.IronType)

		self.CurViewModelPos = LerpVector(FrameTime() * 5, self.CurViewModelPos, self.IronSightsPos)
		self.CurViewModelAng = LerpVector(FrameTime() * 5, self.CurViewModelAng, self.IronSightsAng)
	else
		self:SetHoldType(self.HoldType)

		self.CurViewModelPos = LerpVector(FrameTime() * 5, self.CurViewModelPos, self.ViewModelPos)
		self.CurViewModelAng = LerpVector(FrameTime() * 5, self.CurViewModelAng, self.ViewModelAng)
	end

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
	self:SendWeaponAnim(ACT_VM_DRAW)

	self:SetReloading(false)
	self:SetReloadTimer(0)
end

function SWEP:GetViewModelPosition(pos, ang)
	local Offset = self.CurViewModelPos

	if self.CurViewModelAng then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), self.CurViewModelAng.x)
		ang:RotateAroundAxis(ang:Up(), self.CurViewModelAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.CurViewModelAng.z)
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
	function SWEP:DrawHUD()
		if self.NoSights or self:GetReloading() or self:LowerWeapon() or not self:GetIronsights() then
			surface.DrawCircle(ScrW() / 2, ScrH() / 2, self.CrosshairRadius, self.CrosshairColor)
		end
	end
end
