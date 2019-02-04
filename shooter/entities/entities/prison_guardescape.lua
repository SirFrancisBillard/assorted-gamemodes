
ENT.Type = "brush"
ENT.Base = "base_brush"

function ENT:StartTouch(ent)
	if not self:PassesTriggerFilters(ent) then return end
	GAMEMODE:PlayerJoinTeam(ent, TEAM_CRIMINAL)
	ent:ChatPrint("You are now a criminal!")
end

function ENT:PassesTriggerFilters(ent)
	return ent:IsPlayer() and ent:Alive() and ent:Team() == TEAM_GUARD
end
