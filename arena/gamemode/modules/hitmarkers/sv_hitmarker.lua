
util.AddNetworkString("br_hitmarker")

hook.Add("ScalePlayerDamage", "BattleRoyale.HitMarker", function(ply, hit, dmg)
	local attacker = dmg:GetAttacker()
	if attacker:IsPlayer() then
		net.Start("br_hitmarker")
			net.WriteBool(true)
		net.Send(attacker)
	end
end)
