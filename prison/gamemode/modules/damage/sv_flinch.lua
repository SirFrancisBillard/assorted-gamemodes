
resource.AddFile("rust/headshot.wav")

util.AddNetworkString("ShowPlayerFlinch")

local HeadshotSound = Sound("rust/headshot.wav")

hook.Add("EntityTakeDamage", "PlayerFlinchOnHeadshot", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and ent:LastHitGroup() == HITGROUP_HEAD then
		ent:EmitSound(HeadshotSound)
		ent:AnimRestartGesture(GESTURE_SLOT_FLINCH, ACT_FLINCH_HEAD, true)
		net.Start("ShowPlayerFlinch")
		net.WriteInt(ent:EntIndex(), 8)
		net.Broadcast()
	end
end)
