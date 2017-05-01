
local bonechildcache = {}

local function BGOGetBoneChildrenRecursive(ent, bone)
	local mdl = ent:GetModel()
	if bonechildcache[mdl] and bonechildcache[mdl][bone] then return bonechildcache[mdl][bone] end
	bonechildcache[mdl] = bonechildcache[mdl] or {}
	local bones = {}
	local childbones = ent:GetChildBones(bone)

	for k, v in pairs(childbones) do
		local tmpbones = BGOGetBoneChildrenRecursive(ent, v)

		for k, v in ipairs(tmpbones) do
			bones[#bones + 1] = v
		end
	end

	bones[#bones + 1] = bone
	bonechildcache[mdl][bone] = table.Copy(bones)

	return bones
end

local function BGOScaleBone(ent, bone, scale)
	scale = scale and scale or vector_origin
	local bones = BGOGetBoneChildrenRecursive(ent, bone)
	local bm = ent:GetBoneMatrix(bone)

	for k, i in pairs(bones) do
		if bone ~= i then
			ent:SetBoneMatrix(i, bm)
		end

		ent:ManipulateBoneScale(i, scale)
		local physbone = ent:TranslateBoneToPhysBone(i)

		if physbone and physbone <= 0 then
			local phys = ent:GetPhysicsObjectNum(physbone)

			if IsValid(phys) then
				phys:SetMass(0.5)
			end
		end
	end
end

net.Receive("br_ragdoll", function(len)
	local ply = net.ReadEntity()
	print(ply:GetPos())
	local rag_type = net.ReadInt(RAGTYPE_BITS)
	local master_tab = GAMEMODE.RagdollTypes[rag_type]
	print("client got type " .. rag_type)

	if not IsValid(ply) or not type(master_tab) == "table" then return end

	local rags = {}
	for a = 1, #master_tab.bone_mods do
		print("ragdoll made " .. a)
		rags[a] = ClientsideRagdoll(ply:GetModel())

		rags[a]:SetNoDraw(false)
		rags[a]:DrawShadow(true)
		rags[a]:SetPos(ply:GetPos())
		rags[a]:SetAngles(ply:GetAngles())
		rags[a]:SetColor(ply:GetColor())

		-- nonsolid to players, but can be picked up and shot
		rags[a]:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		timer.Simple(1, function()
			if IsValid(rags[a]) then
				rags[a]:CollisionRulesChanged()
			end
		end)

		-- clean corpse in a minute
		SafeRemoveEntityDelayed(rags[a], 60)

		-- position the bones
		local num = rags[a]:GetPhysicsObjectCount() - 1
		for i = 0, num do
			local bone = rags[a]:GetPhysicsObjectNum(i)
			if IsValid(bone) then
				local bp, ba = ply:GetBonePosition(rags[a]:TranslatePhysBoneToBone(i))
				if bp and ba then
					bone:SetPos(bp)
					bone:SetAngles(ba)
				end

				bone:SetVelocity(vector_origin)
			end
		end

		-- fixme
		for k, v in pairs(master_tab.bone_mods[a]) do
			if not rags[a]:LookupBone(k) then
				print("INVALID BONE: " .. k)
				continue
			end

			BGOScaleBone(rags[a], rags[a]:LookupBone(k), Vector(0, 0, 0))
		end

		master_tab.on_create(ply, rags[a])
	end
end)
