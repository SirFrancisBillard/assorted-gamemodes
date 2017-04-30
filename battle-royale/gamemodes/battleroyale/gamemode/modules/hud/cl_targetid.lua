
function GM:HUDDrawTargetID()
	local tr = util.GetPlayerTrace(LocalPlayer())
	local trace = util.TraceLine(tr)
	if not trace.Hit then return end
	if not trace.HitNonWorld then return end
	if not IsValid(trace.Entity) then return end
	if trace.Entity:GetPos():Distance(LocalPlayer():GetPos()) > 160 then return end

	local text = "ERROR"
	local font = "TargetID"

	if trace.Entity:IsPlayer() then
		text = trace.Entity:Nick()
	elseif trace.Entity:GetNWBool("player_corpse", false) then
		text = trace.Entity:GetNWString("player_nick", "Unknown")
	elseif trace.Entity:GetNWBool("is_block", false) then
		text = tostring(trace.Entity:GetNWInt("block_health", 500))
	else
		return
		--text = trace.Entity:GetClass()
	end

	surface.SetFont(font)
	local w, h = surface.GetTextSize(text)

	local MouseX, MouseY = gui.MousePos()

	if MouseX == 0 && MouseY == 0 then
		MouseX = ScrW() / 2
		MouseY = ScrH() / 2
	end

	local x = MouseX
	local y = MouseY

	x = x - w / 2
	y = y + 30

	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 120))
	draw.SimpleText(text, font, x + 2, y + 2, Color(0, 0, 0, 50))
	draw.SimpleText(text, font, x, y, self:GetTeamColor(trace.Entity))

	y = y + h + 5

	local text = trace.Entity:Health() .. "%"
	if trace.Entity:GetNWBool("player_corpse", false) then
		text = "Corpse"
	elseif trace.Entity:GetNWBool("is_block", false) then
		text = self.UpgradeLevels[trace.Entity:GetNWInt("upgrade_level", 1)].name .. (trace.Entity.BattleRoyaleDoor and " Door" or " Block")
	end
	local font = "TargetIDSmall"

	surface.SetFont(font)
	local w, h = surface.GetTextSize(text)
	local x = MouseX - w / 2

	draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 120))
	draw.SimpleText(text, font, x + 2, y + 2, Color(0, 0, 0, 50))
	draw.SimpleText(text, font, x, y, self:GetTeamColor(trace.Entity))
end
