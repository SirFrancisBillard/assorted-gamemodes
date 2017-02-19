AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Ammo Box"
ENT.Category = "Battle Royale"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_OPAQUE

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_c17/SuitCase_Passenger_Physics.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
	end

	function ENT:Use(ply)
		if IsValid(ply) and ply:IsPlayer() then
			for k, v in pairs(GAMEMODE.AmmoTypes) do
				ply:GiveAmmo(v, k)
			end
			self:Remove()
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
