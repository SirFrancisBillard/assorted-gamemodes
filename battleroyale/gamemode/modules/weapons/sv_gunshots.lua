
util.AddNetworkString("br_gunshot")

function GM:Gunshot(wep)
	if not IsValid(wep) or not IsValid(wep.Owner) then return end

	net.Start("br_gunshot")
		net.WriteEntity(wep)
		net.WriteString(wep.Primary.SoundNear)
		net.WriteString(wep.Primary.SoundFar)
	net.Broadcast()
end
