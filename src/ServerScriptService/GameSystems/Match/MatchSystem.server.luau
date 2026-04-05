local Players = game:GetService("Players")
local Scoreboard = workspace:WaitForChild("FootballScoreboard")

local MIN_PLAYERS = 2
local MAX_ROUNDS = 3

local awayWins = 0
local homeWins = 0
local currentRound = 1

-- Referensi lokasi bambu
local slot1 = workspace:WaitForChild("DTPB1")
local slot2 = workspace:WaitForChild("DTPR1")

-- FUNGSI UPDATE SKOR 3D (Aman & Stabil)
local function update3DDisplay(sectionFolder, scoreValue)
	if not sectionFolder then
		return
	end
	local onesValue = scoreValue % 10
	local tensValue = math.floor(scoreValue / 10)

	local function setDigit(folder, target)
		if not folder then
			return
		end
		for _, model in pairs(folder:GetChildren()) do
			local isTarget = (model.Name == tostring(target))
			for _, part in pairs(model:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Transparency = isTarget and 0 or 1
				end
			end
		end
	end

	setDigit(sectionFolder:FindFirstChild("Ones"), onesValue)
	setDigit(sectionFolder:FindFirstChild("Tens"), tensValue)
end

-- FUNGSI RESET POSISI (Mencegah Bug Ronde)
local function resetRoundPos(playerList)
	for i, p in pairs(playerList) do
		if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local root = p.Character.HumanoidRootPart
			local hum = p.Character.Humanoid
			local dest = (i == 1) and slot1 or slot2

			hum.Health = 100
			hum.Sit = true

			local yOffset = (dest.Size.Y / 2) + 1.6
			local rotation = (i == 1) and 0 or math.rad(180)

			root.CFrame = dest.CFrame * CFrame.new(0, yOffset, 0) * CFrame.Angles(0, rotation, 0)
			root.Anchored = true

			-- Pasang ulang lem (Weld)
			if root:FindFirstChild("SeatWeld") then
				root.SeatWeld:Destroy()
			end
			local weld = Instance.new("WeldConstraint")
			weld.Name = "SeatWeld"
			weld.Part0 = root
			weld.Part1 = dest
			weld.Parent = root
		end
	end
end

-- LOOP UTAMA GAME (Anti-Freeze)
while true do
	task.wait(2) -- Memberi jeda server bernapas

	local waitingPlayers = {}
	for _, p in pairs(Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			if p.Character.HumanoidRootPart.Anchored then
				table.insert(waitingPlayers, p)
			end
		end
	end

	if #waitingPlayers >= MIN_PLAYERS then
		awayWins = 0
		homeWins = 0
		currentRound = 1

		while currentRound <= MAX_ROUNDS do
			-- Update Skor & Ronde
			update3DDisplay(Scoreboard.Away, awayWins)
			update3DDisplay(Scoreboard.Home, homeWins)

			-- Update Quarter Visual
			local qFolder = Scoreboard:FindFirstChild("Quarter")
			if qFolder then
				for _, m in pairs(qFolder:GetChildren()) do
					for _, p in pairs(m:GetDescendants()) do
						if p:IsA("BasePart") then
							p.Transparency = (m.Name == tostring(currentRound)) and 0 or 1
						end
					end
				end
			end

			task.wait(3) -- Jeda persiapan ronde

			-- MULAI BERTARUNG
			for _, p in pairs(waitingPlayers) do
				if p.Character then
					p.Character.HumanoidRootPart.Anchored = false
				end
			end

			-- DETEKSI PEMENANG (Loop ini sudah diberi task.wait)
			local roundWinner = nil
			while true do
				task.wait(0.2) -- SANGAT PENTING: Mencegah infinite loop crash

				local alive = {}
				for _, p in pairs(waitingPlayers) do
					if p.Character and p.Character:FindFirstChild("Humanoid") then
						local hrp = p.Character:FindFirstChild("HumanoidRootPart")
						if hrp and p.Character.Humanoid.Health > 0 and hrp.Position.Y > 2 then
							table.insert(alive, p)
						end
					end
				end

				-- Jika pemain keluar game saat ronde jalan
				if #waitingPlayers < MIN_PLAYERS then
					break
				end

				if #alive <= 1 then
					roundWinner = alive[1]
					break
				end
			end

			-- Skor
			if roundWinner == waitingPlayers[1] then
				awayWins = awayWins + 1
			elseif roundWinner == waitingPlayers[2] then
				homeWins = homeWins + 1
			end

			currentRound = currentRound + 1
			task.wait(2)

			-- RESET RONDE BERIKUTNYA
			if currentRound <= MAX_ROUNDS then
				resetRoundPos(waitingPlayers)
			end
		end

		print("PERTANDINGAN SELESAI")
		task.wait(5)
		for _, p in pairs(Players:GetPlayers()) do
			p:LoadCharacter() -- Gunakan teks bersih tanpa spasi aneh
		end
	end
end
