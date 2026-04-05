# PillowFight

A Roblox pillow fight game managed with [Rojo](https://rojo.space/) for source control.

## Prerequisites

- [Aftman](https://github.com/LPGhatguy/aftman) — toolchain manager
- [Roblox Studio](https://create.roblox.com/) with the [Rojo plugin](https://rojo.space/docs/v7/getting-started/installation/#installing-the-plugin)

## Getting Started

```bash
# 1. Install toolchain (Rojo, Wally, StyLua, Selene)
aftman install

# 2. Install Wally packages (if any)
wally install

# 3. Build the place file
rojo build -o "Pillow-Fight.rbxlx"

# 4. Open Pillow-Fight.rbxlx in Studio, then start the sync server
rojo serve
```

Connect the Rojo plugin in Studio to start syncing files.

## Project Structure

```
src/
├── ReplicatedFirst/          Loading screen
├── ReplicatedStorage/        Shared modules, config, remote events
│   ├── GameConfig.luau       Run/sprint speed configuration
│   ├── Shared/               Core shared modules + DamageEvent
│   ├── Systems/Teleport/     Teleport utility module
│   └── Events/               RemoteEvents & RemoteFunctions
├── ServerScriptService/      Server-side game logic
│   └── GameSystems/
│       ├── Combat/           Damage, hit detection, health bars
│       ├── Core/             MCP connection, diagnostics
│       ├── Match/            Game loop, leaderstats
│       └── Teleport/         Teleport pad controller
├── ServerStorage/            Templates & references
├── StarterPlayer/
│   ├── StarterPlayerScripts/ Input handling, health bar UI
│   └── StarterCharacterScripts/ Movement, return-to-spawn, animations
├── StarterPack/              Pillow tool
└── Workspace/                Leaderboard
```

## Tools

| Tool | Purpose |
|------|---------|
| [Rojo](https://rojo.space/) | Filesystem ↔ Studio sync |
| [Wally](https://wally.run/) | Package manager |
| [StyLua](https://github.com/JohnnyMorganz/StyLua) | Code formatter |
| [Selene](https://kampfkarren.github.io/selene/) | Linter |

## Development

```bash
# Format code
stylua src/

# Lint code
selene src/

# Build place file
rojo build -o "Pillow-Fight.rbxlx"
```

## Manual Exports from Studio

Some visual assets (GUIs, MeshParts, animations, scoreboard) need to be
exported manually from Studio as `.rbxm` files. Right-click the instance in
Studio Explorer → **Save to File** → save to the corresponding `src/` path:

| Instance | Target Path |
|----------|-------------|
| `ReplicatedFirst.IntroGui` | `src/ReplicatedFirst/IntroGui.rbxm` |
| `ServerStorage.CombatHealthGui` | `src/ServerStorage/CombatHealthGui.rbxm` |
| `ServerStorage.ScreenGui` | `src/ServerStorage/ScreenGui.rbxm` |
| `ServerStorage.RBX_ANIMSAVES` | `src/ServerStorage/RBX_ANIMSAVES.rbxm` |
| `StarterPack.Pillow.Handle` | `src/StarterPack/Pillow/Handle.rbxm` |
| `Workspace.FootballScoreboard` | `src/Workspace/FootballScoreboard.rbxm` |

After exporting, add the `$path` references to `default.project.json`.