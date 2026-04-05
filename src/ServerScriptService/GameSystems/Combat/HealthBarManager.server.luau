local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- RemoteEvent untuk komunikasi server-client
local showHealthBarEvent = Instance.new("RemoteEvent")
showHealthBarEvent.Name = "ShowHealthBarEvent"
showHealthBarEvent.Parent = ReplicatedStorage

local function onPlayerAdded(player)
	-- Tunggu character spawn
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")

		-- Fungsi untuk update health bar
		local function updateHealthBar()
			local health = humanoid.Health
			local maxHealth = humanoid.MaxHealth
			local healthPercentage = math.max(0, math.min(1, health / maxHealth))

			showHealthBarEvent:FireClient(player, "UpdateHealth", healthPercentage)
		end

		-- Connect health changed event
		humanoid.HealthChanged:Connect(updateHealthBar)

		-- Update awal
		updateHealthBar()
	end)
end

-- Connect untuk player yang join
Players.PlayerAdded:Connect(onPlayerAdded)

-- Loop untuk player yang sudah ada
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

-- Deteksi ketika player menyentuh DestinationPart
local destinationPart = workspace:FindFirstChild("DestinationPart")
if destinationPart then
	local debounce = {}

	destinationPart.Touched:Connect(function(otherPart)
		local character = otherPart.Parent
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local player = Players:GetPlayerFromCharacter(character)

		if player and humanoid and not debounce[player] then
			debounce[player] = true

			-- Kirim event ke client untuk menampilkan health bar
			showHealthBarEvent:FireClient(player, "ShowHealthBar")

			-- Reset debounce setelah 2 detik
			task.wait(2)
			debounce[player] = nil
		end
	end)
else
	warn("DestinationPart tidak ditemukan di Workspace!")
end
