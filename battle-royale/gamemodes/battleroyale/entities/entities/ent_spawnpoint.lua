AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Spawn Point"
ENT.Category = "Battle Royale"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_OPAQUE

local color_blue = Color(0, 100, 255)

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_c17/streetsign004e.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		timer.Simple(1, function()
			if IsValid(self) then
				self:CollisionRulesChanged()
			end
		end)
		self:SetColor(color_blue)
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
