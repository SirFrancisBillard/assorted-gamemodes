AddCSLuaFile()

GAMEMODE:RegisterAmmo("c4", "Plastic Explosive")

SWEP.PrintName = "C4"
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Instructions = "<color=green>[PRIMARY FIRE]</color> Plant C4 on a nearby surface."

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false

SWEP.Spawnable = true
SWEP.Category = "Battle Royale"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "battleroyale_c4"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 2)
	if SERVER then
		local tr = util.TraceLine({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + 100 * self.Owner:GetAimVector(),
			filter = {self.Owner}
		})

		local c4 = ents.Create("ent_c4")
		c4:SetPos(tr.HitPos)
		c4:SetAngles(tr.HitNormal:Angle() - Angle(90, 180, 0))
		c4:Spawn()

		c4.ItemOwner = self.Owner

		if tr.Entity and IsValid(tr.Entity) then
			if tr.Entity:GetPhysicsObject():IsValid() then
				c4:SetParent(tr.Entity)
			elseif not tr.Entity:IsNPC() and not tr.Entity:IsPlayer() and tr.Entity:GetPhysicsObject():IsValid() then
				constraint.Weld(c4, tr.Entity)
			end
		else
			c4:SetMoveType(MOVETYPE_NONE)
		end

		hook.Call("PlayerPlaceC4", nil, self.Owner, tr.Entity)

		if not tr.Hit then
			c4:SetMoveType(MOVETYPE_VPHYSICS)
		end
	end
end

function SWEP:SecondaryAttack() end
