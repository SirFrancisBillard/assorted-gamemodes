AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Gib"
ENT.Category = "Battle Royale"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_OPAQUE

GIB_SKULL = 1
GIB_RIB = 2
RIB_SCAPULA = 3
GIB_SPINE = 4

local gibmodels = {
	[GIB_SKULL] = "models/Gibs/HGIBS.mdl",
	[GIB_RIB] = "models/Gibs/HGIBS_rib.mdl",
	[RIB_SCAPULA] = "models/Gibs/HGIBS_scapula.mdl",
	[GIB_SPINE] = "models/Gibs/HGIBS_spine.mdl"
}

if SERVER then
	function ENT:Initialize()
		self:SetModel(gibmodels[math.random(#gibmodels)])
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:PhysWake()

		SafeRemoveEntity(self, 30)
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
