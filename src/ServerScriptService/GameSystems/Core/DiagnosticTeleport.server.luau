-- DIAGNOSTIC: Check if TeleportController is working
local function diagnose()
	wait(2) -- Give time for scripts to initialize

	print("\n" .. string.rep("=", 60))
	print("TELEPORT SYSTEM DIAGNOSTIC")
	print(string.rep("=", 60) .. "\n")

	-- Check TeleportController exists and enabled
	local tc = game.ServerScriptService.GameSystems.Teleport.TeleportController
	print("TeleportController:")
	print("  Enabled: " .. tostring(tc.Enabled))
	print("  Has Source: " .. tostring(#tc.Source > 0))

	-- Check if touch events are connected
	local tpPad = game.Workspace:FindFirstChild("TpPad")
	if tpPad then
		print("\nTpPad folder:")
		local teleporters = tpPad:GetChildren()
		print("  Teleporters found: " .. #teleporters)

		-- Test a single teleporter
		if teleporters[1] then
			local tp = teleporters[1]
			print("  First teleporter: " .. tp.Name)
			print("    CanCollide: " .. tostring(tp.CanCollide))
			print("    Position: " .. tostring(tp.Position))
		end
	else
		print("\nERROR: TpPad folder NOT found!")
	end

	-- Check TeleportUtil
	print("\nTeleportUtil:")
	local success, tu = pcall(function()
		return require(game.ReplicatedStorage.Systems.Teleport.TeleportUtil)
	end)
	if success then
		print("  Loaded: OK")
		print("  Available functions:")
		for k, v in pairs(tu) do
			if type(v) == "function" then
				print("    â€¢ " .. k)
			end
		end
	else
		print("  ERROR: " .. tostring(tu))
	end

	-- Check for active players
	print("\nPlayers:")
	local players = game:GetService("Players"):GetPlayers()
	print("  Count: " .. #players)
	for _, p in ipairs(players) do
		print("  â€¢ " .. p.Name .. " (character: " .. tostring(p.Character ~= nil) .. ")")
	end

	print("\n" .. string.rep("=", 60) .. "\n")
end

diagnose()
