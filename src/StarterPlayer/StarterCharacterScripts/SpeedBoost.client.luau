-- Category: Movement

local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local BOOST_MULTIPLIER = 3
local isBoosted = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		if not isBoosted then
			isBoosted = true
			humanoid.WalkSpeed = humanoid.WalkSpeed * BOOST_MULTIPLIER
			print("SPEED BOOST ACTIVATED")
		end
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		if isBoosted then
			isBoosted = false
			humanoid.WalkSpeed = humanoid.WalkSpeed / BOOST_MULTIPLIER
			print("Speed boost deactivated")
		end
	end
end)
humanoid.Died:Connect(function()
	isBoosted = false
end)
print("SpeedBoost ready")
