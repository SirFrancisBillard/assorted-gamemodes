AddCSLuaFile()

GAMEMODE:RegisterAmmo("rpg", "Rockets")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "Rocket Launcher"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Launch a rocket.
Rockets will explode upon contact with a surface.]]

SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"
SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "battleroyale_rpg"

SWEP.Primary.SoundNear = "Weapon_RPG.Near"
SWEP.Primary.SoundFar = "Weapon_RPG.Far"

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

SWEP.ReloadRate = 0.8

function SWEP:Initialize()
	self.BaseClass.Initialize(self)

	self:SetHoldType("rpg")
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:ShootEffects()

	if SERVER then
		GAMEMODE:Gunshot(self)
	end

	if SERVER then
		local rocket = ents.Create("ent_rocket")

		if not IsValid(rocket) then return end

		rocket:SetOwner(self.Owner)
		rocket:SetPos(self.Owner:EyePos())
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket:Spawn()

		local phys = rocket:GetPhysicsObject()
		if not IsValid(phys) then rocket:Remove() return end

		local velocity = self.Owner:GetAimVector()
		velocity = velocity * 2500
		phys:ApplyForceCenter(velocity)
	end

	if self.Owner:GetAmmoCount(self.Primary.Ammo) > self.Primary.DefaultClip then
		self.Owner:SetAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
	end

	self.Owner:RemoveAmmo(1, self.Primary.Ammo)

	self:Reload()
end

function SWEP:CanSecondaryAttack()
	return false
end

