
local function emohandle(ply, ducking)
	if CLIENT then return end
	if ply:GetSpecialClass() == CLASS_EMO then
		if ducking then
			if math.Round(CurTime(), 1) % 2 == 1 then
				ply:SetHealth(math.min(ply:Health() + 1, ply:GetMaxHealth()))
			end
			ply:SetLuaAnimation("sit_chell")
		else
			ply:StopLuaAnimation("sit_chell")
		end
	elseif ply:GetSpecialClass() == CLASS_THOT then
		if ducking then
			ply:SetLuaAnimation("sit_alyx")
		else
			ply:StopLuaAnimation("sit_alyx")
		end
	end
end

function GM:HandlePlayerDucking( ply, velocity )
	if not ply:IsFlagSet(FL_ANIMDUCKING) then
		emohandle(ply, false)
		return false
	end

	if velocity:Length2DSqr() > 0.25 then
		emohandle(ply, false)
		ply.CalcIdeal = ACT_MP_CROUCHWALK
	else
		emohandle(ply, true)
		ply.CalcIdeal = ACT_MP_CROUCH_IDLE
	end

	return true
end

do return end -- fucc

local shield = ClientsideModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
shield:SetNoDraw(true)

hook.Add("PostPlayerDraw" , "Shooter_EmoShield" , function(ply)
	if not IsValid(ply) or not ply:Alive() or not ply:GetSpecialClass() == CLASS_EMO then return end

	local pos = ply:GetPos() + ply:OBBCenter()

	shield:SetModelScale(3)
	shield:SetRenderMode(RENDERMODE_TRANSCOLOR)
	shield:SetColor(Color(255, 0, 255, ply:GetNWInt("emo_charge", 0)))
	shield:SetPos(pos)
	shield:SetRenderOrigin(pos)
	shield:SetupBones()
	shield:DrawModel()
end)
