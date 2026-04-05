# Bamboo Arena - Workspace Documentation

## 📍 Repository

**Location:** `game.Workspace.bambuArena`  
**Type:** Folder  
**Purpose:** Container untuk semua bamboo obstacles di match arena

---

## 🏷️ Naming Convention

**Pattern:** Grid-based naming (B{row}C{column})

```
Grid Layout (2 Rows × 3 Columns):
┌────────┬────────┬────────┐
│ B1C1   │ B1C2   │ B1C3   │ ← Row 1 (Top)
├────────┼────────┼────────┤
│ B2C1   │ B2C2   │ B2C3   │ ← Row 2 (Bottom)
└────────┴────────┴────────┘
 Col 1    Col 2    Col 3
```

### **Naming Reference**
| Name | Position | Notes |
|------|----------|-------|
| B1C1 | Row 1, Column 1 (Top-Left) | - |
| B1C2 | Row 1, Column 2 (Top-Center) | - |
| B1C3 | Row 1, Column 3 (Top-Right) | - |
| B2C1 | Row 2, Column 1 (Bottom-Left) | - |
| B2C2 | Row 2, Column 2 (Bottom-Center) | - |
| B2C3 | Row 2, Column 3 (Bottom-Right) | - |

---

## 🔧 Structure (Per Bamboo Model)

Each bamboo model (B1C1, B1C2, etc.) contains:
```
B1C1 (Model)
├── Model (visual parts - bamboo segment)
│   ├── Model (inner segments)
│   │   ├── Part (bamboo stick)
│   │   └── Part (joint detail)
│   └── ParticleEmitter (leaves/effect)
└── ...
```

**Purpose:** Obstacle/collision object for pillow fight gameplay

---

## 📌 Usage in Teleport System

When player is knocked onto bamboo → **Teleport to position above bamboo**

```luau
local bamboo = workspace.bambuArena:FindFirstChild("B1C1")
local safePosition = bamboo.Position + Vector3.new(0, SAFE_OFFSET, 0)
humanoid:MoveTo(safePosition) -- atau instant teleport dengan CFrame
```

---

## 🔄 Related Objects

- **tpMatch folder** - Teleporter parts (TeleR1, TeleB1, etc) yang trigger teleport
- **SpawnLocation** - Respawn point setelah teleported

---

## 📝 Change Log

### Mar 30, 2026
- ✅ Created: 6 bamboo models renamed dari "Model" generic
- ✅ Pattern: B1C1, B1C2, B1C3, B2C1, B2C2, B2C3
- ✅ Reason: Clear naming convention untuk referencing dalam code

---

**Last Updated:** Mar 30, 2026  
**Author:** Development Team
