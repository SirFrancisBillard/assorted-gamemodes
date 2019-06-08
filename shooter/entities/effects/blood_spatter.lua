-- yuck

local gorescale = CreateConVar("shooter_gorescale", 3)

EFFECT.Mat = Material("effects/blood_core")

local function DecalMaker(part, pos, norm)
	util.Decal("Blood", pos + norm, pos - norm)

	part:SetEndSize(math.random(14, 20))
	part:SetEndAlpha(0)
	part:SetDieTime(3)
end

function EFFECT:Init(data)
	local pos = data:GetOrigin()
	if not pos then return false end

	self.Emitter = ParticleEmitter(pos)

	local scale = math.Round(gorescale:GetInt())

	for i = 1, math.random(6, 9) * scale do
		local part = self.Emitter:Add("effects/blood_core", pos)

		part:SetVelocity(VectorRand() * math.Rand(40, 50) * (1 + (scale * 0.1)))
		part:SetDieTime(20)

		part:SetStartAlpha(255)
		part:SetEndAlpha(100)

		part:SetStartSize(math.random(10, 15))
		part:SetEndSize(math.random(5, 10))

		part:SetColor(math.random(120, 130), 0, 0)
		part:SetCollide(true)
		part:SetGravity(Vector(0, 0, -450))
		part:SetRollDelta(math.random(-10, 10))
		part:SetCollideCallback(DecalMaker)
	end
end

function EFFECT:Think() end
function EFFECT:Render() end