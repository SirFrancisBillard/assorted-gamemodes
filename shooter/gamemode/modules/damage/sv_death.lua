
function GM:DoPlayerDeath(ply, atk, dmg)
	ply:CreateRagdoll()
	ply:AddDeaths(1)
	
	if atk:IsValid() and atk:IsPlayer() then
		if atk == ply then
			atk:AddFrags(-1)
		else
			atk:AddFrags(1)
		end
	end
end
