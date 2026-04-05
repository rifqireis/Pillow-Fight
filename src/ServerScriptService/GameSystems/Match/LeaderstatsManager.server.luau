local Players = game:GetService("Players")

-- Fungsi yang jalan setiap kali ada player masuk
local function onPlayerAdded(player)
	-- 1. Buat Folder "leaderstats"
	-- HATI-HATI: Namanya harus persis "leaderstats" (huruf kecil semua)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player -- Masukkan folder ini ke dalam Player

	-- 2. Buat Stat Pertama: Kills (Tipe: Angka Bulat / IntValue)
	local kills = Instance.new("IntValue")
	kills.Name = "Kills" -- Ini nama yang muncul di papan skor
	kills.Value = 0 -- Nilai awal
	kills.Parent = leaderstats

	-- 3. Buat Stat Kedua: Cash (Tipe: Angka Bulat / IntValue)
	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = 100 -- Modal awal misal 100
	cash.Parent = leaderstats

	-- OPTIONAL: Data Persistence (Datastore) nanti ditambahkan di sini
	-- agar saat keluar game datanya tidak hilang.
end

-- Hubungkan fungsi ke Event PlayerAdded
Players.PlayerAdded:Connect(onPlayerAdded)
