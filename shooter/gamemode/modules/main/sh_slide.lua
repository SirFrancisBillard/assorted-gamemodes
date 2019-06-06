
hook.Add("KeyPress", "Shooter_HandleSliding", function(ply, key)
	if not IsFirstTimePredicted() then return end
	if not ply.LastSlide then ply.LastSlide = 0 end
	if ply:OnGround() and key == IN_DUCK and ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 150 and CurTime() - 1 > ply.LastSlide and not ply.Sliding then
		ply.LastSlide = CurTime()
		ply:EmitSound("npc/zombie/foot_slide" .. math.random(3) .. ".wav")
		ply:SetLuaAnimation("baseball_slide")
		ply.Sliding = true
	end
end)

hook.Add("SetupMove", "Shooter_HandleSliding", function(ply, mv, cmd)
	if not IsFirstTimePredicted() then return end
	if not ply.LastSlide then ply.LastSlide = 0 end
	if not ply:KeyDown(IN_DUCK) or (CurTime() - 1 > ply.LastSlide and mv:GetVelocity():Length() > 1) and ply.Sliding then
		ply.Sliding = false
		ply:StopLuaAnimation("baseball_slide")
	end
end)
