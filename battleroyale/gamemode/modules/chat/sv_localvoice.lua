
function GM:PlayerCanHearPlayersVoice(l, t)
	if not IsValid(l) or not IsValid(t) then return false end
	local l_wep = l:GetActiveWeapon()
	local t_wep = t:GetActiveWeapon()
	if l:GetPos():Distance(t:GetPos()) <= 1024 then
		return true, true
	elseif IsValid(l_wep) and IsValid(t_wep) and l_wep:GetClass() == "weapon_walkietalkie" and t_wep:GetClass() == "weapon_walkietalkie" then
		return true, false
	else
		return false
	end
end
