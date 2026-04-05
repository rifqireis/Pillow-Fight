-- Coded By @Ohad2021 / Ohad

local function WaitFor(instanceName, instanceParent, inDescendants)
	local instance = instanceParent:FindFirstChild(instanceName, inDescendants)

	local attempts = 0

	while attempts < 100 and not instance do
		instance = instanceParent:FindFirstChild(instanceName, inDescendants)
		task.wait()
		attempts += 1

		if attempts >= 100 or instance then
			break
		end
	end

	if attempts >= 100 then
		warn("After 100 attempts " .. instanceName .. " wasnt found!")
	end

	return instance
end

local Config = WaitFor("Config", script.Parent)

local DataStore = game:GetService("DataStoreService"):GetOrderedDataStore(WaitFor("DataStoreName", Config).Value)

local Board = WaitFor("Board", script.Parent)

local DelayTime = WaitFor("ReloadDelay", Config).Value
local Enabled = WaitFor("Enabled", Config)

local MaxPlayers = WaitFor("MaxPlayers", Config)

local function SaveDatas()
	for num, player in pairs(game:GetService("Players"):GetPlayers()) do
		local stat = WaitFor(WaitFor("StatName", Config).Value, player, true)

		if stat then
			local success, err = pcall(function()
				DataStore:SetAsync(player.UserId, stat.Value)
			end)

			if not success then
				warn("Inside the leaderboard script: " .. err)
			end
		end
	end
end

local function LoadStats()
	local Datas = DataStore:GetSortedAsync(false, MaxPlayers.Value)
	game:GetService("DataStoreService"):GetDataStore("d")

	local CurrentPage = Datas:GetCurrentPage()

	for rank, value in pairs(CurrentPage) do
		local success, err = pcall(function()
			local template = WaitFor("ScrollingFrame", WaitFor("SurfaceGui", Board)):FindFirstChild(rank)
				or WaitFor("Template", WaitFor("ScrollingFrame", WaitFor("SurfaceGui", Board))):Clone()

			template.Parent = WaitFor("ScrollingFrame", WaitFor("SurfaceGui", Board))

			template.Visible = true

			WaitFor("Value", template).Text = value.value

			WaitFor("Rank", template).Text = "#" .. rank

			WaitFor("Username", template).Text = "@"
				.. game:GetService("Players"):GetNameFromUserIdAsync(tonumber(value.key))

			template.LayoutOrder = tonumber(rank)

			template.Name = rank
		end)

		if not success then
			warn(err)
		end
	end
end

print("Leaderboard Loaded")

while wait(DelayTime) and task.wait() do -- waiting th delay time and task.wait() because incase the delay time was accidentally set to 0 then the game would break
	local success, err = pcall(function()
		while Enabled.Value == false do -- making an inf loop incase you set the enabled to false in another script
			task.wait(1)
		end

		SaveDatas()

		LoadStats()
	end)

	if not success then
		warn(err)
	end
end
