AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Airdrop"
ENT.Category = "Battle Royale"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_OPAQUE

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/Items/item_item_crate.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
		-- whoever stands under this is gonna be one unlucky wanker
		timer.Simple(.1, function()
			if IsValid(self) then
				self:GetPhysicsObject():AddVelocity(Vector(0, 0, -100) * math.Rand(2000, 3000))
			end
		end)
	end

	function ENT:PhysicsCollide(data, phys)
		if data.Speed > 2000 and data.DeltaTime > .2 then
			self:EmitSound("Boulder.ImpactHard")
			self:EmitSound("Canister.ImpactHard")
			self:EmitSound("Boulder.ImpactHard")
			self:EmitSound("Canister.ImpactHard")
			self:EmitSound("Boulder.ImpactHard")
			util.ScreenShake(data.HitPos,99999,99999,.5,500)
			local tr = util.QuickTrace(data.HitPos - data.OurOldVelocity, data.OurOldVelocity * 50,{self})
			if(tr.Hit)then
				util.Decal("Rollermine.Crater", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			end
		elseif data.Speed > 80 and data.DeltaTime > .2 then
			self:EmitSound("Canister.ImpactHard")
		end
	end

	function ENT:Use(ply)
		if IsValid(ply) and ply:IsPlayer() then
			for i = 1, math.random(1, 3) do
				local tab = table.GetKeys(GAMEMODE.LootTable.Good)
				if not tab then return end
				local item = tab[math.random(1, #tab)]
				local loot = ents.Create(item)
				loot:SetPos(self:GetPos() + Vector(0, 0, 32))
				loot:Spawn()
			end

			ply:GiveResources(math.random(200, 400))

			self:EmitSound("Loot.Open")
			self:Remove()
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
