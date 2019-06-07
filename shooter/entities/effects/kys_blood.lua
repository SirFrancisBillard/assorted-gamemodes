-- yuck

EFFECT.Mat = Material("effects/blood_core")

local function DecalMaker(part, pos, norm)
	util.Decal("Blood", pos + norm, pos - norm)

	part:SetEndSize(math.random(14, 20))
	part:SetEndAlpha(0)
	part:SetDieTime(3)
end

function EFFECT:Init(data)
	self.Barfer = data:GetEntity()
	self.DieTime = CurTime() + .1

	if not self.Barfer or not IsValid(self.Barfer) or not self.Barfer:IsPlayer() then print("aaaaaaaaaaaaaaaaaaaaaaaaa")return false end

	self.Emitter = ParticleEmitter(self.Barfer:EyePos())
end

function EFFECT:Think()
	if not self.Barfer or not IsValid(self.Barfer) or not self.Barfer:IsPlayer() or CurTime() > self.DieTime then self.Emitter:Finish() return false end
	
	local SpawnPos = self.Barfer:EyePos() + (self.Barfer:EyeAngles():Forward() * 10) + (self.Barfer:EyeAngles():Up() * -6)
	local Dir = self.Barfer:EyeAngles():Right() * -1

	local part = self.Emitter:Add("effects/blood_core", SpawnPos)

	part:SetVelocity((Dir + VectorRand() * 0.1) * math.Rand(200, 300))
	part:SetDieTime(20)
	
	part:SetStartAlpha(255)
	part:SetEndAlpha(100)
	
	part:SetStartSize(math.random(10, 15))
	part:SetEndSize(math.random(5, 10))
	
	part:SetColor(128, 80, 0)
	part:SetCollide(true)
	part:SetGravity(Vector(0, 0, -450))
	part:SetRollDelta(math.random(-10, 10))
	part:SetCollideCallback(DecalMaker)
	
	return true
end

function EFFECT:Render() end