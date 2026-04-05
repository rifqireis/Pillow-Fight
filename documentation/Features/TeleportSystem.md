# Teleport System - Feature Documentation

## 🎯 Overview

System yang menangani teleportasi pemain dari teleporter zones (tpMatch) ke safe position di atas bamboo obstacles (bambuArena).

**Purpose:** Prevent player dari terjebak/tersangkut di bamboo, instant respawn ke safe location.

---

## 🎮 Gameplay Flow

```
1. Player gets knocked into bamboo (tpMatch area)
2. TeleportController detects touch event
3. System checks if safe position available
4. Player instantly teleported above bamboo
5. Player returns to spawn/continues game
```

---

## ⚙️ Technical Implementation

### Components

| Component | Type | Location | Status |
|-----------|------|----------|--------|
| TeleportUtil | ModuleScript | ReplicatedStorage/Modules | 🔄 WIP |
| TeleportController | Script | ServerScriptService | 🔄 WIP |
| bambuArena | Folder | Workspace | ✅ Done |
| tpMatch | Folder | Workspace | ✅ Existing |

### Configuration

```luau
-- TeleportUtil Config
TELEPORT_INSTANT = true           -- Instant teleport (no animation)
SAFE_OFFSET = Vector3.new(0, 5, 0) -- 5 studs above bamboo
SAFE_RADIUS = 10                   -- Check radius for safe position
TELEPORT_COOLDOWN = 0              -- No cooldown (for now)
```

---

## 🔧 Requirements (Pre-Implementation)

Before coding TeleportUtil & TeleportController, confirm:

1. **SpawnLocation Reference**
   - Mana spawn location pemain?
   - Satu spawn atau multiple?

2. **Touch Detection**
   - Teleporter parts (TeleR1, TeleB1) yang detect?
   - Atau bambu itself?

3. **Safe Check Method**
   - Simple check (position kosong)?
   - Ray cast (cek obstacle)?
   - Region3 check?

---

## 📋 Implementation Checklist

- [ ] Create TeleportUtil ModuleScript
  - [ ] CONFIG constants
  - [ ] canTeleport() function
  - [ ] teleportTo() function
  - [ ] getSafePosition() function
  
- [ ] Create TeleportController Script
  - [ ] Listen to touch events
  - [ ] Call TeleportUtil:canTeleport()
  - [ ] Execute teleport logic
  
- [ ] Testing
  - [ ] Touch teleporter → teleported
  - [ ] Check safe position working
  - [ ] Verify no errors in Output

---

## 🎨 Polish/Future Features

- [ ] Teleport VFX (particles, sound)
- [ ] Teleport animation (fade in/out)
- [ ] Cooldown notification
- [ ] Respawn auto-timer (if needed)

---

## 📝 Change Log

### Mar 30, 2026
- 📝 Planning: Teleport system design
- 📋 Today: Start implementation (TeleportUtil)

---

**Status:** In Planning Phase  
**Last Updated:** Mar 30, 2026
