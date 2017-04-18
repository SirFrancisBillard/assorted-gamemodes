function GM:ShowTeam()
	if IsValid(self.TeamSelectFrame) then return end

	self.TeamSelectFrame = vgui.Create("DFrame")
	self.TeamSelectFrame:SetTitle("Pick Team")

	local AllTeams = team.GetAllTeams()
	local y = 30

	for ID, TeamInfo in pairs (AllTeams) do
		if ID ~= TEAM_CONNECTING and ID ~= TEAM_UNASSIGNED then
			local Team = vgui.Create("DButton", self.TeamSelectFrame)
			function Team.DoClick() self:HideTeam() RunConsoleCommand("changeteam", ID) end
			Team:SetPos(10, y)
			Team:SetSize(130, 20)
			Team:SetText(TeamInfo.Name)
			
			if IsValid(LocalPlayer()) and LocalPlayer():Team() == ID then
				Team:SetDisabled(true)
			end

			y = y + 30
		end
	end

	local Team = vgui.Create("DButton", self.TeamSelectFrame)
	function Team.DoClick() self:HideTeam() RunConsoleCommand("autoteam") end
	Team:SetPos(10, y)
	Team:SetSize(130, 20)
	Team:SetText("Auto")
	y = y + 30

	self.TeamSelectFrame:SetSize(150, y)
	self.TeamSelectFrame:Center()
	self.TeamSelectFrame:MakePopup()
	self.TeamSelectFrame:SetKeyboardInputEnabled(false)
end

function GM:HideTeam()
	if IsValid(self.TeamSelectFrame) then
		self.TeamSelectFrame:Remove()
		self.TeamSelectFrame = nil
	end
end
