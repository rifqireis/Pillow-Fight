-- GREEN PENDAP INTRO Loading Screen 2026Â© --

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

ReplicatedFirst:RemoveDefaultLoadingScreen()

-- Setup GUI
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local introGui = ReplicatedFirst:WaitForChild("IntroGui"):Clone()
introGui.Parent = playerGui

local bg = introGui:WaitForChild("Background")
local studioLabel = bg:WaitForChild("StudioName")
local loadingLabel = bg:WaitForChild("LoadingText")
local gameLabel = bg:WaitForChild("GameName")
local VersionLabel = bg:WaitForChild("Version")

studioLabel.ImageTransparency = 1
gameLabel.Visible = false
VersionLabel.Visible = false
loadingLabel.Visible = false

local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fadeIn = TweenService:Create(studioLabel, tweenInfo, { ImageTransparency = 0 })
local fadeOut = TweenService:Create(studioLabel, tweenInfo, { ImageTransparency = 1 })

fadeIn:Play()
fadeIn.Completed:Wait()
task.wait(2)
fadeOut:Play()
fadeOut.Completed:Wait()

studioLabel.Visible = false
loadingLabel.Visible = true
gameLabel.Visible = true
VersionLabel.Visible = true

local assetsToLoad = workspace:GetDescendants()
local totalAssets = #assetsToLoad
local loadedCount = 0

local function updateLoadingText(contentId, status)
	loadedCount = loadedCount + 1
	local percent = math.floor((loadedCount / totalAssets) * 100)
	loadingLabel.Text = "Loading Assets: " .. percent .. "%"
end

-- PRELOAD ASSETS
ContentProvider:PreloadAsync(assetsToLoad, updateLoadingText)

loadingLabel.Text = "Done!"
task.wait(2)

local fadeInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local fade = TweenService:Create(bg, fadeInfo, { GroupTransparency = 1 })

fade:Play()
fade.Completed:Wait()

-- INI ADALAH SCRIPT TAMBAHAN

--local announcementGui = playerGui:WaitForChild("Announcement")
--announcementGui.Enabled = true

--local SoundService = game:GetService("SoundService")
--local music = SoundService:WaitForChild("MenuMusic")

-- 1. Mulai Lagu & Kamera
--music:Play()

introGui:Destroy()
