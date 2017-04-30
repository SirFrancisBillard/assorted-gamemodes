local PLAYER = FindMetaTable("Player")

function PLAYER:CanArrest()
	return self:Team() == TEAM_CRIMINAL
end

function PLAYER:Arrest()
	GAMEMODE:PlayerJoinTeam(self, TEAM_PRISONER)
	self:Kill()
end
