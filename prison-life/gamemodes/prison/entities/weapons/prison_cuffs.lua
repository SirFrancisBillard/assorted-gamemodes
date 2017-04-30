AddCSLuaFile()

SWEP.Base = "prison_baseweapon"

SWEP.PrintName = "Handcuffs"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Arrest a criminal.]]

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunstick.mdl"
SWEP.UseHands = true

SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Primary.Delay = 0.5
SWEP.Primary.Cooldown = 10
SWEP.Primary.Sound = Sound("Prison.Handcuff")

SWEP.HoldType = "slam"

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Vector(0, 0, 0)

function SWEP:CanPrimaryAttack()
	if not IsValid(self) or not IsValid(self.Owner) or not self.Owner:IsPlayer() then
		return false 
	end

	if not self.Owner:Team() == TEAM_GUARD then
		if SERVER then
			self.Owner:ChatPrint("You must be a guard to use handcuffs!")
		end

		return false
	end

	if self.Owner:GetArrestTimer() >= CurTime() then
		if SERVER then
			self.Owner:ChatPrint("You need to wait another " .. string.Comma(math.ceil(self.Owner:GetArrestTimer() - CurTime())) .. " seconds before arresting someone!")
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

	local spos = self.Owner:GetShootPos()
	local sdest = spos + (self.Owner:GetAimVector() * 70)

	local tr = util.TraceLine({start = spos, endpos = sdest, filter = self.Owner, mask = MASK_SHOT_HULL})
	local hitEnt = tr.Entity

	if SERVER and IsValid(hitEnt) and hitEnt:IsPlayer() and hitEnt:CanArrest() then
		hitEnt:Arrest()
		self.Owner:SetArrestTimer(CurTime() + self.Primary.Cooldown)
		self:EmitSound(self.Primary.Sound)
	end

	if self.Owner.LagCompensation then
		self.Owner:LagCompensation(false)
	end
end

function SWEP:Reload() end
function SWEP:SecondaryAttack() end
