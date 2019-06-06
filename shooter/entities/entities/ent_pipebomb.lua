AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Thrown Pipebomb"

local Red = Color(255, 0, 0)
local SpriteMat = Material("sprites/light_glow02_add")

if CLIENT then
	function ENT:Draw()
		if math.Round(CurTime() * 2) % 2 == 1 then
			render.SetMaterial(SpriteMat)
			render.DrawSprite(self:GetPos(), 50, 50, Red)
		end

		self:DrawModel()
	end

	killicon.AddFont("ent_pipebomb", "DermaDefault", "Pipebomb", Color(255, 80, 0, 255))

	return
end

function ENT:Initialize()
	self:SetModel("models/props_junk/GlassBottle01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetAngles(Angle(math.random(0, 360), math.random(0, 360), math.random(0, 360)))
	
	self:PhysWake()
	self.ExplodeTime = CurTime() + 4
	--util.SpriteTrail(self, 0, Color(255, 120, 0), false, 8, 2, 0.4, 1 / 10 * 0.5, "trails/smoke.vmt")
end

function ENT:Think()
	if CurTime() > self.ExplodeTime and not self.Exploded then
		self.Exploded = true
		self:Explode()
	end
end

function ENT:Explode()
	local boom = EffectData()
	boom:SetOrigin(self:GetPos())
	util.Effect("Explosion", boom)

	util.BlastDamage(self, self:GetOwner(), self:GetPos(), 800, 120)
	util.ScreenShake(self:GetPos(), 20, 1, 1, 5000)
	sound.Play("ambient/explosions/explode_" .. math.random(3, 4) .. ".wav", self:GetPos(), 160, math.random(60, 80), 1)

	self:Remove()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 50 then
		self:EmitSound(Sound("Smokegrenade.Bounce"))
	end
end
