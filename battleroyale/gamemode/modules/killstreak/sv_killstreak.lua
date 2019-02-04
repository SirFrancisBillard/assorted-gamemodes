
-- called on the attacker of every kill
function GM:PlayerKillstreak(ply)
	-- if this ever runs, we have a serious problem
	if not type(ply:GetKillstreak()) == "number" then
		ply:SetKillstreak(1)
		return
	end

	if ply:GetKillstreak() % 5 == 0 then
		-- i will give 400 bucks to whomever can get this string.Comma to make a difference
		ply:ChatPrint("Killstreak: " .. string.Comma(ply:GetKillstreak()))
		ply:ChatPrint("Airdrop inbound")

		local drop = ents.Create("ent_dropnade_proj")
		drop:SetPos(ply:GetPos() + Vector(0, 0, 16))
		
		drop:SetOwner(ply)
		drop:SetThrower(ply)

		drop:SetGravity(0.4)
		drop:SetFriction(0.2)
		drop:SetElasticity(0.45)

		drop:Spawn()
		drop:PhysWake()

		-- must be called after the drop initializes
		drop:SetDetonateExact(CurTime() + 1)
	end
end
