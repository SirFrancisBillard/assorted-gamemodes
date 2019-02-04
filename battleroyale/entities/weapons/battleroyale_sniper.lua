AddCSLuaFile()

GAMEMODE:RegisterAmmo("sniper")

SWEP.Base = "battleroyale_baseweapon"

SWEP.PrintName = "Sniper Rifle"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Fire a bullet.
<color=green>[SECONDARY FIRE]</color> Toggle zoom.]]

SWEP.ViewModel = "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scout.mdl"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Primary.DefaultClip = 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "battleroyale_sniper"

SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 1.5
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 2
SWEP.Primary.Sound = Sound("Weapon_Scout.Single")

SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.HoldType = "ar2"
SWEP.SprintType = "passive"

SWEP.ViewModelPos = Vector(-0.44, 0, -1)
SWEP.ViewModelAng = Vector(0, 0, 0)

SWEP.NoSights = true

function SWEP:SetupDataTables()
	self.BaseClass.SetupDataTables(self)

	self:NetworkVar("Bool", 3, "Zoomed")
end

function SWEP:SetZoom(state)
	if CLIENT then
		return
	elseif IsValid(self.Owner) and self.Owner:IsPlayer() then
		if state then
			self.Owner:SetFOV(20, 0.3)
			self.Owner:DrawViewModel(false)
		else
			self.Owner:SetFOV(0, 0.2)
			self.Owner:DrawViewModel(true)
		end
	end
end

function SWEP:PrimaryAttack()
	self.BaseClass.PrimaryAttack(self)
	self:SetNextSecondaryFire(CurTime() + 0.1)
end

-- add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
	if self:GetNextSecondaryFire() > CurTime() or self:GetReloading() then return end

	local bIronsights = not self:GetZoomed()

	self:SetZoomed(bIronsights)

	if SERVER then
		self:SetZoom(bIronsights)
	else
		self:EmitSound(self.Secondary.Sound)
	end

	self:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:OnRemove()
	self:SetZoom(false)
	self:SetZoomed(false)
end

function SWEP:Reload()
	if self.BaseClass.Reload(self) then
		self:SetZoomed(false)
		self:SetZoom(false)
	end
end

function SWEP:Holster()
	self:SetZoomed(false)
	self:SetZoom(false)

	return self.BaseClass.Holster(self)
end

if CLIENT then
	local scope = surface.GetTextureID("sprites/scope")
	function SWEP:DrawHUD()
		if self:GetZoomed() then
			surface.SetDrawColor(0, 0, 0, 255)
			
			local scrW = ScrW()
			local scrH = ScrH()

			local x = scrW / 2.0
			local y = scrH / 2.0
			local scope_size = scrH

			-- crosshair
			local gap = 80
			local length = scope_size
			surface.DrawLine(x - length, y, x - gap, y)
			surface.DrawLine(x + length, y, x + gap, y)
			surface.DrawLine(x, y - length, x, y - gap)
			surface.DrawLine(x, y + length, x, y + gap)

			gap = 0
			length = 50
			surface.DrawLine(x - length, y, x - gap, y)
			surface.DrawLine(x + length, y, x + gap, y)
			surface.DrawLine(x, y - length, x, y - gap)
			surface.DrawLine(x, y + length, x, y + gap)

			-- cover edges
			local sh = scope_size / 2
			local w = (x - sh) + 2
			surface.DrawRect(0, 0, w, scope_size)
			surface.DrawRect(x + sh - 2, 0, w, scope_size)
			
			-- cover gaps on top and bottom of screen
			surface.DrawLine(0, 0, scrW, 0)
			surface.DrawLine(0, scrH - 1, scrW, scrH - 1)

			surface.SetDrawColor(255, 0, 0, 255)
			surface.DrawLine(x, y, x + 1, y + 1)

			-- scope
			surface.SetTexture(scope)
			surface.SetDrawColor(255, 255, 255, 255)

			surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)
		else
			return self.BaseClass.DrawHUD(self)
		end
	end

	function SWEP:AdjustMouseSensitivity()
		return (self:GetZoomed() and 0.2) or nil
	end
end
