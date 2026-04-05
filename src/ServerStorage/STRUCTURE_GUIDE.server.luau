-- ðŸ“‹ PILLOW FIGHT - FOLDER STRUCTURE GUIDE
-- Last Updated: March 30, 2026

-- ============================================================
-- FOLDER ORGANIZATION REFERENCE
-- ============================================================

-- ðŸ“¦ ServerScriptService/GameSystems/
-- Contains all server-side game logic organized by feature

-- Combat/ - Damage, health, combat mechanics
--   â””â”€â”€ HealthBarManager (tracks player health)
--   â””â”€â”€ DamageSystem (handles player damage)
--   â””â”€â”€ DamageHandler (auxilliary damage logic)

-- Teleport/ - Teleportation system
--   â””â”€â”€ TeleportController (server handler for teleport detection & return)

-- Match/ - Match/game state management
--   â””â”€â”€ MatchSystem (game state & match logic)
--   â””â”€â”€ LeaderstatsManager (player stats tracking)

-- Core/ - Essential server utilities
--   â””â”€â”€ Server (main server initialization)
--   â””â”€â”€ MCPConnected (MCP connection handler)
--   â””â”€â”€ DebugRKeyIssue (debug utility script)

-- ============================================================
-- ðŸ“¦ ReplicatedStorage/
-- Client & Server shared resources

-- Systems/Teleport/ - Teleport utilities & functions
--   â””â”€â”€ TeleportUtil (module with teleport functions)

-- Events/ - RemoteEvents & RemoteFunctions
--   â””â”€â”€ ShowHealthBarEvent (remote event)
--   â””â”€â”€ HitEvent (remote event)
--   â””â”€â”€ ReturnTeleportFunc (remote function for R key return)

-- ============================================================
-- ðŸ“¦ StarterPlayer/StarterPlayerScripts/
-- Client scripts that run when player loads

-- Core/ - Foundation client scripts
--   â””â”€â”€ Client (main client init)

-- Input/ - Input handling
--   â””â”€â”€ InputHandler (input detectors)

-- UI/ - User interface
--   â””â”€â”€ HealthBarClient (health bar UI)

-- ============================================================
-- ðŸ“¦ StarterPlayer/StarterCharacterScripts/
-- Client scripts that run when character spawns

-- Combat/ - Combat behaviors
--   â””â”€â”€ TestAnimasi (animation tests)

-- Movement/ - Character movement
--   â””â”€â”€ ShiftToRun (shift key to run)
--   â””â”€â”€ SpeedBoost (speed boost mechanic)

-- Teleport/ - Teleport-related client behavior
--   â””â”€â”€ ReturnToSpawn (R key return to safe zone)

-- ============================================================
-- ðŸ“ HOW TO ADD NEW SCRIPTS:
--
-- 1. Determine script category (Combat, Teleport, Match, etc)
-- 2. Use existing folder structure or create new category
-- 3. Follow naming convention: DescriptiveScriptName.luau
-- 4. Add documentation at top of script
-- 5. Update this guide if creating new category
-- ============================================================
