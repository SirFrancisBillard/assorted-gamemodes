
local hide = {
	CHudHealth = true,
	CHudBattery = true
}

function GM:HUDShouldDraw(name)
	if hide[name] then
		return false
	end

	return true
end
