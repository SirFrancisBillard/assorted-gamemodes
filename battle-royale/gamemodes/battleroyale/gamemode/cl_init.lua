include("shared.lua")

function GM:SpawnMenuOpen()
	return LocalPlayer():IsAdmin()
end

function GM:ContextMenuOpen()
	return LocalPlayer():IsAdmin()
end

net.Receive("br_openperkmenu", function(len)
	local PerkFrame = vgui.Create("DFrame")
	PerkFrame:SetSize(600, 300)
	PerkFrame:Center()
	PerkFrame:SetDraggable(true)
	PerkFrame:ShowCloseButton(true)
	PerkFrame:MakePopup()
	PerkFrame:SetTitle("Inventory")
	function PerkFrame:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 200))
	end
end)
