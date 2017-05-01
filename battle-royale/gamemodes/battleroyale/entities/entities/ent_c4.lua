AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "C4"
ENT.Spawnable = false

ENT.Model = "models/weapons/w_c4_planted.mdl"

local PlantSound = Sound("C4.Plant")
local BeepSound = Sound("C4.PlantSound")
local SoundNear = Sound("Explosion.Near")
local SoundFar = Sound("Explosion.Far")

function ENT:Initialize()
	self:EmitSound(PlantSound)
end

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

		self:PhysWake()

		for i = 1, 10 do
			timer.Simple(i, function()
				if IsValid(self) then
					self:EmitSound(BeepSound)
				end
			end)
		end

		timer.Simple(11, function()
			if IsValid(self) then
				self:Explosion()
			end
		end)
	end

	local badprops = {
		["models/props_interiors/vendingmachinesoda01a.mdl"] = true,
		["models/props_interiors/vendingmachinesoda01a_door.mdl"] = true
	}

	local IsDoor = {
		["prop_door_rotating"] = true,
		["func_door"] = true,
		["func_door_rotating"] = true
	}

	local IsProp = {
		["prop_physics"] = true,
		["prop_ragdoll"] = true
	}

	local function findents(pos, radius)
		local props = {}
		local doors = {}
		for k, v in pairs(ents.FindInSphere(pos, radius)) do
			if IsValid(v) and IsDoor[v:GetClass()] then
				table.insert(doors, v)
			elseif IsValid(v) and IsProp[v:GetClass()] then
				table.insert(props, v)
			end
		end
		return props, doors
	end

	function ENT:Explosion()
		local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetRadius(1000)
			effectdata:SetMagnitude(1000)
		util.Effect("HelicopterMegaBomb", effectdata, true, true)

		local exploeffect = EffectData()
			exploeffect:SetOrigin(self:GetPos())
			exploeffect:SetStart(self:GetPos())
		util.Effect("Explosion", exploeffect, true, true)

		local shake = ents.Create("env_shake")
			shake:SetOwner(self.ItemOwner)
			shake:SetPos(self:GetPos())
			shake:SetKeyValue("amplitude", "500")
			shake:SetKeyValue("radius", "500")
			shake:SetKeyValue("duration", "2.5")
			shake:SetKeyValue("frequency", "255")
			shake:SetKeyValue("spawnflags", "4")
			shake:Spawn()
			shake:Activate()
			shake:Fire("StartShake", "", 0)

		local push = ents.Create("env_physexplosion")
			push:SetOwner(self.ItemOwner)
			push:SetPos(self:GetPos())
			push:SetKeyValue("magnitude", 100)
			push:SetKeyValue("radius", 500)
			push:SetKeyValue("spawnflags", 2+16)
			push:Spawn()
			push:Activate()
			push:Fire("Explode", "", 0)
			push:Fire("Kill", "", .25)

		net.Start("br_gunshot")
			net.WriteEntity(self)
			net.WriteString(SoundNear)
			net.WriteString(SoundFar)
		net.Broadcast()

		util.BlastDamage(self, self.ItemOwner, self:GetPos(), 250, 800)

		self:Remove()
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end
