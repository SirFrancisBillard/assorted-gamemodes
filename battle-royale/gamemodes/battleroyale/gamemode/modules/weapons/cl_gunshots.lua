
net.Receive("br_gunshot", function(len)
	local ply = net.ReadEntity()
	local pos = ply:GetPos()
	local near = Sound(net.ReadString())
	local far = Sound(net.ReadString())

	if LocalPlayer():GetPos():DistToSqr(pos) > 10000000 then
		ply:StopSound(far)
		ply:EmitSound(far)
	else
		ply:StopSound(near)
		ply:EmitSound(near)
	end
end)
