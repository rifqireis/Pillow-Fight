-- Category: Combat

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- --- AUTO DETECT R6 / R15 ---
local rigType = humanoid.RigType
local animID = "rbxassetid://73236479277487" -- ID kamu

-- --- SETUP ANIMASI ---
local animator = humanoid:FindFirstChild("Animator") or Instance.new("Animator", humanoid)

local animInstance = Instance.new("Animation")
animInstance.AnimationId = animID

local track = animator:LoadAnimation(animInstance)
track.Priority = Enum.AnimationPriority.Action
track.Looped = false -- MEMASTIKAN ANIMASI TIDAK MENGULANG

-- --- TOMBOL E (PLAY SEKALI) ---
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.E then
		-- Menghentikan animasi jika sedang jalan, lalu mainkan lagi dari awal
		track:Stop()
		track:Play()
		print("Animasi dimainkan sekali!")
	end
end)
