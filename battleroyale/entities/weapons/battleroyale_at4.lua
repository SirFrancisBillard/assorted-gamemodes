AddCSLuaFile()

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "AT4"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Launch a rocket.
Rockets will explode upon contact with a surface.]]

SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Primary.Sound = Sound("Weapon_RPG.Single")

SWEP.Primary.Delay = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawAmmo = true

SWEP.HoldType = "rpg"

SWEP.NoSights = true

function SWEP:CanPrimaryAttack()
	return not self.used
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:ShootEffects()

	self:EmitSound(self.Primary.Sound)

	if SERVER then
		local rocket = ents.Create("ent_warhead")

		if not IsValid(rocket) then return end

		rocket:SetOwner(self.Owner)
		rocket:SetPos(self.Owner:EyePos())
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket:Spawn()

		local phys = rocket:GetPhysicsObject()
		if not IsValid(phys) then rocket:Remove() return end

		local velocity = self.Owner:GetAimVector()
		velocity = velocity * 10000
		phys:ApplyForceCenter(velocity)
	end

	self.used = true
	self.used_time = CurTime()
end

function SWEP:Holster()
	return (not self.used) or (CurTime() - self.used_time > 1)
end

function SWEP:Think()
	if SERVER and self.used and CurTime() - self.used_time > 1 and not self.dropped then
		self.dropped = true
		self.Owner:ConCommand("lastinv")
		self.Owner:StripWeapon(self.ClassName)
	end
end

