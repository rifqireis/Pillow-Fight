-- Location: ServerScriptService > GameSystems > DamageHandler
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local damageEvent = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DamageEvent")

-- Config
local DAMAGE_AMOUNT = 15
local MAX_RANGE = 15 -- Jarak maksimum player bisa klik 'E'

damageEvent.OnServerEvent:Connect(function(player, enemyHumanoid)
	-- 1. Validasi Keberadaan
	if not player.Character or not enemyHumanoid then
		return
	end

	local attackerRoot = player.Character:FindFirstChild("HumanoidRootPart")
	local enemyRoot = enemyHumanoid.Parent:FindFirstChild("HumanoidRootPart")

	if attackerRoot and enemyRoot then
		-- 2. Validasi Jarak (Sanity Check)
		-- Mencegah exploiter membunuh dari ujung map
		local distance = (attackerRoot.Position - enemyRoot.Position).Magnitude

		if distance <= MAX_RANGE then
			-- 3. Kurangi Darah
			enemyHumanoid:TakeDamage(DAMAGE_AMOUNT)
			print(player.Name .. " menyerang " .. enemyHumanoid.Parent.Name .. " | Sisa HP: " .. enemyHumanoid.Health)

			-- 4. Cek Kematian (Reset)
			if enemyHumanoid.Health <= 0 then
				-- Logika tambahan jika mati (misal tambah skor)
				-- Roblox otomatis menangani animasi kematian dan respawn player
				print(enemyHumanoid.Parent.Name .. " telah tewas!")
			end
		else
			warn(player.Name .. " mencoba menyerang dari jarak jauh! (Ditolak)")
		end
	end
end)
