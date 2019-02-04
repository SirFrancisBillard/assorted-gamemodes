function GM:ShowTeam(ply) end

function GM:PlayerRequestTeam(ply, teamid) end

function GM:PlayerJoinTeam(ply, teamid)
	local iOldTeam = ply:Team()

	if ply:Alive() then
		if iOldTeam == TEAM_SPECTATOR or iOldTeam == TEAM_UNASSIGNED then
			ply:KillSilent()
		else
			ply:Kill()
		end
	end

	player_manager.SetPlayerClass(ply, team.GetClass(teamid)[1])
	ply:SetTeam(teamid)
	ply.LastTeamSwitch = RealTime()

	GAMEMODE:OnPlayerChangedTeam(ply, iOldTeam, teamid)
end
