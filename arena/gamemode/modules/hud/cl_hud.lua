
surface.CreateFont("Arena_HUD", {
	font = "Trebuchet",
	size = 24,
})

function GM:HUDPaint()
	self.BaseClass.HUDPaint(self)

	local font = "Arena_HUD"
	local ply = LocalPlayer()
	local hp = ply:Health()
	local hearts = math.ceil(hp / 25)

	if hearts > 0 then
		for i = 1, hearts do
		end
	end

	-- other guy's hud that i stole

	local ply = LocalPlayer()
	
	if not ply:Alive() then
		return
	end

	local wep = ply:GetActiveWeapon()
	local health = ply:Health()
	local armor = ply:Armor()
	
	-- Health and Armor --
	draw.RoundedBox(0, 0, ScrH() - 100, 250, 100, Color(30, 30, 30, 230)) -- Draw HUD Health background
	
	-- Health --
	draw.SimpleText("Health: " .. health, "DermaDefaultBold", 10, ScrH() - 90, Color(255, 255, 255, 255), 0, 0) -- Text
	draw.RoundedBox(0, 10, ScrH() - 75, 100 * 2.25, 15, Color(255, 0, 0, 30)) -- Ghost box showing 100%
	draw.RoundedBox(0, 10, ScrH() - 75, math.Clamp(ply:Health(), 0, 100) * 2.25, 15, Color(255, 0, 0, 255)) -- Actual health 
	draw.RoundedBox(0, 10, ScrH() - 75, math.Clamp(ply:Health(), 0, 100) * 2.25, 5, Color(255, 30, 30, 255)) -- Actual health highlight

	-- Armor --
	draw.SimpleText("Armor: " .. armor, "DermaDefaultBold", 10, ScrH() - 45, Color(255, 255, 255, 255), 0, 0) -- Text
	draw.RoundedBox(0, 10, ScrH() - 30, 100 * 2.25, 15, Color(0, 0, 255, 30)) -- Ghost box showing 100%
	draw.RoundedBox(0, 10, ScrH() - 30, math.Clamp(armor, 0, 100) * 2.25, 15, Color(0, 0, 255, 255)) -- Actual ammo
	draw.RoundedBox(0, 10, ScrH() - 30, math.Clamp(armor, 0, 100) * 2.25, 5, Color(15, 15, 255, 255)) -- Actual ammo highlight

	-- Weapon and Ammo --
	draw.RoundedBox(0, 255, ScrH() - 70, 125, 70, Color(30, 30, 30, 230)) -- Draw HUD Wep and Armor background

	if IsValid(wep) and wep.GetPrintName then -- If the active wep has a pretty name, use it
		draw.SimpleText(wep:GetPrintName(), "DermaDefaultBold", 260, ScrH() - 60, Color(255, 255, 255, 255), 0, 0)
	end

	if IsValid(wep) and wep:Clip1() ~= -1 and wep.GetPrimaryAmmoType then -- If the main clip has a weird ammo val, don't use it
		draw.SimpleText("Ammo: " .. wep:Clip1() .. "/" .. ply:GetAmmoCount(wep:GetPrimaryAmmoType()), "DermaDefaultBold", 260, ScrH() - 40, Color(255, 255, 255, 255), 0, 0)
	elseif IsValid(wep) and wep.GetPrimaryAmmoType then
		draw.SimpleText("Ammo: " .. ply:GetAmmoCount(wep:GetPrimaryAmmoType()), "DermaDefaultBold", 260, ScrH() - 40, Color(255, 255, 255, 255), 0, 0)
	end

	if IsValid(wep) and wep.GetSecondaryAmmoType and (ply:GetAmmoCount(wep:GetSecondaryAmmoType()) > 0) then
		draw.SimpleText("Secondary: " .. ply:GetAmmoCount(wep:GetSecondaryAmmoType()), "DermaDefaultBold", 260, ScrH() - 25, Color(255, 255, 255, 255), 0, 0)
	end
end
