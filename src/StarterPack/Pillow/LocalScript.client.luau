local tool = script.Parent
local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Ambil HitEvent dari ReplicatedStorage
local hitEvent = ReplicatedStorage:WaitForChild("HitEvent")

local canAttack = true
local isEquipped = false

-- Cek apakah tool sedang dipegang
tool.Equipped:Connect(function()
	isEquipped = true
end)
tool.Unequipped:Connect(function()
	isEquipped = false
end)

uis.InputBegan:Connect(function(input, gameProcessed)
	-- Pastikan tidak lagi ngetik di chat, sedang pegang bantal, dan cooldown selesai
	if gameProcessed then
		return
	end
	if not isEquipped then
		return
	end

	if input.KeyCode == Enum.KeyCode.E and canAttack then
		canAttack = false

		-- Beri feedback ke pemain (misal: bantal bergerak sedikit)
		print("Pukul!")

		-- Kirim sinyal ke Server
		hitEvent:FireServer()

		task.wait(1) -- Cooldown 1 detik
		canAttack = true
	end
end)
