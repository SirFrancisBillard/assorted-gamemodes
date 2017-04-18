function GM:ShowTeam(ply)
	local TimeBetweenSwitches = 10

	if ply.LastTeamSwitch and RealTime() - ply.LastTeamSwitch < TimeBetweenSwitches then
		ply.LastTeamSwitch = ply.LastTeamSwitch + 1
		ply:ChatPrint(Format("Please wait %i more seconds before trying to change team again", (TimeBetweenSwitches - (RealTime() - ply.LastTeamSwitch)) + 1))
		return false
	end

	ply:SendLua("GAMEMODE:ShowTeam()")
end
