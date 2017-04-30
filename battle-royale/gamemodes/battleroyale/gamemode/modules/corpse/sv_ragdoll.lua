
util.AddNetworkString("br_ragdoll")

local PLAYER = FindMetaTable("Player")

function PLAYER:RagdollOnClient(rag_type)
	if rag_type > RAGTYPE_MAX then
		rag_type = RAGTYPE_MAX
	end

	net.Start("br_ragdoll")
		net.WriteEntity(self)
		net.WriteInt(rag_type, RAGTYPE_BITS)
	net.Broadcast()
end
