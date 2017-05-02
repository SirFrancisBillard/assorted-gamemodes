AddCSLuaFile()

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "Crowbar"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Swing.]]

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.AmmoType = "none"

SWEP.Primary.Delay = 0.6
SWEP.Primary.Damage = 45
SWEP.Primary.Sound = Sound("Weapon_Crowbar.Melee_Hit")
SWEP.Primary.SoundMiss = Sound("Weapon_Crowbar.Single")

SWEP.HoldType = "melee"
SWEP.SprintType = "normal"

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.SprintAng = Vector(-20, 0, 0)

SWEP.DrawAmmo = false

function SWEP:PrimaryAttack()
	if self:LowerWeapon() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if not IsValid(self.Owner) then return end

	if self.Owner.LagCompensation then -- for some reason not always true
		self.Owner:LagCompensation(true)
	end

	local spos = self.Owner:GetShootPos()
	local sdest = spos + (self.Owner:GetAimVector() * 70)

	local tr_main = util.TraceLine({start = spos, endpos = sdest, filter = self.Owner, mask = MASK_SHOT_HULL})
	local hitEnt = tr_main.Entity

	if IsValid(hitEnt) or tr_main.HitWorld then
		self:EmitSound(self.Primary.Sound)
		self:SendWeaponAnim(ACT_VM_HITCENTER)

		if not (CLIENT and (not IsFirstTimePredicted())) then
			local edata = EffectData()
			edata:SetStart(spos)
			edata:SetOrigin(tr_main.HitPos)
			edata:SetNormal(tr_main.Normal)
			edata:SetSurfaceProp(tr_main.SurfaceProps)
			edata:SetHitBox(tr_main.HitBox)
			edata:SetEntity(hitEnt)

			if hitEnt:IsPlayer() or hitEnt:GetClass() == "prop_ragdoll" then
				util.Effect("BloodImpact", edata)
				self.Owner:LagCompensation(false)
				self.Owner:FireBullets({Num = 1, Src = spos, Dir = self.Owner:GetAimVector(), Spread = Vector(0, 0, 0), Tracer = 0, Force = 1, Damage = 0})
			else
				util.Effect("Impact", edata)
			end
		end
	else
		-- miss
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		self:EmitSound(self.Primary.SoundMiss)
	end


	if SERVER then
		-- do another trace that sees nodraw stuff like func_button
		local tr_all = nil
		tr_all = util.TraceLine({start = spos, endpos = sdest, filter = self.Owner})

		if hitEnt and hitEnt:IsValid() then
			local dmg = DamageInfo()
			dmg:SetDamage(self.Primary.Damage)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self)
			dmg:SetDamageForce(self.Owner:GetAimVector() * 1500)
			dmg:SetDamagePosition(self.Owner:GetPos())
			dmg:SetDamageType(DMG_SLASH)

			hitEnt:DispatchTraceAttack(dmg, spos + (self.Owner:GetAimVector() * 3), sdest)
		end
	end

	if self.Owner.LagCompensation then
		self.Owner:LagCompensation(false)
	end
end

function SWEP:Reload() end
function SWEP:SecondaryAttack() end
