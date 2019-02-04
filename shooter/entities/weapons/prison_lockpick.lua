AddCSLuaFile()

SWEP.Base = "prison_baseweapon"

SWEP.PrintName = "Lockpick"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Pick a lock.]]

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Primary.Delay = 0.5
SWEP.Primary.Cooldown = 10
SWEP.Primary.Sound = Sound("buttons/bell1.wav")

SWEP.HoldType = "pistol"

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Vector(0, 0, 0)

local IsDoor = {
	["func_door"] = true,
	["func_door_rotating"] = true,
	["prop_door"] = true,
	["prop_door_rotating"] = true
}

function SWEP:CanPrimaryAttack()
	if not IsValid(self) or not IsValid(self.Owner) or not self.Owner:IsPlayer() then
		return false 
	end

	if self.Owner:Team() == TEAM_GUARD then
		if SERVER then
			self.Owner:ChatPrint("Guards cannot pick locks!")
		end

		return false
	end

	return true
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if self.Owner.LagCompensation then -- for some reason not always true
		self.Owner:LagCompensation(true)
	end

	local tr = self.Owner:GetEyeTrace()
	local trent = tr.Entity

	if SERVER and IsValid(trent) and IsDoor[trent:GetClass()] then
		trent:Fire("Unlock")
		trent:Fire("Open")
		self:EmitSound(self.Primary.Sound)
	end

	if self.Owner.LagCompensation then
		self.Owner:LagCompensation(false)
	end
end

function SWEP:Reload() end
function SWEP:SecondaryAttack() end
