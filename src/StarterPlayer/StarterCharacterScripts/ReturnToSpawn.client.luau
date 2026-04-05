-- Category: Teleport

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReturnTeleportFunc = game.ReplicatedStorage.Events:WaitForChild("ReturnTeleportFunc")

local character = script.Parent

-- FIX: Use GetPlayerFromCharacter instead of FindFirstChild
local player = Players:GetPlayerFromCharacter(character)

if not player then
	print("ERROR: Could not find player from character!")
	return
end

print(player.Name .. " - ReturnToSpawn script loaded")

local function returnToInitialSpawn()
	-- Call server function to handle return teleport
	print("Calling server to return to spawn...")
	local success = ReturnTeleportFunc:InvokeServer()

	if success then
		print("âœ“ Successfully returned to spawn")
	else
		print("âœ— Failed to return to spawn")
	end
end

-- Listen for R key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == Enum.KeyCode.R then
		-- Check IsTeleported flag
		local isTeleported = player:GetAttribute("IsTeleported")
		print("R pressed - IsTeleported: " .. tostring(isTeleported))

		if isTeleported == true then
			print("Teleported flag TRUE - returning to spawn")
			returnToInitialSpawn()
		else
			print("Not teleported yet - cannot return (IsTeleported=" .. tostring(isTeleported) .. ")")
		end
	end
end)

-- Cleanup on death
local humanoid = character:WaitForChild("Humanoid")
humanoid.Died:Connect(function()
	player:SetAttribute("IsTeleported", false)
	print(player.Name .. " died - teleport flag cleared")
end)
