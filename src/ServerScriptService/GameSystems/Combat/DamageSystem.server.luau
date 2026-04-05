local ReplicatedStorage = game:GetService("ReplicatedStorage")
local hitEvent = ReplicatedStorage.Events:WaitForChild("HitEvent")

hitEvent.OnServerEvent:Connect(function(player)
	local character = player.Character
	if not character then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end

	-- Cari pemain lain di sekitar
	for _, otherPlayer in pairs(game.Players:GetPlayers()) do
		if otherPlayer ~= player and otherPlayer.Character then
			local otherChar = otherPlayer.Character
			local otherHum = otherChar:FindFirstChild("Humanoid")
			local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")

			if otherHum and otherRoot and otherHum.Health > 0 then
				local distance = (root.Position - otherRoot.Position).Magnitude

				-- Jarak gebuk
				if distance <= 7 then
					-- 1. Berikan Damage (Darah berkurang tapi belum jatuh)
					otherHum:TakeDamage(1000)

					-- 2. CEK APAKAH DARAH HABIS (FINISHER)
					if otherHum.Health <= 0 then
						print(otherPlayer.Name .. " kalah! Melepas pertahanan.")

						-- HAPUS WELD (Sistem Lem) agar bisa mental
						local weld = otherRoot:FindFirstChild("SeatWeld")
						if weld then
							weld:Destroy()
						end

						-- Lepas anchor musuh agar fisik aktif
						otherRoot.Anchored = false

						-- Berikan dorongan fisik yang kuat (Knockback)
						local pushDirection = (otherRoot.Position - root.Position).Unit

						-- SetNetworkOwner(nil) memastikan server yang menghitung fisika mentalnya
						otherRoot:SetNetworkOwner(nil)
						otherRoot:ApplyImpulse(pushDirection * 6500 + Vector3.new(0, 2000, 0))
					else
						-- Jika masih hidup, kita beri sedikit efek goyang (opsional)
						-- Tapi JANGAN di-unanchor agar tidak jatuh
						print(otherPlayer.Name .. " terkena hit! Darah sisa: " .. otherHum.Health)
					end
				end
			end
		end
	end
end)
