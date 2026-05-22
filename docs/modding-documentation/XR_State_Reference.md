# XR State Reference

## Introduction

States handle effects and changes that occur to objects for a set period of time, such as adrenaline buff or fire buff.

Most attributes can use either positive or negative values. For example, `damageAdd` works with both `100` and `-100`.

## List of All Available State Attributes

| Attribute name | Default value | Description |
|---|---:|---|
| `icon` | `""` | The icon to be displayed in the GUI while affected by this state. |
| `slot` | `0` | The slot ID for the state to be in. Valid values are `0` to `254`. When a state is applied to an object, it overwrites any other state in the same slot. |
| `priority` | `0` | Priority in terms of slot ID. |
| `damageAdd` | `0.0` | Adds the given amount of damage to the object's melee attack. `Melee Damage + damageAdd = Damage`. |
| `damageMult` | `1.0` | Multiplies the object's melee damage by the given amount. `Melee Damage * damageMult = Damage`. |
| `armorAdd` | `0.0` | Adds damage reduction. All objects have `0` armor. `Potential Damage * (1 - Armor) = Actual Damage`. `1.0` is maximum. `0.0` is minimum. Armor cannot sink below `0`. |
| `armorMult` | `1.0` | Multiplies the affected object's armor by the given amount. See `armorAdd` for more information about armor. |
| `speedAdd` | `0.0` | Adds the given amount of speed to the object's default speed. Player-controlled units have `1.75` as default. |
| `speedMult` | `1.0` | Multiplies the object's speed by the given amount. |
| `jumpAdd` | `0.0` | Increases the object's default `jumpHeight`. |
| `jumpMult` | `1.0` | Multiplies the object's `jumpHeight` by the given amount. |
| `attackSpeedAdd` | — | Not implemented. |
| `attackSpeedMult` | — | Not implemented. |
| `healthAdd` | — | Not implemented. |
| `healthMult` | — | Not implemented. |
| `regenRateAdd` | `0.0` | Increases the delay at which the object regenerates health. |
| `regenRateMult` | `1.0` | Multiplies the delay at which the object regenerates health. |
| `regenAdd` | `0.0` | Increases the amount of health which the object regenerates. |
| `regenMult` | `1.0` | Multiplies the amount of health which the object regenerates. |
| `manaRegenRateAdd` | `0.0` | Increases the delay at which the object regenerates mana. |
| `manaRegenRateMult` | `1.0` | Multiplies the delay at which the object regenerates mana. |
| `manaRegenAdd` | `0.0` | Increases the amount of mana which the object regenerates. |
| `manaRegenMult` | `1.0` | Multiplies the amount of mana which the object regenerates. |
| `staminaRegenAdjust` | `0.0` | Increases the amount of stamina which the object regenerates. |
| `damage` | `0.0` | Deals damage to the affected object periodically. See `damageFrequency`. |
| `damageFrequency` | `0.0` | The rate, or delay, at which damage is dealt to the affected object. See `damage`. |
| `damageFlags` | `-` | Flags for additional damage effects. See `damage`. |
| `cloak` | `0` | Boolean to turn the affected object invisible or transparent. `1` = invisible. Example: Mist Shroud. |
| `markEnemies` | `0` | Boolean that allows the affected object to see invisible enemies. `1` = on. Example: Sixth Sense. |
| `lockdownTech` | `0` | Unknown. |
| `splashProtect` | `0` | Boolean to grant the affected object immunity against splash and area damage. `1` = immune. Example: Storm Shield. |
| `staminaDrain` | `0.0` | If higher than `0`, defines how much stamina the affected object gains when attacking a unit. Example: Rabid. |
| `transferHealth` | `0.0` | If higher than `0`, defines how much health the affected object gains when attacking a unit. Example: Carnivorous. |
| `isVulnerable` | `1` | Boolean to grant the affected object complete damage immunity. `0` = invulnerable. Example: Storm Shield. |
| `silence` | `0` | Boolean that disables the use of all inventory slots except slot `0`, which is the default melee slot. |
| `stunObject` | `0` | Boolean that disables attacking and moving. Jumping still works; use `jumpAdd` to disable it. |
| `radiusDamage` | `0` | Deals damage periodically to all valid objects around the affected object itself. See `radiusDamageFreq`. |
| `radiusDamageFreq` | `0` | The rate, or delay, at which damage is dealt to all valid objects around the affected object itself. See `radiusDamage`. |
| `radius` | `0` | The radius in which damage is dealt to all valid objects around the affected object itself. See `radiusDamage`. |
| `radiusTargets` | `-` | Defines which targets are affected by `radiusDamage` and `radiusState`. |
| `radiusState` | `"state0"` | A state which is granted to valid targets. See `radiusTargets`. Example: Officer regen. |
| `radiusStateLength` | `0` | How long the state granted via `radiusState` lasts. As long as a valid object is within the radius of the parent state, this state reapplies continuously until the object leaves the radius or the parent state ends. At that point, `radiusStateLength` applies. |
| `model1` to `model5` | `""` | Additional models to attach or show on top of the affected object. Example: Shield buff. |
| `skin1` to `skin5` | `""` | Skin definitions for `model1` to `model5`. |
| `bone1` to `bone5` | `""` | Bone attachment definitions for `model1` to `model5`. |
| `useCharAnim1` to `useCharAnim5` | `""` | Animation definitions for `model1` to `model5`. |
| `singleShader` | `""` | Special shader to be used. |
| `effect` | `""` | Effect to be attached to the affected object while under this state. Example: Adrenaline. |
| `effectPeriod` | `10 10` | Period for the effect. This can be ignored. |
