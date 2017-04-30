local PLAYER = FindMetaTable("Player")

function PLAYER:GiveResources(amt)
	self:SetResources(self:GetResources() + amt)
	self:ChatPrint("+" .. string.Comma(tostring(amt)) .. " resources")
end

function PLAYER:TakeResources(amt)
	self:SetResources(math.max(self:GetResources() - amt, 0))
	self:ChatPrint("-" .. string.Comma(tostring(amt)) .. " resources")
end
