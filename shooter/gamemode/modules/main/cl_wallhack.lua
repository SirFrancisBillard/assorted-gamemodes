
do return end

hook.Add("PostDrawOpaqueRenderables", "Shooter_Wallhack", function()
	do return end
	if LocalPlayer():Team() ~= TEAM_SHOOTERS or not LocalPlayer():Alive() then return end

	-- Reset everything to known good
	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	-- render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilFailOperation(STENCIL_KEEP)
	-- render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()

	-- Enable stencils
	render.SetStencilEnable(true)
	-- Set the reference value to 1. This is what the compare function tests against
	render.SetStencilReferenceValue(1)
	-- Always draw everything
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	-- If something would draw to the screen but is behind something, set the pixels it draws to 1
	render.SetStencilZFailOperation(STENCIL_REPLACE)

	-- Draw our entities. They will draw as normal
	for k, v in pairs(team.GetPlayers(TEAM_POLICE)) do
		if not v:Alive() then continue end
		v:SetupBones()
		v:DrawModel()
	end

	-- Now, only draw things that have their pixels set to 1. This is the hidden parts of the stencil tests.
	render.SetStencilCompareFunction(STENCIL_EQUAL)
	-- Flush the screen. This will draw teal over all hidden sections of the stencil tests
	render.ClearBuffersObeyStencil(0, 150, 255, 255, false)

	-- Let everything render normally again
	render.SetStencilEnable(false)
end)
