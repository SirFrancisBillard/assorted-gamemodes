AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

ENT.PrintName = "Door"
ENT.Category = "Battle Royale"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_BOTH

ENT.BattleRoyaleDoor = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/hunter/blocks/cube075x075x075.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)

		self:PhysWake()

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end

		self:SetNWBool("is_block", true)
		self:SetNWInt("upgrade_level", 1)
		self:SetNWInt("block_health", GAMEMODE.UpgradeLevels[1].health / 2)

		self:SetMaterial(GAMEMODE.UpgradeLevels[1].mat)
		self:SetColor(ColorAlpha(self:GetColor(), 200))

		self:EmitSound("Block.Place")

		self.Auth = {}
		self.Password = 1337
	end

	function ENT:ToggleDoor()
		if self:GetCollisionGroup() == COLLISION_GROUP_WEAPON then
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
			self:SetColor(ColorAlpha(self:GetColor(), 200))
		else
			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			self:SetColor(ColorAlpha(self:GetColor(), 75))
		end
		self:EmitSound("Door.Open")
	end

	function ENT:Use(ply)
		if IsValid(ply) and ply:IsPlayer() then
			if not self.Auth[ply:SteamID()] then
				net.Start("br_openkeypadmenu")
				net.WriteEntity(self)
				net.Send(ply)
				return
			end
			self:ToggleDoor()
		end
	end

	net.Receive("br_sendkeypadcode", function(len, ply)
		local ent = net.ReadEntity()
		local pass = net.ReadString()
		if not IsValid(ent) or not ent:GetClass() == "ent_door" then
			ply:ChatPrint("Can't open: Invalid door!")
			return
		end
		if not type(pass) == "string" or #pass > 24 then
			ply:ChatPrint("Can't open: Invalid password!")
			return
		end
		-- check if we have a real password yet
		if type(ent.Password) == "number" then
			-- set the password and auth them
			ent.Password = pass
			ent.Auth[ply:SteamID()] = true
			ent:EmitSound("Door.Auth")
			return
		end
		if ent.Password == pass then
			ent.Auth[ply:SteamID()] = true
			ent:EmitSound("Door.Auth")
			return
		end
	end)
else
	function ENT:Draw()
		self:DrawModel()
	end

	function ENT:DrawTranslucent()
		self:Draw()
	end

	net.Receive("br_openkeypadmenu", function(len)
		local sendto = net.ReadEntity()
		Derma_StringRequest(
			"Keypad",
			"Enter password for entry",
			"",
			function(text)
				if #text > 24 then
					LocalPlayer():ChatPrint("Password too long!")
					return
				end
				net.Start("br_sendkeypadcode")
				net.WriteEntity(sendto)
				net.WriteString(tostring(text))
				net.SendToServer()
			end
		)
	end)
end
