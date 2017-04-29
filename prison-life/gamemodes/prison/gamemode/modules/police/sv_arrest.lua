local PLAYER = FindMetaTable("Player")

function PLAYER:CanArrest()
	return self:Team() == TEAM_CRIMINAL
end

function PLAYER:Arrest()
	self:SetTeam(TEAM_PRISONER)
	self:Kill()
end
