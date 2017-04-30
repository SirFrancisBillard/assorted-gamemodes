local PLAYER = FindMetaTable("Player")

function PLAYER:HasResources(amt)
	return self:GerResources() >= amt
end

