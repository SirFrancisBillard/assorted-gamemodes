
ENT.Type = "brush"
ENT.Base = "base_brush"

local CloseAfterTime = 4

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Open")
end

function ENT:Initialize()
	self:SetOpen(false)
end

function ENT:AcceptInput(name, activator, caller, data)
	print("one")
	if name:lower() == "use" and caller:IsPlayer() and caller:GetHasKeycard() then
		print("two")
		self:SetOpen(not self:GetOpen())
		if self:GetOpen() then
			self.OpenTime = CurTime()

			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			self:SetColor(ColorAlpha(self:GetColor(), 75))
		else
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
			self:SetColor(ColorAlpha(self:GetColor(), 200))
		end
	end
end

if SERVER then
	function ENT:Think()
		if self:GetOpen() and (CurTime() - self.OpenTime > 4) then
			self:SetOpen()
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
			self:SetColor(ColorAlpha(self:GetColor(), 200))
		end
	end
end
