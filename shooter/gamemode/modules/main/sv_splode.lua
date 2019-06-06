
local function splode(pos)
	if util.IsInWorld(pos) then return end
	local boom = EffectData()
	boom:SetOrigin(self:GetPos())
	util.Effect("Explosion", boom)

	util.BlastDamage(self, self:GetOwner(), self:GetPos(), 800, 120)
	util.ScreenShake(self:GetPos(), 20, 1, 1, 5000)
	sound.Play("ambient/explosions/explode_" .. math.random(3, 4) .. ".wav", self:GetPos(), 160, math.random(60, 80), 1)
end

function PropaneBomb(pos, size)
	if not size then size = 128 end
	print("idk")
end
