AddCSLuaFile()

SWEP.HoldType = "pistol"

SWEP.PrintName = "Building Tool"
SWEP.Category = "Battle Royale"
SWEP.Instructions = "Left click to place an object. Right click to choose object."

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Slot = 5
SWEP.ViewModelFOV = 54

SWEP.Base = "weapon_br_base"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Primary.Sound = Sound("Block.Place")

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModelFlip = false

local OBJ_BLOCK = 1
local OBJ_DOOR = 2

SWEP.ObjectProperties = {
	[OBJ_BLOCK] = {
		name = "Block",
		health_multiplier = 1,
		cost_multiplier = 1,
		created_entity = "prop_physics",
		entity_model = Model("models/hunter/blocks/cube075x075x075.mdl")
	},
	[OBJ_DOOR] = {
		name = "Door",
		health_multiplier = 0.5,
		cost_multiplier = 1,
		created_entity = "ent_door",
		entity_model = Model("models/hunter/blocks/cube075x075x075.mdl")
	}
}

local maxrange = 256

function SWEP:SetupDataTables()
	self.BaseClass.SetupDataTables(self)

	self:NetworkVar("Int", 0, "CurrentObject")
end

function SWEP:Initialize()
	self:SetCurrentObject(OBJ_BLOCK)

	if CLIENT then
		-- create ghosted indicator
		local ghost = ents.CreateClientProp(self.ObjectProperties[OBJ_BLOCK].entity_model)
		if IsValid(ghost) then
			ghost:SetPos(self:GetPos())
			ghost:Spawn()

			-- PhysPropClientside whines here about not being able to parse the
			-- physmodel. This is not important as we won't use that anyway, and it
			-- happens in sandbox as well for the ghosted ents used there.

			ghost:SetSolid(SOLID_NONE)
			ghost:SetMoveType(MOVETYPE_NONE)
			ghost:SetNotSolid(true)
			ghost:SetRenderMode(RENDERMODE_TRANSCOLOR)
			ghost:AddEffects(EF_NOSHADOW)
			ghost:SetNoDraw(true)

			self.Ghost = ghost
		end
	end

	self:SetCurrentObject(OBJ_BLOCK)

	return self.BaseClass.Initialize(self)
end

function SWEP:PreDrop()
	-- OnDrop does not happen on client
	self:CallOnClient("HideGhost", "")
end

function SWEP:HideGhost()
	if IsValid(self.Ghost) then
		self.Ghost:SetNoDraw(true)
	end
end

function SWEP:Holster()
	if CLIENT and IsValid(self.Ghost) then
		self.Ghost:SetNoDraw(true)
	end

	return self.BaseClass.Holster(self)
end

function SWEP:ShouldDropOnDie()
	return false
end

local default_cost = GAMEMODE.UpgradeLevels[1].cost
local maxdist = 256

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.1)
	if SERVER and IsValid(self.Owner) then
		self.Owner:LagCompensation(true)
		local tr = self.Owner:GetEyeTrace()
		self.Owner:LagCompensation(false)
		if not tr.Hit then return end
		if tr.HitPos:Distance(self.Owner:GetPos()) > maxdist then
			self.Owner:ChatPrint("Cannot place: Too far away!")
			return
		end
		local obj = self.ObjectProperties[self:GetCurrentObject()]
		if not obj then self:SetCurrentObject(1) return end
		local required = default_cost * obj.cost_multiplier
		if self.Owner:GetResources() < required then
			self.Owner:ChatPrint("Cannot place: Not enough resources!")
			return
		end
		self.Owner:TakeResources(required)
		local prop = ents.Create(obj.created_entity)
		prop:SetModel(obj.entity_model)
		local pos = tr.HitPos + tr.HitNormal * 18
		pos.x = math.Round(pos.x / 36) * 36
		pos.y = math.Round(pos.y / 36) * 36
		pos.z = math.Round(pos.z / 36) * 36
		prop:SetPos(pos)
		prop:Spawn()
		prop:SetNWBool("is_block", true)
		prop:SetNWInt("upgrade_level", 1)
		prop:SetNWInt("block_health", GAMEMODE.UpgradeLevels[1].health * obj.health_multiplier)
		prop:SetMaterial(GAMEMODE.UpgradeLevels[1].mat)
		prop:GetPhysicsObject():EnableMotion(false)
		prop:EmitSound(self.Primary.Sound)
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)

	local cur = self:GetCurrentObject()
	local nxt = cur + 1

	if #self.ObjectProperties < nxt then
		nxt = OBJ_BLOCK
	end

	self:SetCurrentObject(nxt)

	if SERVER then
		self.Owner:ChatPrint("Now placing object: " .. self.ObjectProperties[nxt].name)
	end
end

function SWEP:Reload() end

local color_red = Color(255, 0, 0)
local color_green = Color(0, 255, 0)

if CLIENT then
	local surface = surface

	function SWEP:UpdateGhost(pos, c, a)
		if IsValid(self.Ghost) then
			if self.Ghost:GetPos() ~= pos then
				self.Ghost:SetPos(pos)
				self.Ghost:SetAngles(angle_zero)
				self.Ghost:SetColor(Color(c.r, c.g, c.b, a))
				self.Ghost:SetNoDraw(false)
			end
		end
	end

	local linex = 0
	local liney = 0
	local laser = Material("trails/laser")

	function SWEP:ViewModelDrawn()
		local client = LocalPlayer()
		local vm = client:GetViewModel()
		if not IsValid(vm) then return end

		local plytr = client:GetEyeTrace(MASK_SHOT)

		local muzzle_angpos = vm:GetAttachment(1)
		local spos = muzzle_angpos.Pos + muzzle_angpos.Ang:Forward() * 10
		local epos = client:GetShootPos() + client:GetAimVector() * maxrange

		-- painting beam
		local tr = util.TraceLine({start = spos, endpos = epos, filter = client, mask = MASK_ALL})

		local c = color_green
		local required = default_cost * self.ObjectProperties[self:GetCurrentObject()].cost_multiplier
		if self.Owner:GetResources() < required or plytr.HitPos:Distance(LocalPlayer():GetPos()) > maxdist then
			c = color_red
		end
		local a = 150
		local d = (plytr.StartPos - plytr.HitPos):Length()

		local pos = plytr.HitPos + plytr.HitNormal * 18
		pos.x = math.Round(pos.x / 36) * 36
		pos.y = math.Round(pos.y / 36) * 36
		pos.z = math.Round(pos.z / 36) * 36

		self:UpdateGhost(pos, c, a)
	end
end
