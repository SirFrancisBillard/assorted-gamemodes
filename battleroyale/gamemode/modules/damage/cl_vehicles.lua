
local center_player_offset = Vector(0,2.5,0)

net.Receive("br_vehicledamage", function()
	local victim = net.ReadEntity()
	local seat = net.ReadEntity()
	if IsValid(victim) and IsValid(seat) then
		local trace_offset = net.ReadVector()
		local effect = EffectData()
		effect:SetEntity(victim)
		effect:SetOrigin(seat:LocalToWorld(seat:WorldToLocal(victim:GetBonePosition(4)) + center_player_offset + trace_offset))
		util.Effect("BloodImpact", effect, false)
	end
end)
