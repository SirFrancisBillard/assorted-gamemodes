
function GM:RegisterAmmo(id, name)
	local n = name or "Bullets"
	game.AddAmmoType({name = "battleroyale_" .. id})
	if CLIENT then
		language.Add("battleroyale_" .. id .. "_ammo", n)
	end
end