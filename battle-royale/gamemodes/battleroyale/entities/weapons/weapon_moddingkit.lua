AddCSLuaFile()

-- this is a fucking stupid way
-- to mod weapons, but I guess
-- it works

SWEP.HoldType = "normal"

SWEP.PrintName = "Gun Modding Kit"
SWEP.Instructions = "Left click and switch to a weapon to mod that weapon.\nRight click for a list of moddable weapons."

SWEP.Slot = 5
SWEP.ViewModelFOV = 10

SWEP.Base = "weapon_br_base"

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

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

function SWEP:GetClass()
	return "weapon_moddingkit"
end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.5)
	if SERVER and IsValid(self.Owner) then
		self.WillModNextGun = not self.WillModNextGun
		self.Owner:ChatPrint(self.WillModNextGun and "Switch to a weapon to mod..." or "Modding disabled")
	end
end

function SWEP:SecondaryAttack()
	if SERVER and IsValid(self.Owner) then
		self.Owner:ChatPrint("Moddable weapons: Colt M16A4, Sako 85, Ruger 10/22, Siminov SKS")
	end
end

function SWEP:Reload() end

function SWEP:Deploy()
	if SERVER and IsValid(self.Owner) then
		self.Owner:DrawViewModel(false)
		self.Owner:ChatPrint(self.Instructions)
		self.WillModNextGun = false
	end
	self:DrawShadow(false)
	return true
end

function SWEP:Holster(wep)
	if SERVER and self.WillModNextGun and GAMEMODE.ModdableGuns[wep:GetClass()] then
		-- HACK
		-- set a variable to stop ChatPrint from
		-- being run twice
		self.DoneModding = true
		self.Owner:ChatPrint("Weapon has been modded")
		self.Owner:Give(GAMEMODE.ModdableGuns[wep:GetClass()])
		self.Owner:SelectWeapon("weapon_fists")
		self.Owner:StripWeapon(wep:GetClass())
		self.Owner:StripWeapon(self.ClassName)
	elseif SERVER and self.WillModNextGun and not self.DoneModding then
		self.Owner:ChatPrint("Weapon is not moddable\nNo mods have been applied")
	end
	return true
end

function SWEP:DrawWorldModel() end

function SWEP:DrawWorldModelTranslucent() end
