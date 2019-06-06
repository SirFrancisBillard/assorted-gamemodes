AddCSLuaFile()

game.AddAmmoType({name = "pipebomb"})
if CLIENT then
	language.Add("pipebomb_ammo", "Pipebombs")
end

SWEP.Base = "weapon_sck_base"

SWEP.PrintName = "Pipebombs"
SWEP.Instructions = [[
<color=green>[PRIMARY FIRE]</color> Throw a Pipebomb.
<color=green>[SECONDARY FIRE]</color> Light without throwing.]]

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false

SWEP.Spawnable = true	
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pipebomb"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(2.864, 1.064, -0.076), angle = Angle(-18.674, -49.312, 11.041) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(27.777, 16.666, -7.778) }
}

SWEP.VElements = {
	["tube"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "pipe", pos = Vector(0.324, -4.803, 0.155), angle = Angle(15.256, -5.452, 94.862), size = Vector(0.046, 0.046, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["fuse"] = { type = "Model", model = "models/Gibs/HGIBS_rib.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tube", pos = Vector(-1.778, -0.817, -1.772), angle = Angle(-153.896, 134.841, -113.311), size = Vector(0.331, 0.331, 0.331), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sparks"] = { type = "Sprite", sprite = "sprites/fire", bone = "ValveBiped.Bip01_Spine4", rel = "fuse", pos = Vector(-1.724, 2.279, -0.325), size = { x = 1.34, y = 1.34 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = false, vertexcolor = false, ignorez = false},
	["zippo"] = { type = "Model", model = "models/props_junk/metalgascan.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.572, 2.096, 1.827), angle = Angle(-7.803, 57.376, 0), size = Vector(0.145, 0.145, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pipe"] = { type = "Model", model = "models/props_vehicles/carparts_axel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.171, 2.319, -1.474), angle = Angle(-8.464, 81.113, -101.962), size = Vector(0.173, 0.173, 0.173), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["tube"] = { type = "Model", model = "models/hunter/tubes/tube1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "pipe", pos = Vector(0.324, -4.803, 0.155), angle = Angle(15.256, -5.452, 94.862), size = Vector(0.046, 0.046, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["fuse"] = { type = "Model", model = "models/Gibs/HGIBS_rib.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "tube", pos = Vector(-1.778, -0.817, -1.772), angle = Angle(-153.896, 134.841, -113.311), size = Vector(0.331, 0.331, 0.331), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pipe"] = { type = "Model", model = "models/props_vehicles/carparts_axel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.941, 2.312, -0.452), angle = Angle(1.169, 73.636, -97.014), size = Vector(0.173, 0.173, 0.173), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["zippo"] = { type = "Model", model = "models/props_junk/metalgascan.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.952, 1.717, 0.319), angle = Angle(-4.189, 50.113, 13.279), size = Vector(0.145, 0.145, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Lit")
	self:NetworkVar("Bool", 1, "ThrowWhenReady")
	self:NetworkVar("Int", 0, "ThrowTime")
end

function SWEP:ResetVars()
	self:SetLit(false)
	self:SetThrowWhenReady(false)
	self:SetThrowTime(0)

	self.EmitIgniteSound = 0
end

function SWEP:Initialize()
	self.BaseClass.Initialize(self)

	self:SetWeaponHoldType("grenade")

	self:ResetVars()
end

function SWEP:ThrowPrimed()
	return self:GetThrowTime() ~= 0 and CurTime() >= self:GetThrowTime()
end

function SWEP:Holster()
	local holst = self.BaseClass.Holster(self)
	if holst then
		self:ResetVars()
	end
	return holst
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:CanSecondaryAttack()
	return true
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	if self:GetLit() and self:ThrowPrimed() then
		self:Throw()
	else
		self:Light()
		self:SetThrowWhenReady(true)
	end
end

function SWEP:SecondaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	if not self:GetLit() and not self:ThrowPrimed() then
		self:Light()
	end
end

function SWEP:Think()
	if self:GetThrowWhenReady() and self:ThrowPrimed() then
		self:Throw()
	end

	if self.EmitIgniteSound ~= 0 and self.EmitIgniteSound <= CurTime() then
		self:EmitSound("ambient/fire/mtov_flame2.wav")
		self.EmitIgniteSound = 0
	end

	self:NextThink(CurTime() + 0.1)
	return true
end

function SWEP:Light()
	if self:GetLit() then return end

	self:SendWeaponAnim(ACT_VM_PULLBACK_HIGH)

	self.EmitIgniteSound = CurTime() + 0.6

	self:SetLit(true)
	self:SetThrowTime(CurTime() + 2)
end

function SWEP:Throw()
	self:ResetVars()

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")

	if SERVER then
		local molly = ents.Create("ent_pipebomb")
		molly:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector() * 20)
		molly:SetOwner(self.Owner)
		molly:Spawn()
		molly:GetPhysicsObject():ApplyForceCenter(self.Owner:GetAimVector() * 800)

		self.Owner:RemoveAmmo(1, self.Primary.Ammo)
		if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			self:SendWeaponAnim(ACT_VM_DRAW)
		else
			self.Owner:ConCommand("lastinv")
			self.Owner:StripWeapon(self.ClassName)
		end
	end
end
