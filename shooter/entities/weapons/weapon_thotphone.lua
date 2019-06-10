AddCSLuaFile()

SWEP.Base = "weapon_sck_base"

SWEP.PrintName = "iPhone"
SWEP.Instructions = [[
<color=purple>GRIP N SIP</color>]]

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["Detonator"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(14.444, 25.555, 0) },
	["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 52.222, 0) },
	["ValveBiped.Bip01_L_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 36.666, 0) },
	["Slam_base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-9.837, -7.494, -5), angle = Angle(-42.144, -8.414, 53.415) }
}

SWEP.VElements = {
	["phone"] = { type = "Model", model = "models/hunter/blocks/cube2x3x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.42, 2.717, -1.884), angle = Angle(-6.184, -27.959, -90.981), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/concrete0", skin = 0, bodygroup = {} },
	["screen"] = { type = "Model", model = "models/hunter/blocks/cube2x3x025.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "phone", pos = Vector(0, 0, -0.08), angle = Angle(0, 0, 0), size = Vector(0.037, 0.037, 0.037), color = Color(0, 0, 75, 255), surpresslightning = false, material = "phoenix_storms/fender_white", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["phone"] = { type = "Model", model = "models/hunter/blocks/cube2x3x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.46, 2.851, -1.484), angle = Angle(0.059, -65.473, -68.374), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/concrete0", skin = 0, bodygroup = {} },
	["screen"] = { type = "Model", model = "models/hunter/blocks/cube2x3x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "phone", pos = Vector(0, 0, -0.08), angle = Angle(0, 0, 0), size = Vector(0.037, 0.037, 0.037), color = Color(0, 0, 75, 255), surpresslightning = false, material = "phoenix_storms/fender_white", skin = 0, bodygroup = {} }
}

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Delay = 0.5

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.CameraSound = Sound("NPC_CScanner.TakePhoto")

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 8)

	if (IsFirstTimePredicted() or game.SinglePlayer()) and IsValid(self.Owner) and self.Owner:IsPlayer() then
		self:EmitSound(self.CameraSound)
		if SERVER then
			for k, v in pairs(player.GetAll()) do
				if self.Owner:GetPos():DistToSqr(v:GetPos()) < 90000 then
					if v == self.Owner then
						v:SetNWFloat("blinded", CurTime() - 3)
					else
						v:SetNWFloat("blinded", CurTime())
					end
				end
			end
		end
	end
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:SecondaryAttack() end
function SWEP:Reload() end
function SWEP:Think() end

if SERVER then return end

function SWEP:Think()
	local blu = 90 + (math.sin(CurTime() * 1.3) * 8)
	self.VElements["screen"].color.b = blu
	self.WElements["screen"].color.b = blu
end
