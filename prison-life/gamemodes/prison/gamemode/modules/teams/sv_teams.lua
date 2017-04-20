function GM:ShowTeam(ply)
	local TimeBetweenSwitches = 10

	if ply.LastTeamSwitch and RealTime() - ply.LastTeamSwitch < TimeBetweenSwitches then
		ply.LastTeamSwitch = ply.LastTeamSwitch + 1
		ply:ChatPrint(Format("Please wait %i more seconds before trying to change team again", (TimeBetweenSwitches - (RealTime() - ply.LastTeamSwitch)) + 1))
		return false
	end

	ply:SendLua("GAMEMODE:ShowTeam()")
end

function GM:PlayerRequestTeam(ply, teamid)
	if not team.Joinable(teamid) then
		ply:ChatPrint("You can't join that team")
	return end

	GAMEMODE:PlayerJoinTeam(ply, teamid)
end

function GM:PlayerJoinTeam(ply, teamid)
	local iOldTeam = ply:Team()

	if ply:Alive() and not teamid == TEAM_CRIMINAL then
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
