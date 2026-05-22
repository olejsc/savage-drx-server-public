# XR Script Triggers

## Introduction

Server-side Game Scripts (GS) handle the functionality of objects and clients in-game. They are saved with the file extension `.gs` in the subfolder:

```text
standard\objects\scripts
```

GS files are also saved in map files when triggers are used.

## Script Format

Blank lines are ignored. Any other line must start with one of these special characters:

| Prefix | Meaning |
|---|---|
| `#` | Comment |
| `@` | Entry point |
| `!` | Instruction |

When the script is parsed, instructions are appended to one of several linked lists. The most recent entry-point directive determines which list the current instruction is added to. When something in-game triggers an entry point of an object, the game steps through the instructions in that list and executes them.

### Comment Syntax

```gs
#[comment text] ...
```

Comments are ignored, just like blank lines.

### Entry Point Syntax

```gs
@<entry point name> [frequency]
@<entry point name> [min_frequency max_frequency]
```

See [GS Entry Points](#gs-entry-points) for valid entry points.

Not all entry points require a frequency. Frequency is ignored when unnecessary.

### Instruction Syntax

```gs
!<instruction name> <object> [param] ...
```

See [GS Instruction Dictionary](#gs-instruction-dictionary) and [GS Object Names](#gs-object-names) for valid commands and parameters.

Valid parameter types include:

| Type | Example |
|---|---|
| Text | `!setstate self idle` |
| Integer | `!damageradius target 150 500` |
| Cvar | `!push found #kickX# #kickY# #kickZ#` |
| Statement | `!if [mycvar>1] @then0` |

## GS Entry Points

> **Important:** Map trigger scripts can only use the `@activate` entry point.

### Object State Entry Points

These apply only to items.

| Entry point | Description |
|---|---|
| `@activate` | Object has been activated. Also used when a map trigger was activated. |
| `@active` | Object is in activated mode. Executed for each frame. |
| `@idle` | Object has been ordered to idle. |
| `@idling` | Object is in idle mode. Executed for each frame. |
| `@sleep` | Object has been ordered to sleep. |
| `@sleeping` | Object is in sleep mode. Executed for each frame. |

### Object Management Entry Points

These apply only to items.

| Entry point | Description |
|---|---|
| `@pickup` | Object was picked up on terrain. |
| `@given` | Object was added to inventory by the `!give` command. |
| `@drop` | Object was removed from inventory by the `!drop` command. |
| `@toss` | Object was removed from inventory by the `!toss` command. |
| `@attach` | Object was attached to a parent by the `!attach` command. |
| `@spawn` | Owner of object has spawned or was resurrected. |

### Usage, Weapons, and Damage Entry Points

| Entry point | Description |
|---|---|
| `@use` | Parent player used item, or powerup was applied to player. |
| `@fuse` | Object fusetime period has expired. Requires `fusetime > 0`. |
| `@backfire` | Object back-fired. Uses `startFuseAtCharge 1`. |
| `@fizzle` | Tech weapon fizzled because parent has state `lockdownTech 1`. |
| `@impact` | Weapon or projectile has hit something. |
| `@wounded` | Object took damage. |
| `@die` | Object took fatal damage. |
| `@fire` | Not working yet. |
| `@block` | Object has blocked. Client-only. |
| `@blocking` | Object is blocking. Client-only. |
| `@levelup` | Object advanced a level. Client-only. |

### AI Object Management Entry Points

| Entry point | Description |
|---|---|
| `@walking` | Object is walking towards a fixed point. |
| `@chasing` | Object is following another object. |

### GameScript Logic Entry Points

| Entry point | Description |
|---|---|
| `@then0` through `@then9` | Executed by the `!if` and `!ifnot` commands. |

## GS Object Names

| Object name | Description |
|---|---|
| `self` | Object that is acting. |
| `target` | Object that initiated the action. |
| `enemy` | Object's current enemy. |
| `owner` | Object's owner, if any. |
| `link` | Object's link, if any. |
| `found` | Object found by last `!search`. |
| `null` | No target. Used for entries such as `!exec`. |

## GS Instruction Dictionary

### Parameter Notation

| Notation | Meaning |
|---|---|
| `<parameter>` | Required parameter. |
| `[parameter]` | Optional parameter. |
| `(parameter)` | Required only if another parameter has been specified. |
| `<target>` | Can take any value described in [GS Object Names](#gs-object-names). |

## Healing and Damage

### `!heal`

```gs
!heal <object> <amount>
```

Heals an object by the specified amount.

- If `amount < 1.0`, the value represents a percentage of full health.
- If `amount >= 1.0`, the value represents a fixed amount of health.

### `!damage`

```gs
!damage <object> <amount> [ignoreArmor]
```

Damages an object by the specified amount.

- If `amount < 1.0`, the value represents a percentage of full health.
- If `amount >= 1.0`, the value represents a fixed amount of health.
- If `ignoreArmor = 1`, the damage is not shielded by armor.

### `!damageradius`

```gs
!damageradius <object> <radius> <amount> [targetFlag1] [targetFlag2] ...
```

Damages objects within a radius around the given object.

- If no flags are supplied, everything in radius around the object is damaged, including the object itself.
- If flags are supplied, everything matching the flags in radius around the object is damaged, excluding the object itself.
- Damage is inversely proportional to the distance between the object and the victim.

Valid flags:

```text
enemy neutral ally unit player npc item building
```

### `!die`

```gs
!die <object>
```

Kills the object.

### `!revive`

```gs
!revive <object> <healthPercent>
```

Resurrects the object with the specified health percentage, from `0` to `1`.

## Slots, Ammo, Stamina, Gold, Experience, and States

### `!inventory`

```gs
!inventory <object> [slot]
```

Checks the content of the player's specified inventory slot.

- If `slot` is not specified, the currently selected slot is used instead.
- Information is returned in the cvars `gs_inventory_name` and `gs_inventory_count`.
- The script will error out if `<object>` is not a player unit.
- Slots are indexed from `0`, so in-game slot 1 is slot `0` in script.

Example:

```gs
!inventory owner 3
!exec null "chat Item in slot 3: #gs_inventory_name#"
```

### `!give`

```gs
!give <object> <objectType> [ammo] [slot]
```

Gives the specified object to a player, for example `human_potion`.

- If `ammo` is not specified, the value is `1`.
- If `slot` is not specified, the object is assigned to the currently selected slot.
- Also causes the immediate execution of the `@given` entry for that object.
- Slots are indexed from `0`, so in-game slot 1 is slot `0` in script.

### `!remove`

```gs
!remove <object> [slot]
```

Removes the item in the specified inventory slot of the target player.

- If `slot` is not specified, the currently selected slot is used instead.
- Slots are indexed from `0`, so in-game slot 1 is slot `0` in script.
- Does not trigger any entry points.

### `!giveammo`

```gs
!giveammo <object> <multiplier> <amount|group|start|full>
```

Gives ammo for the player's ranged weapons. The total amount is calculated depending on the last parameter.

| Parameter | Result |
|---|---|
| `<amount>` | `Total = current + (multiplier * amount)` |
| `<group>` | `Total = current + (multiplier * ammoGroup)` |
| `<start>` | `Total = multiplier * ammoStart` |
| `<full>` | `Total = multiplier * ammoMax` |

`group`, `start`, and `full` are written literally. `amount` is a specific number instead.

### `!givemana`

```gs
!givemana <object> <amount>
```

Gives the object the specified amount of mana. `amount` always represents a fixed amount.

### `!givestamina`

```gs
!givestamina <object> <amount>
```

Gives the object the specified amount of stamina. `amount` always represents a fixed amount.

### `!givegold`

```gs
!givegold <object> <amount>
```

Gives the object the specified amount of gold. `amount` always represents a fixed amount.

### `!givegoldradius`

```gs
!givegoldradius <object> <radius> <amount> <ally/enemy>
```

Grants gold to allies or enemies in radius around the object, excluding the object itself, and only to clients.

- `amount` always represents a fixed amount.
- `ally/enemy` is relative to the given `<object>`.

### `!giveexp`

```gs
!giveexp <object> <amount>
```

Gives the object the specified amount of experience. `amount` always represents a fixed amount.

> **Warning:** The server setting `sv_xp_max_gain` directly affects how high the value of experience gain can be, limiting it to the set percentage of the next level.

### `!giveexpradius`

```gs
!giveexpradius <object> <radius> <amount> <ally/enemy>
```

Grants experience to allies or enemies in radius around the object, excluding the object itself, and only to clients.

- `amount` always represents a fixed amount.
- `ally/enemy` is relative to the given `<object>`.

> **Warning:** The server setting `sv_xp_max_gain` directly affects how high the value of experience gain can be.

### `!regenradius`

```gs
!regenradius <object> <radius> <healamount> <staminaamount> <ammoamount> <targetFlag1> [targetFlag2] ...
```

Scans a radius around the object looking for anything that matches the specified flags. The first object detected gets regenerated by the specified amounts.

- If `amount < 1.0`, the value represents a percentage of maximum stat value.
- If `amount >= 1.0`, the value represents a fixed amount of the stat value.
- Flags `1st` through `4th` correspond to distance from the specified object.

Valid flags:

```text
enemy neutral ally unit player npc item building 1st 2nd 3rd 4th
```

### `!givestate`

```gs
!givestate <object> <stateName> <minDuration> [maxDuration]
```

Gives the specified state to an object, for example `adrenaline`.

- If `maxDuration` in milliseconds is not specified, duration is equal to `minDuration`.
- Otherwise, duration is a random value in the range `minDuration:maxDuration`.

### `!givestateradius`

```gs
!givestateradius <object> <radius> <stateName> <minDuration> [maxDuration]
```

Gives the specified state to all valid targets around `<object>`, for example `adrenaline`.

- If `maxDuration` in milliseconds is not specified, duration is equal to `minDuration`.
- Otherwise, duration is a random value in the range `minDuration:maxDuration`.
- `<object>` does not receive the state.
- A valid target refers to the target flags specified within the `.state` file of that state.

### `!hasstate`

```gs
!hasstate <object> <stateName>
```

Checks whether the object has the specified state. If the object does not have the state, execution of the script breaks at this point.

### `!stateslot`

```gs
!stateslot <object> <slot>
```

Checks the content of the player's specified state slot. Information is returned in the cvar `gs_state_name`.

Example:

```gs
!stateslot owner 15
!exec null "chat State in slot 15: #gs_state_name#"
```

For a list of state attributes, see the XR State Reference.

## Player Behaviour

### `!goal`

```gs
!goal <object> <player|team|all|#num|$name> <move|object> <x> <y>
```

Assigns a target group a certain goal, such as move or attack.

Target group parameters:

| Parameter | Meaning |
|---|---|
| `player` | Only the object is assigned the goal. |
| `team` | The object's team is assigned the goal. |
| `team0` through `team4` | The specified team is assigned the goal. |
| `all` | Everyone in every team is assigned the goal. |
| `#num` | Only object `#num` is assigned the goal. `num` can be `0` to `1024`. |
| `##cvar#` | Same as `#num`, but with the object number retrieved from a cvar. |
| `$name` | Only the client with a matching name is assigned the goal. |

Goal type parameters:

| Parameter | Meaning |
|---|---|
| `move` | Move to location `<x> <y>`. |
| `object` | Act on the nearest object to location `<x> <y>`. That object's type and team determine the goal, such as attack or build. |

### `!push`

```gs
!push <object> <vectX> <vectY> <vectZ>
```

Pushes the object along the specified direction vector. The strength is the length of the vector. This force is added on top of the object's current velocity.

### `!pull`

```gs
!pull <object> <speedMult>
```

Pulls the given object towards the acting object, `self`. This force is added on top of the object's current velocity.

### `!physics`

```gs
!physics <object> <gravity|friction|aircontrol|maxvel> <newValue>
```

Alters the physics of an object.

### `!teleport`

```gs
!teleport <object> <home|here|link|coords> (<x> <y>)
```

Teleports the object to a new location defined by the second parameter.

| Parameter | Meaning |
|---|---|
| `home` | Teleport object to the team's command centre. |
| `here` | Teleport object to the location of the acting object, also known as `self`. |
| `link` | If the object has a linked object in inventory, teleport to that location. |
| `coords` | Teleport object to location `<x> <y>`. |

### `!stun`

```gs
!stun <object> <duration>
```

Stuns the object for a set period of time. `duration` represents stun time in milliseconds.

### `!stunradius`

```gs
!stunradius <object> <radius> <duration> <targetFlag1> |targetFlag2| |targetFlag3|
```

Stuns units in radius around the object corresponding to the given target flags, excluding the object itself. `duration` represents stun time in milliseconds.

Valid flags:

```text
enemy neutral ally
```

## Item Behaviour

### `!drop`

```gs
!drop <object> <angle> <radius>
```

Drops an object from inventory to a precise location on the ground.

- `angle` and `radius` are relative to the player's current position and angle.
- The object remains linked to the player who dropped it, for example for use with `!teleport`.
- Also causes the immediate execution of the `@drop` entry.

### `!toss`

```gs
!toss <object> <velocity> <gravity>
```

Tosses an object from inventory to the ground.

- The object remains linked to the player who tossed it, for example for use with `!teleport`.
- Also causes the immediate execution of the `@toss` entry.

### `!attach`

```gs
!attach <object>
```

Allocates a model and attaches it to the specified object, for example `sacrifice`. Also causes the immediate execution of the `@attach` entry.

### `!destabilize`

```gs
!destabilize <object> <radius> <targetFlag1> [targetFlag2] ...
```

Kills all volatile objects matching the flags within the specified radius of the object. Volatile objects have the field `isvolatile=1` in their `.object` definition.

Valid flags:

```text
enemy neutral ally unit item building
```

### `!scan`

```gs
!scan <object> <radius> <triggerState> <targetFlag1> [targetFlag2] ...
```

Scans the radius around an object looking for anything that matches the specified flags. When an object is detected, `<object>` switches to the state `<triggerState>`.

Flags `1st` through `4th` correspond to distance from the specified object.

Valid flags:

```text
enemy neutral ally unit player npc item building 1st 2nd 3rd 4th
```

Valid states:

```text
sleep idle activate
```

### `!search`

```gs
!search <object> <radius> <targetFlag1> [targetFlag2] ...
```

Scans the radius around an object looking for anything that matches the specified flags. When an object is detected, the GS target `found` is updated to point to it.

Flags `1st` through `4th` correspond to distance from the specified object.

Valid flags:

```text
enemy neutral ally unit player npc item building 1st 2nd 3rd 4th
```

Example:

```gs
!search self 70 unit ally neutral enemy 1st
!exec found "set kickX [300*gs_object_dirx]"
!exec found "set kickY [300*gs_object_diry]"
!exec found "set kickZ [100]"
!push found #kickX# #kickY# #kickZ#
!notify found player "^rU've been Kicked in the Ass!"
```

## Events

### `!exec`

```gs
!exec <object> [client] "command"
```

Executes the console command specified between quotes on the server. The optional use of `client` allows the execution to happen on the client instead.

Script files, such as `.cfg` files, can be executed with:

```gs
exec script.cfg
```

### `!notify`

```gs
!notify <object> <player|team|all> "message"
```

Sends a notification in the chat window to the selected group of clients.

| Parameter | Meaning |
|---|---|
| `player` | Only the object receives the message. |
| `team` | The object's team receives the message. |
| `all` | Everyone in every team receives the message. |

### `!spawnobject`

```gs
!spawnobject <object> <objectType> <objectTeam> <hostile|neutral> <nearby|coords> (<x><y>)
```

Spawns a new object at the specified location. If the object is an item, its `.object` file must have:

```text
set canPickup 1
```

Parameters:

| Parameter | Meaning |
|---|---|
| `objectType` | Type of object to be created, for example `npc_chiprel`. |
| `objectTeam` | Team this object will belong to, from `0` to `4`. |
| `hostile` / `neutral` | Behaviour towards `<object>`. Only valid if the new object is an NPC. |
| `nearby` | Spawn new object within melee range of `<object>`. |
| `coords` | Spawn new object at location `<x> <y>`. |

> **Warning:** Do not spawn a Stronghold or Lair command center with this command.

### `!playsoundradius`

```gs
!playsoundradius <object> <radius> <sound>
```

Plays a sound for all clients in radius around the target. The sound is the path and filename relative to the `game` folder.

Example:

```text
/sound/human/buildings/construction.ogg
```

### `!changeunit`

```gs
!changeunit <object> <unitType>
```

Transforms the target object into the given unit, for example `npc_chiprel`. This is client-only. Also causes the immediate execution of the `@spawn` entry for that object.

### Notes on `!exec`

The `!exec` function is very powerful. It allows:

- Execution of console commands.
- Modification of any cvar value.
- Execution of custom scripts with the command below.

```gs
!exec null "exec script.cfg"
```

For the full list of console commands, see the Server Commands reference.

## Logic

### `!if`

```gs
!if <object> <condition> <entry>
```

Tests whether the object meets the specified condition. If the condition is met, the specified entry is executed.

Conditions such as `ally` or `enemy` are relative to the acting object, also known as `self`.

Valid conditions:

```text
enemy neutral ally character siege npc building item corpse
```

The condition can also be a statement, such as:

```gs
[myCvar1>=myCvar2]
```

Valid entries:

```text
@then0 ... @then9
```

Example:

```gs
!if null [bot_index==0] @then0
```

### `!ifnot`

```gs
!ifnot <object> <condition> <entry>
```

Tests whether the object meets the specified condition. If the condition is not met, the specified entry is executed.

Conditions such as `ally` or `enemy` are relative to the acting object, also known as `self`.

Valid conditions:

```text
enemy neutral ally character siege npc building item corpse
```

The condition can also be a statement, such as:

```gs
[_myCvar1>=_myCvar2]
```

Valid entries:

```text
@then0 ... @then9
```

Example:

```gs
!if null [_bot_index==0] @then0
```

### `!test`

```gs
!test <object> <condition>
```

Tests whether the object meets the specified condition. If the condition is not met, execution of the script breaks at this point.

Conditions such as `ally` or `enemy` are relative to the acting object, also known as `self`.

Valid conditions:

```text
enemy neutral ally character siege npc corpse building item
```

### `!testnot`

```gs
!testnot <object> <condition> [param] [...]
```

Tests whether the object meets the specified condition. If the condition is met, execution of the script breaks at this point.

Conditions such as `ally` or `enemy` are relative to the acting object, also known as `self`.

Valid conditions:

```text
enemy neutral ally character siege npc corpse building item
```

### `!setstate`

```gs
!setstate <object> <state> [<duration> <nextState>]
```

Switches the object to the specified state. If the optional `duration` in milliseconds is specified, the object switches to `nextState` afterwards.

Valid states:

```text
sleep idle activate
```

### `!delay`

```gs
!delay <object> <duration>
```

Allows a delay in milliseconds before switching to the first state specified in `!setstate`.

The `!delay` command must be written after the `!setstate` command in the script.

## GS Internal Cvars

Whenever a GS is executed, the engine automatically updates the content of these cvars. They can be used as parameters to any instruction, for example:

```gs
#gs_object_mana#
```

### Object Info

Information about the specified object.

| Cvar | Description |
|---|---|
| `gs_object_id` | Index of object, between `1` and `128` if the object is a player. |
| `gs_object_nick` | Nickname of object. Only valid if the object is a player. |
| `gs_object_name` | Name of object, for example `human_nomad` or `beast_lair`. |
| `gs_object_type` | Type of object: `client`, `npc`, `item`, or `building`. |
| `gs_object_team` | Team the object belongs to: `0`, `1`, `2`, `3`, or `4`. |
| `gs_object_posx`, `gs_object_posy`, `gs_object_posz` | Location of object. |
| `gs_object_dirx`, `gs_object_diry`, `gs_object_dirz` | Orientation vector of object. |
| `gs_object_scale` | Scale of object. |
| `gs_object_mana`, `gs_object_manapercent`, `gs_object_manamax` | Object's mana. |
| `gs_object_health`, `gs_object_healthpercent`, `gs_object_healthmax` | Object's health. |

### Parent Info

Only valid for triggers. Contains information about the trigger's parent object.

| Cvar | Description |
|---|---|
| `gs_parent_id` | Index of object, between `1` and `128` if the object is a player. |
| `gs_parent_posx`, `gs_parent_posy`, `gs_parent_posz` | Location of object. |
| `gs_parent_dirx`, `gs_parent_diry`, `gs_parent_dirz` | Orientation vector of object. |
| `gs_parent_scale` | Scale of object. |

### Game Info

General information about the game.

| Cvar | Description |
|---|---|
| `gs_game_time` | Game time. |
| `gs_game_status` | Game status. |
| `gs_game_status_end` | Game status end. |
| `gs_team1_resource1` through `gs_team4_resource5` | Team resource values. |

### Transmitted Info

These variables can be modified by GS instructions. Their values are then automatically transmitted to clients.

| Cvar | Description |
|---|---|
| `gs_transmit1` through `gs_transmit9` | Transmitted variables, useful for refreshing custom GUI information. |

## Example of Use

In this example, a `psphere` map trigger is looking for buildings being constructed inside the sphere.

When a team completes the construction of a building, the trigger should execute a GS that increments a variable telling us how many buildings that team has placed within the sphere.

The following script would do the job:

```gs
@activate
!exec target "inc _buildings_team#gs_object_team# 1"
```

## Source

Retrieved from:

```text
http://www.newerth.com/wiki/index.php/XR_Script_Triggers
```
