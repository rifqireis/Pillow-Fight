-- DEBUGGING SCRIPT FOR R KEY ISSUE
-- Run this WHILE PLAYER IS FROZEN in FightZone

print("\n" .. string.rep("=", 70))
print("R KEY DEBUG SCRIPT - Run this while player is frozen")
print(string.rep("=", 70))

local players = game.Players:GetPlayers()

for _, player in players do
	if player.Character then
		print("\n[ACTIVE PLAYER FOUND]:", player.Name)
		print(string.rep("-", 70))

		-- Check 1: IsTeleported flag
		local isTeleported = player:GetAttribute("IsTeleported")
		print("1. IsTeleported flag:", isTeleported)
		if isTeleported == nil then
			print("   âš ï¸  FLAG IS NIL! This is the problem!")
		elseif isTeleported == true then
			print("   âœ“ Flag is TRUE (correct)")
		else
			print("   âœ— Flag is FALSE (should be TRUE)")
		end

		-- Check 2: WalkSpeed
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			print("\n2. WalkSpeed:", humanoid.WalkSpeed)
			if humanoid.WalkSpeed == 0 then
				print("   âœ“ Frozen (correct)")
			else
				print("   âœ— Not frozen")
			end
		end

		-- Check 3: Character humanoid state
		if humanoid then
			print("\n3. Humanoid State:", humanoid:GetState())
			print("   Health:", humanoid.Health)
		end

		-- Check 4: Test replication
		print("\n4. REPLICATION TEST:")
		print("   Setting IsTeleported to TRUE...")
		player:SetAttribute("IsTeleported", true)
		wait(0.1)
		local check = player:GetAttribute("IsTeleported")
		print("   Verified:", check)

		-- Check 5: RemoteFunction
		print("\n5. REMOTE FUNCTION:")
		local rf = game.ReplicatedStorage:FindFirstChild("ReturnTeleportFunc")
		if rf then
			print("   âœ“ RemoteFunction exists")
			print("   Type:", rf.ClassName)
		else
			print("   âœ— RemoteFunction NOT FOUND")
		end

		-- Check 6: Check for errors in console
		print("\n6. TROUBLESHOOTING STEPS:")
		print("   a) Check Output console for error messages")
		print("   b) Look for: 'R pressed - IsTeleported: ' message")
		print("   c) If message appears, R key IS being detected")
		print("   d) If no success message, server callback might fail")

		print("\n" .. string.rep("-", 70))
	end
end

if #players == 0 or not players[1].Character then
	print("âš ï¸  No active player with character found!")
end

print("\n" .. string.rep("=", 70))
print("Debug complete. Check above output for issues.")
print("==" .. string.rep("=", 68))
