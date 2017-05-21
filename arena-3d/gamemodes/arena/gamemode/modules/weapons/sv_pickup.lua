
function GM:PlayerCanPickupWeapon(ply, wep)
	return not ply:HasWeapon(wep:GetClass())
end
