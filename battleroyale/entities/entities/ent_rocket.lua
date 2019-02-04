AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Launched Rocket"
ENT.Spawnable = false

ENT.Model = "models/weapons/w_missile_closed.mdl"

local SplodeDamage = 300
local SplodeRadius = 200

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

		util.SpriteTrail(self, 0, color_white, false, 12, 1, 0.8, 0.1, "trails/smoke.vmt")

		self.Noise = CreateSound(self, "weapons/rpg/rocket1.wav")
		self.Noise:Play()
	end

	function ENT:Detonate()
		self.Noise:Stop()

		ParticleEffect("dusty_explosion_rockets", self:GetPos(), angle_zero)

		self:EmitSound(ExplosionSound)

		util.BlastDamage(self, self.Owner, self:GetPos(), SplodeRadius, SplodeDamage)

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
	function ENT:Draw()
		render.SetMaterial(SpriteMat)
		render.DrawSprite(self:GetPos(), 24, 24, self:GetOwner() == LocalPlayer() and color_white or color_red)

		self:DrawModel()
	end
end
