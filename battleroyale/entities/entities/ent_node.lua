AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Mining Node"
ENT.Category = "Battle Royale"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.IsHarvestableNode = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props/CS_militia/militiarock05.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetMass(1000)
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
