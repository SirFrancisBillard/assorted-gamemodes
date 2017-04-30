
net.Receive("br_ragdoll", function(len)
	local ply = net.ReadEntity()
	local rag_type = net.ReadInt(RAGTYPE_BITS)
	local master_tab = GAMEMODE.RagdollTypes[rag_type]

	if not type(master_tab) == "table" then return end

	for i = 1, master_tab.num_ragdolls do
		local tab = master_tab.bone_mods
	end
end)
