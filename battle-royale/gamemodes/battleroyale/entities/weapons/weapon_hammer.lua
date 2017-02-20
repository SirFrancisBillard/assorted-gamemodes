AddCSLuaFile()

SWEP.HoldType = "pistol"

SWEP.PrintName = "Upgrading Hammer"
SWEP.Category = "Battle Royale"
SWEP.Instructions = "Left click to repair an object. Right click to upgrade an object."

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Slot = 5
SWEP.ViewModelFOV = 54

SWEP.Base = "weapon_br_base"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModelFlip = false

local maxrange = 256

function SWEP:GetClass()
	return "weapon_hammer"
end

function SWEP:ShouldDropOnDie()
	return false
end

local required = GAMEMODE.UpgradeLevels[1].cost
local maxdist = 256

function SWEP:PrimaryAttack()
	return -- REMOVE
end

function SWEP:CanSecondaryAttack()
	self.Owner:LagCompensation(true)
	local tr = self.Owner:GetEyeTrace()
	self.Owner:LagCompensation(false)
	return tr.Hit and IsValid(tr.Entity) and tr.Entity:GetNWBool("is_block")
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
	if SERVER and IsValid(self.Owner) then
		self.Owner:LagCompensation(true)
		local tr = self.Owner:GetEyeTrace()
		self.Owner:LagCompensation(false)
		if not tr.Hit or not IsValid(tr.Entity) then return end
		local trent = tr.Entity
		if not trent:GetNWBool("is_block") then
			self.Owner:ChatPrint("Can't upgrade: Not a block!")
			return
		end
		local block = GAMEMODE.UpgradeLevels[trent:GetNWInt("upgrade_level", 1)]
		local next_block = GAMEMODE.UpgradeLevels[trent:GetNWInt("upgrade_level", 1) + 1]
		if not next_block then
			self.Owner:ChatPrint("Can't upgrade: Already fully upgraded!")
			return
		end
		if self.Owner:GetNWInt("br_resources", 0) < next_block.cost then
			self.Owner:ChatPrint("Can't upgrade: Not enough resources!")
			return
		end
		self.Owner:SetNWInt("br_resources", self.Owner:GetNWInt("br_resources", 0) - next_block.cost)
		self.Owner:ChatPrint("-" .. next_block.cost .. " resources")
		trent:SetNWInt("upgrade_level", trent:GetNWInt("upgrade_level", 1) + 1)
		trent:SetNWInt("block_health", next_block.health)
		trent:SetMaterial(next_block.mat)
	end
end

function SWEP:Reload() end

local function around( val )
	return math.Round( val * (10 ^ 3) ) / (10 ^ 3);
end

local color_red = Color(255, 0, 0)
local color_green = Color(0, 255, 0)

if CLIENT then
	local surface = surface

	function SWEP:UpdateGhost(pos, c, a)
		if IsValid(self.Ghost) then
			if self.Ghost:GetPos() != pos then
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
		if self.Owner:GetNWInt("br_resources", 0) < required or plytr.HitPos:Distance(LocalPlayer():GetPos()) > maxdist then
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
