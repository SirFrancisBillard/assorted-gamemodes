function GM:SetupMove(ply, mv, cmd)
	self.BaseClass.SetupMove(self)

	local jumping = bit.band(move:GetButtons(), IN_JUMP) ~= 0
	if jumping and ply:GetStamina() < 10 then
		ply:ChatPrint("Not enough stamina to jump!")
		mv:SetUpSpeed(0)
	elseif jumping then
		ply:SetStamina(math.max(ply:GetStamina() - 10, 0))
	end
end
