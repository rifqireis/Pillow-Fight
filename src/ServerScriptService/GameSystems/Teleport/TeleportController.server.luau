local TeleportUtil = require(game.ReplicatedStorage.Systems.Teleport.TeleportUtil)
local ReturnTeleportFunc = game.ReplicatedStorage.Events:WaitForChild("ReturnTeleportFunc")

print("TeleportController started - Using IsTeleported flag")

local function setupTeleporterDetection()
	local tpPad = game.Workspace:FindFirstChild("TpPad")
	if not tpPad then
		print("ERROR: TpPad folder not found!")
		return
	end

	local teleporters = tpPad:GetChildren()
	print("Found", #teleporters, "teleporters. Setting up detection...")

	for _, teleporter in teleporters do
		if teleporter:IsA("Part") then
			teleporter.Touched:Connect(function(hit)
				-- Get player from character
				local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
				if not humanoid then
					return
				end

				local player = game.Players:FindFirstChild(hit.Parent.Name)
				if not player then
					return
				end

				print("Teleporter", teleporter.Name, "touched by", player.Name)

				-- Teleport using extracted spawn number
				local success = TeleportUtil.teleportToSpawn(player, teleporter.Name)
				if success then
					-- FREEZE: Set WalkSpeed to 0
					humanoid.WalkSpeed = 0
					-- SET FLAG: Mark player as teleported
					player:SetAttribute("IsTeleported", true)
					print("âœ“", player.Name, "FROZEN at", teleporter.Name)
					print("  WalkSpeed set to:", humanoid.WalkSpeed)
					print("  IsTeleported set to TRUE")
				else
					print("âœ— Teleport failed for", player.Name)
				end
			end)
		end
	end

	print("âœ“ All teleporters set up with freeze enabled")
end

-- Handle Return Teleport (triggered from client via R key)
ReturnTeleportFunc.OnServerInvoke = function(player)
	if not player:GetAttribute("IsTeleported") then
		print("Player", player.Name, "tried to return but not teleported")
		return false
	end

	-- Get player character
	if not player.Character then
		print("Player", player.Name, "has no character")
		return false
	end

	local character = player.Character
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	-- Get initial spawn
	local initialSpawn = game.Workspace:FindFirstChild("SpawnLocation")
	if not initialSpawn or not initialSpawn:IsA("Part") then
		print("ERROR: Initial SpawnLocation not found!")
		return false
	end

	-- Teleport back
	local safePos = initialSpawn.Position + Vector3.new(0, 5, 0)
	character:MoveTo(safePos)

	-- Unfreeze
	humanoid.WalkSpeed = 16

	-- CLEAR FLAG
	player:SetAttribute("IsTeleported", false)

	print("âœ“", player.Name, "returned to spawn - UNFROZEN")
	return true
end

-- Initialize
setupTeleporterDetection()
