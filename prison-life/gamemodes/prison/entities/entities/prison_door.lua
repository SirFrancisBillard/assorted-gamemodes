
ENT.Type = "brush"
ENT.Base = "base_brush"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Open")
end

function ENT:Initialize()
	self:SetOpen(false)
end

function ENT:AcceptInput(name, activator, caller, data)
	if name:lower() == "use" and caller:IsPlayer() and caller:GetHasKeycard() then
		self:SetOpen(not self:GetOpen())
		if self:GetOpen() then

		else

		end
	end
end
