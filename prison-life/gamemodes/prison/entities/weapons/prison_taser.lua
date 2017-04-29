AddCSLuaFile()

SWEP.Base = "prison_baseweapon"

SWEP.PrintName = "Taser"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Tase someone.]]

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Primary.Delay = 0.5
SWEP.Primary.Cooldown = 10
SWEP.Primary.Sound = Sound("Prison.Taser")

SWEP.HoldType = "pistol"

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Vector(0, 0, 0)

function SWEP:CanPrimaryAttack()
	return not self:GetNeedsReload()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:EmitSound(self.Primary.Sound)

	if self.Owner.LagCompensation then -- for some reason not always true
		self.Owner:LagCompensation(true)
	end

	local spos = self.Owner:GetShootPos()
	local sdest = spos + (self.Owner:GetAimVector() * 500)

	local tr = util.TraceLine({start = spos, endpos = sdest, filter = self.Owner, mask = MASK_SHOT_HULL})
	local hitEnt = tr.Entity

	if IsValid(hitEnt) and self.Owner:CanTase(hitEnt) then
		hitEnt:Tase()
	end

	if self.Owner.LagCompensation then
		self.Owner:LagCompensation(false)
	end

	self:SetNeedsReload(true)
end
