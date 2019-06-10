
hook.Add("KeyPress", "Shooter_HandleSliding", function(ply, key)
	if not IsFirstTimePredicted() then return end
	if not ply.LastSlide then ply.LastSlide = 0 end
	if ply:OnGround() and key == IN_DUCK and ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 150 and CurTime() - 0.7 > ply.LastSlide and not ply.Sliding then
		ply.LastSlide = CurTime()
		ply:EmitSound("npc/zombie/foot_slide" .. math.random(3) .. ".wav")
		ply:SetLuaAnimation("baseball_slide")
		ply.Sliding = true
	end
end)

hook.Add("SetupMove", "Shooter_HandleSliding", function(ply, mv, cmd)
	if not ply.LastSlide then ply.LastSlide = 0 end
	if ply.Sliding then
		mv:SetForwardSpeed(300)
		cmd:SetForwardMove(300)
	end
	if (CurTime() - 0.6 > ply.LastSlide and mv:GetVelocity():Length() > 1) and ply.Sliding then
		ply.Sliding = false
		ply:StopLuaAnimation("baseball_slide")
	end
end)
