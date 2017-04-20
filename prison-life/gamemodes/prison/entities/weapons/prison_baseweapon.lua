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
	EmitSound(SnapSound, tr.HitPos, ply:EntIndex())
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

function SWEP:Initialize()
	util.PrecacheSound(SnapSound)
	self:SetHoldType(self.HoldType)
end

function SWEP:CanPrimaryAttack()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 and not self.reloading
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:ShootEffects()

	if self.Primary.SoundFar then
		self:EmitSound(self.Primary.SoundNear)
		self:EmitSound(self.Primary.SoundFar)
	else
		self:EmitSound(self.Primary.SoundNear)
	end

	local bullet = {}
	bullet.Num = self.Primary.NumShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Tracer = self.Primary.Tracer
	bullet.Force = self.Primary.Force
	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.TracerType
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	bullet.Spread = Vector(self.Primary.Cone, self.Primary.Cone, 0)
	bullet.Distance = self.Primary.Distance
	bullet.Callback = self.Primary.Callback

	self.Owner:FireBullets(bullet)
	self.Owner:ViewPunch(Angle(math.Rand(-0.2, -0.1) * self.Primary.Recoil, math.Rand(-0.1, 0.1) * self.Primary.Recoil, 0))

	local eyeang = self.Owner:EyeAngles()
	eyeang.pitch = eyeang.pitch - self.Primary.Recoil
	self.Owner:SetEyeAngles(eyeang)

	if self.Owner:GetAmmoCount(self.Primary.Ammo) > self.Primary.DefaultClip then
		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end

	self.Owner:RemoveAmmo(1, self.Primary.Ammo)

	if self.Owner:GetAmmoCount(self.Primary.Ammo) < 1 then
		self.needs_reload = true
	end
end

function SWEP:CanSecondaryAttack() return false end

function SWEP:Reload()
	if not IsFirstTimePredicted() or self.Owner:GetAmmoCount(self.Primary.Ammo) >= self.Primary.DefaultClip or self.reloading then return end

	self:SendWeaponAnim(ACT_VM_RELOAD)
	self.Owner:GetViewModel():SetPlaybackRate(self.ReloadRate)
	self.Owner:SetAnimation(PLAYER_RELOAD)

	self.reload_timer = CurTime() + (self:SequenceDuration() * (1 / self.ReloadRate))
	self.reloading = true
end

function SWEP:Think()
	if self.needs_reload then
		self.needs_reload = false
		self:Reload()
	end

	if self.reloading and self.reload_timer <= CurTime() then
		self.reloading = false
		self.reload_timer = 0

		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end
end

function SWEP:Deploy()
	self.reloading = false
	self.reload_timer = 0
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
	SWEP.CrosshairRadius = 5
	SWEP.CrosshairColor = Color(0, 255, 0, 255)

	function SWEP:DrawHUD()
		surface.DrawCircle(ScrW() / 2, ScrH() / 2, self.CrosshairRadius, self.CrosshairColor)
	end
end
