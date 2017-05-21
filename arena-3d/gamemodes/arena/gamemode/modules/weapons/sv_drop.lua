
hook.Add("KeyPress", "Arena.DropWeapon", function(ply, key)
	if key == IN_ZOOM then
		local wep = ply:GetActiveWeapon()
		if IsValid(ply) and ply:IsPlayer() and ply:Alive() and IsValid(wep) and wep:IsWeapon() and wep:GetClass() ~= "weapon_pistol" then
			ply:DropWeapon(wep)
		end
	end
end)
