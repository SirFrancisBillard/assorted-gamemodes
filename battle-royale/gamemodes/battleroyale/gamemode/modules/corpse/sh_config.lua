
GM.RagdollTypes = {
	[RAGTYPE_DEFAULT] = {
		num_ragdolls = 1,
		bone_mods = {
			[1] = {}
		},
		on_create = function() end
	},
	[RAGTYPE_GIB] = { -- FIXME?
		num_ragdolls = 1,
		bone_mods = {
			[1] = {}
		},
		on_create = function() end
	},
	[RAGTYPE_DECAP] = {
		num_ragdolls = 1,
		bone_mods = {
			[1] = {
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
			}
		},
		on_create = function() end
	},
	[RAGTYPE_BISECT] = {
		num_ragdolls = 2,
		bone_mods = {
			[1] = {
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine3"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)}
			},
			[2] = {
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			}
		},
		on_create = function() end
	},
	[RAGTYPE_AMPUTATE] = {
		num_ragdolls = 5,
		bone_mods = {
			[1] = { -- head
				--["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_Neck"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine3"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			},
			[2] = { -- left arm
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine3"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			},
			[3] = { -- right arm
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine3"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			},
			[4] = { -- left leg
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine3"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			},
			[5] = { -- right leg
				["ValveBiped.Bip01_Head1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Neck"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine1"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine2"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_Spine3"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Clavicle"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_UpperArm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Forearm"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_R_Hand"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Thigh"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Calf"] = {scale = Vector(0, 0, 0)},
				["ValveBiped.Bip01_L_Foot"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Thigh"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Calf"] = {scale = Vector(0, 0, 0)},
				--["ValveBiped.Bip01_R_Foot"] = {scale = Vector(0, 0, 0)}
			}
		},
		on_create = function() end
	}
}
