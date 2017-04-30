AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

-- hey what's up guys pewdiepie here
-- today we're gonna be opening a
-- package sent to me by my sponsor
ENT.PrintName = "Loot Crate"
ENT.Category = "Battle Royale"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_OPAQUE

local model_closed = "models/props/CS_militia/footlocker01_closed.mdl"
local model_open = "models/props/CS_militia/footlocker01_open.mdl"

if SERVER then
	function ENT:Initialize()
		self:SetModel(model_closed)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysWake()
	end

	function ENT:Use(ply)
		-- checking the model instead of a dedicated variable seems like a sloppy way of doing this, but
		-- minimizing the need for networked variables is good and the default model functions are already
		-- networked because this runs on the server.
		if IsValid(ply) and ply:IsPlayer() and self:GetModel():lower() == model_closed:lower() then
			self:SetModel(model_open)
			-- todo: config for the time here
			timer.Simple(60, function()
				if not IsValid(self) then return end
				self:SetModel(model_closed)
			end)
			local randy = math.random(1, 100)
			local tab
			if randy <= 60 then
				tab = table.GetKeys(GAMEMODE.LootTable.Bad)
			elseif randy <= 90 then
				tab = table.GetKeys(GAMEMODE.LootTable.Okay)
			else
				tab = table.GetKeys(GAMEMODE.LootTable.Good)
			end
			if not tab then return end
			local item = tab[math.random(1, #tab)]
			local loot = ents.Create(item)
			loot:SetPos(self:GetPos() + Vector(0, 0, 32))
			loot:Spawn()
			ply:GiveResources(math.random(20, 80))
			self:EmitSound("Loot.Open")
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
