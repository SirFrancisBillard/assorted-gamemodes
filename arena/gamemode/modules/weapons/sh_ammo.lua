
function GM:RegisterAmmo(id, name)
	local n = name or "Bullets"
	game.AddAmmoType({name = "arena_" .. id})
	if CLIENT then
		language.Add("arena_" .. id .. "_ammo", n)
	end
end