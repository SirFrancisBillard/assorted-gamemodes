AddCSLuaFile()

SWEP.HoldType = "normal"

SWEP.PrintName = "Building Tool"
SWEP.Instructions = "Left click to place a barricade"

SWEP.Slot = 5
SWEP.ViewModelFOV = 10

SWEP.Base = "weapon_br_base"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.AllowDelete = false
SWEP.AllowDrop = false
SWEP.NoSights = true

SWEP.ShootSound = Sound("Airboat.FireGunRevDown")

local ghostmdl = Model("models/Items/combine_rifle_ammo01.mdl")
function SWEP:Initialize()
	if CLIENT then
      -- create ghosted indicator
		local ghost = ents.CreateClientProp(ghostmdl)
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

function SWEP:GetClass()
	return "weapon_buildingtool"
end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.5)
	if SERVER and IsValid(self.Owner) then
		self.Owner:LagCompensation(true)
		local tr = self.Owner:GetEyeTrace()
		self.Owner:LagCompensation(false)
		local prop = ents.Create("prop_physics")
		prop:SetModel(ghostmdl)
		
	end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end
