AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

-- hey what's up guys pewdiepie here
-- today we're gonna be opening a
-- package sent to me by my sponsor
ENT.PrintName = "Loot Crate"

ENT.Spawnable = true
ENT.AdminOnly = true

local color_red = Color(255, 0, 0)
local color_green = Color(0, 255, 0)

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/Items/ammocrate_smg1.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetSequence(1)
		self:PhysWake()
		self:SetColor(color_green)
	end

	function ENT:Use(ply)
		-- checking colors instead of a dedicated variable
		-- seems like a sloppy way of doing this, but
		-- minimizing the need for networked variables is
		-- good and the default color functions are already
		-- networked and this only runs on the server anyway.
		if IsValid(ply) and ply:IsPlayer() and self:GetColor().g == color_green.g then
			self:SetColor(color_red)
			-- todo: config for the time here
			timer.Simple(45, function()
				if not IsValid(self) then return end
				self:SetColor(color_green)
			end)
			local randy = math.random(1, 100)
			local tab
			if randy <= 50 then
				tab = table.GetKeys(GAMEMODE.LootTable.Bad)
			elseif randy <= 85 then
				tab = table.GetKeys(GAMEMODE.LootTable.Okay)
			else
				tab = table.GetKeys(GAMEMODE.LootTable.Good)
			end
			if not tab then return end
			local item = tab[math.random(1, #tab)]
			local loot = ents.Create(item)
			loot:SetPos(self:GetPos() + Vector(0, 0, 32))
			loot:Spawn()
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
