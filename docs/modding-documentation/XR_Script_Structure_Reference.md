# XR Script Structure Reference

## Introduction

The Silverback script engine was unified in XR.

The organization of the content changed significantly in XR. This reference describes the updated folder structure.

This structure is contained inside the archive file:

```text
savage0.s2z
```

The archive can be opened with WinZip, WinRAR, or any other ZIP utility.

---

## Tech Tree and Game Script

The folder below contains the complete script required to run the normal version of *Savage* / RTSS:

```text
/script/standard/
```

It contains the objects, states, and other script data used in SEP/SFE, TS-SEP, and XR maps.

### Contents of `/script/standard/`

| Path | Description |
|---|---|
| `/configs/` | Resources and race definitions; experience tables. |
| `/objects/` | Full tech tree, including buildings, weapons, items, units, and NPCs. |
| `/states/` | States conferred by items, buffs, and similar effects, such as adrenaline or snare. |
| `/stringtables/` | Miscellaneous lists of messages, sounds, and textures. |
| `/tupgrades/` | Optional team upgrades. |
| `/voice/` | Voice chat tables. |

### Object Lists

Different object lists, using the `.objlist` extension, can be loaded for the various existing map prefixes, such as:

```text
ts_
xr_
```

The file below contains the reference table that associates each map prefix with an object list:

```text
/game/server_maps_lookup.cfg
```

### Partial and Full Game Conversions

Partial and full game conversions can be added to the reference table.

For example, a conversion named `Duel` may use the following folder:

```text
/script/duel/
```

A conversion folder does not need to contain every file from:

```text
/script/standard/
```

If a file is not found in the conversion folder, the engine falls back to the corresponding file in:

```text
/script/standard/
```

---

## GUI Script

The folder below contains all GUI widgets required to run the normal version of *Savage* / RTSS:

```text
/gui/standard/
```

The Silverback engine calls these files to build the GUI:

| File | Purpose |
|---|---|
| `ui_main.cfg` | Builds the main menu widgets. |
| `ui_game.cfg` | Builds the in-game widgets. |

### GUI Script Loading for Conversions

When a game conversion is loaded, the engine tries to load these files from the subfolder specified by the `sv_map_objpath` value.

This value is defined through:

```text
server_maps_lookup.cfg
```

For example, if `sv_map_objpath` is set to:

```text
samurai/
```

Then the engine will try to load GUI files from:

```text
/gui/samurai/
```

If the requested file is not available in that folder, the standard file is loaded instead.

---

## Automatically Executed GUI Status Files

The same fallback principle applies to all GUI status files. These files are executed automatically in various interface states, such as entering the lobby.

| File | Purpose / Context |
|---|---|
| `ui_status_buddy_msg.cfg` | Buddy message status UI. |
| `ui_status_commander.cfg` | Commander status UI. |
| `ui_status_endgame.cfg` | Endgame status UI. |
| `ui_status_game_setup.cfg` | Game setup status UI. |
| `ui_status_ingame_menu.cfg` | In-game menu status UI. |
| `ui_status_lobby.cfg` | Lobby status UI. |
| `ui_status_main_menu.cfg` | Main menu status UI. |
| `ui_status_player.cfg` | Player status UI. |
| `ui_status_spawnpoint_select.cfg` | Spawnpoint selection status UI. |
| `ui_status_spectate.cfg` | Spectator status UI. |
| `ui_status_team_select.cfg` | Team selection status UI. |
| `ui_status_unit_select.cfg` | Unit selection status UI. |

---

## Full Conversion Example

For an example of a full conversion, inspect the following folders:

```text
/script/samurai/
/gui/samurai/
```
