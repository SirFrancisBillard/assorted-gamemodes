
ENT.Type = "brush"
ENT.Base = "base_brush"

function ENT:KeyValue(key, value)
	if string.lower(tostring(key)) == "door" then
		self.door = tostring(value)
	end
end

function ENT:StartTouch(ent)
	if not self:PassesTriggerFilters(ent) then return end
	if type(self.door) ~= "string" then return end

	for k, v in pairs(ents.FindByName(self.door)) do
		v:Fire("Open")
	end
end

function ENT:PassesTriggerFilters(ent)
	return ent:IsPlayer() and ent:Alive() and ent:GetHasKeycard()
end
