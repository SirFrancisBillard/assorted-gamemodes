AddCSLuaFile()

GAMEMODE:RegisterAmmo("autoshotgun", "Shells")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "Automatic Shotgun"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a shot.]]

SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "battleroyale_autoshotgun"

SWEP.Primary.Cone = 0.04
SWEP.Primary.Delay = 0.4
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 8
SWEP.Primary.Recoil = 5
SWEP.Primary.Sound = Sound("Weapon_XM1014.Single")

SWEP.HoldType = "shotgun"
SWEP.IronType = "shotgun"
SWEP.SprintType = "passive"

SWEP.ViewModelPos = Vector(1.44, 0, -1.88)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.CrosshairRadius = 16

SWEP.NoSights = true

-- reload handling

SWEP.reloadtimer = 0

function SWEP:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar("Bool", 0, "reloading")
end

function SWEP:Reload()
	if self.dt.reloading then return end

	if not IsFirstTimePredicted() then return end

	if self.Owner:GetAmmoCount(self.Primary.Ammo) < self.Primary.DefaultClip and self:StartReload() then
		return
	end
end

function SWEP:StartReload()
	if self.dt.reloading then
		return false
	end

	if not IsFirstTimePredicted() then return false end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local wep = self

	if self.Owner:GetAmmoCount(self.Primary.Ammo) >= self.Primary.DefaultClip then
		return false
	end

	self:SetBodygroup(0, 1)
	wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
	self.Owner:SetAnimation(PLAYER_RELOAD)

	self.reloadtimer = CurTime() + wep:SequenceDuration()

	self.dt.reloading = true

	return true
end

function SWEP:PerformReload()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if SERVER then
		self.Owner:GiveAmmo(1, self.Primary.Ammo, true)
	end

	self:SendWeaponAnim(ACT_VM_RELOAD)

	self.reloadtimer = CurTime() + self:SequenceDuration() + 0.2
end

function SWEP:FinishReload()
	self.dt.reloading = false
	self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	self:SetBodygroup(0, 0)
	self.reloadtimer = CurTime() + self:SequenceDuration()
end


function SWEP:Think()
	if self:LowerWeapon() then
		self:SetHoldType(self.SprintType)

		self.CurViewModelPos = LerpVector(FrameTime() * 5, self.CurViewModelPos, self.SprintPos)
		self.CurViewModelAng = LerpVector(FrameTime() * 5, self.CurViewModelAng, self.SprintAng)
	else
		self:SetHoldType(self.HoldType)

		self.CurViewModelPos = LerpVector(FrameTime() * 5, self.CurViewModelPos, self.ViewModelPos)
		self.CurViewModelAng = LerpVector(FrameTime() * 5, self.CurViewModelAng, self.ViewModelAng)
	end

	local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)

	if self.needs_reload then
		self.needs_reload = false
		self:Reload()
	end

	if self.dt.reloading and IsFirstTimePredicted() then
		if self.Owner:KeyDown(IN_ATTACK) and ammo > 0 then
			self:FinishReload()
			return
		end

		if self.reloadtimer <= CurTime() then
			if ammo >= self.Primary.DefaultClip then
				self:FinishReload()
			elseif ammo < self.Primary.DefaultClip then
				self:PerformReload()
			else
				self:FinishReload()
			end
			return
		end
	end
end

function SWEP:Deploy()
	self.dt.reloading = false
	self.reloadtimer = 0

	return self.BaseClass.Deploy(self)
end
