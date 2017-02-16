AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Airdrop"

ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_junk/wood_crate001a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetSequence(1)
		self:PhysWake()
		-- whoever stands under this is
		-- gonna be one unlucky wanker
		self:SetVelocity(Vector(0, 0, -20000))
	end

	function ENT:Use(ply)
		if IsValid(ply) and ply:IsPlayer() then
			for i = 1, math.random(2, 5) do
				local tab = table.GetKeys(GAMEMODE.LootTable.Good)
				if not tab then return end
				local item = tab[math.random(1, #tab)]
				local loot = ents.Create(item)
				loot:SetPos(self:GetPos() + Vector(0, 0, 32))
				loot:Spawn()
			end
			self:Remove()
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
