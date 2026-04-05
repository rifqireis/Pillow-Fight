local TeleportUtil = {}

TeleportUtil.CONFIG = {
	TELEPORT_INSTANT = true,
	SAFE_OFFSET = Vector3.new(0, 5, 0),
	SAFE_RADIUS = 10,
	TELEPORT_COOLDOWN = 0,
}

function TeleportUtil.getSpawnByNumber(spawnNumber)
	local fightZone = game.Workspace:FindFirstChild("FightZone")
	if not fightZone then
		print("ERROR: FightZone not found!")
		return nil
	end

	local spawnName = "Sp" .. tostring(spawnNumber)
	local spawn = fightZone:FindFirstChild(spawnName)

	if not spawn then
		print("ERROR: Spawn not found:", spawnName)
	end

	return spawn
end

function TeleportUtil.teleportToSpawn(player, teleporterName)
	if not player or not player.Character then
		print("Invalid player or character")
		return false
	end

	-- Extract number from teleporter name (TB3 -> 3)
	local spawnNumber = tonumber(teleporterName:match("%d+"))
	if not spawnNumber then
		print("Could not extract spawn number from:", teleporterName)
		return false
	end

	local spawn = TeleportUtil.getSpawnByNumber(spawnNumber)
	if not spawn then
		print("Spawn not found for number:", spawnNumber)
		return false
	end

	local character = player.Character
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid or humanoid.Health <= 0 then
		print("Player is dead or no humanoid")
		return false
	end

	-- Teleport instantly
	if TeleportUtil.CONFIG.TELEPORT_INSTANT then
		local offset = spawn.Position + TeleportUtil.CONFIG.SAFE_OFFSET
		character:MoveTo(offset)
		print(player.Name, "teleported to", spawn.Name, "via", teleporterName)
		return true
	end

	return false
end

function TeleportUtil.teleportAboveBamboo(player, bambooName)
	if not player or not player.Character then
		return false
	end

	local bamboo = game.Workspace.bambuArena:FindFirstChild(bambooName)
	if not bamboo then
		return false
	end

	local safePos = bamboo.Position + TeleportUtil.CONFIG.SAFE_OFFSET
	player.Character:MoveTo(safePos)
	return true
end

function TeleportUtil.getSafePosition(part)
	if not part then
		return nil
	end
	return part.Position + TeleportUtil.CONFIG.SAFE_OFFSET
end

return TeleportUtil
