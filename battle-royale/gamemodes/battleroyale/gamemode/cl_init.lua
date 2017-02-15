include("shared.lua")

function GM:SpawnMenuOpen()
	return LocalPlayer():IsAdmin()
end

function GM:ContextMenuOpen()
	return LocalPlayer():IsAdmin()
end
