AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Warhead"
ENT.Spawnable = false

ENT.Model = "models/weapons/w_missile_closed.mdl"

local SplodeDamage = 300
local SplodeRadius = 1400

local color_white = color_white or Color(255, 255, 255)
local color_red = Color(255, 0, 0)

local SpriteMat = Material("sprites/light_glow02_add")

local ExplosionSound = Sound("Explosion.Boom")

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:EnableGravity(false)
		end

		self.Noise = CreateSound(self, "weapons/rpg/rocket1.wav")
		self.Noise:Play()
	end

	function ENT:Detonate()
		self.Noise:Stop()

		ParticleEffect("dusty_explosion_rockets", self:GetPos(), angle_zero)

		self:EmitSound(ExplosionSound)

		util.BlastDamage(self, self.Owner, self:GetPos(), SplodeRadius, SplodeDamage)

		local blast = DamageInfo()
		blast:SetDamage(SplodeDamage)
		blast:SetAttacker(self:GetOwner() or self)
		blast:SetInflictor(self)
		blast:SetDamageType(DMG_BLAST)

		for k, v in pairs(player.GetAll()) do
			if IsValid(v) and v:IsPlayer() and self:GetPos():DistToSqr(v:GetPos()) < (400 * 400) then
				v:TakeDamageInfo(blast)
			end
		end

		self:Remove()
	end

	function ENT:PhysicsCollide(data, phys)
		self:Detonate()
	end

	function ENT:Touch(ent)
		if IsValid(ent) then
			self:Detonate()
		end
	end
else -- CLIENT
	function ENT:Initialize()
		self.BaseClass.Initialize(self)

		self.FirePlace = ParticleEmitter(self:GetPos(), false)
	end

	function ENT:Think()
		self.EmitTime = self.EmitTime or CurTime()
		if (self.EmitTime <= CurTime()) then
			local smoke = self.FirePlace:Add("particle/smokesprites_000"..math.random(1,9), self:GetPos())
			smoke:SetVelocity(Vector(0, 0, 120))
			smoke:SetDieTime(math.Rand(8, 10))
			smoke:SetStartAlpha(math.Rand(150, 200))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(10, 50))
			smoke:SetEndSize(math.random(200, 350))
			smoke:SetRoll(math.Rand(2, 12))
			smoke:SetRollDelta(math.Rand(-0.2, 0.2))
			smoke:SetColor(100, 100, 100)
			smoke:SetGravity(Vector(0, 0, 10))
			smoke:SetAirResistance(256)
			self.EmitTime = CurTime() + 0.02
		end
	end
end
