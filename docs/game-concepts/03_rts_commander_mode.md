> **Disclaimer:** This reference is compiled from the 2nd Edition *Savage: Conquering Newerth* guide for *Savage / Savage XR: Battle for Newerth*. The game has evolved since that guide was written, so balance values, names, UI behavior, and live-server mechanics may be out of date. Verify against the current Savage XR version or server settings.

Source basis: *Savage: Conquering Newerth - Newerth Official Strategy Guide, 2nd Edition* by Muhammad Ali, with tables and recommendations interpreted from the uploaded guide PDF.

# Savage XR / Battle for Newerth - RTS / Commander Mode

## Commander identity

The commander is responsible for the team's strategic layer. The guide describes commanding as management, leadership, and responsibility: the commander no longer acts as an individual player, because every decision affects the team.

The commander's job includes:

- building and defending the base;
- choosing technology routes;
- researching units, weapons, equipment, and relics;
- controlling workers;
- managing Red Stone and Gold;
- placing towers/spires and forward bases;
- issuing waypoints and orders;
- communicating threats;
- applying buffs at critical moments;
- deciding when to rush, tech, expand, or defend.

The guide's rough importance estimate is that commander strategy/tactics account for about 45% of victory, field player/officer skill and teamwork 25%, the opponent team's quality 25%, and luck 5%.

## Practice and preparation

| Principle | Commander behavior |
|---|---|
| Practice on low-population/empty servers | Learn controls, races, structures, resources, and maps before commanding a full public team. |
| Play maps from the ground first | Overhead view hides terrain realities such as slopes, cover, blind spots, and travel time. |
| Learn shortcuts | Fast selection, research, and worker orders help you out-tech slower commanders. |
| Multitask deliberately | Build, research, buff, watch minimap, answer important requests, and scan for threats. |
| Do not over-micro humans | Players have their own agendas. Direct priorities rather than trying to puppet every move. |

## What commanders can see that players cannot

The commander has a bird's-eye view. Use it to:

- mark threats when calling players back;
- point out hidden enemy gates, sensors, or forward structures;
- detect unprotected workers;
- identify likely expansion spots;
- see whether the enemy commander is distracted.

Do not simply spam "return to base". Tell players where the threat is and what type it is.

## Commander UI and auto-approval

The SEP commander GUI offers auto-approval controls for categories such as units, items, buffs, and money. The guide recommends restraint:

| Control topic | Recommended commander logic |
|---|---|
| Auto-accept | Useful with trustworthy teams; risky with inexperienced/selfish players. |
| Officers-only | Good default for buffs, because officers are more likely to use them at important moments. |
| Turn off during chaos | Disable auto-accept when you need to build reserves or prepare a coordinated push. |
| Category expansion | Restrict specific expensive units, siege, mines, or buffs without disabling everything. |
| Gold reserve | Keep at least enough Gold for emergency tower/forward base construction; guide suggests 1500 gold as a practical early reserve. |

## Buffs / commander powers

### Human powers

| Buff | Cost | Effect | Best use |
|---|---:|---|---|
| Shield | 75 Magnetic points | Absorbs 80% of incoming damage for 10 seconds | Protect structure attackers, builders, and exposed key players. |
| Electricity | 75 Electric points | Unit deals 3x normal damage for 10 seconds | Structure takedown with medium/heavy units; emergency close combat. |
| Adrenaline | 50 Chemical points | 10-second speed burst | Capture spawn flags, destroy distant gateways, catch up to pushes, slip past defenses. |

### Beast powers

| Buff | Cost | Effect | Best use |
|---|---:|---|---|
| Fire Shield | 75 Fire points | Player becomes engulfed in flames and damages nearby enemies | Sacrifice runs, surrounded Beast units, anti-structure pressure. |
| Replenish | 50 Strata points | Fully restores one unit's health, stamina, and mana | Save a key attacker or repeatedly support a structure takedown. |
| Gateway | 300 Entropy points | Opens a two-way portal between two map locations; each side has about 200 HP | Surprise attacks, base infiltration, rapid reinforcement, expansion setup. |

### Buffing discipline

Buffs should not sit at full energy forever, but they also should not be wasted. Good targets include:

- healthy heavy units attacking key structures;
- builders completing a critical forward base;
- siege or support units under pressure;
- players about to reach a high-value objective.

Avoid buffing nearly dead players unless the buff will clearly save them or complete a mission.

## Tech and research management

Tech is the speed at which new options become available. Fast, appropriate tech usually produces battlefield advantage.

| Practice | Reason |
|---|---|
| Queue same-tier research | Prevents forgetting upgrades while handling combat and base events. |
| Cancel bad research early | Canceling before completion refunds full resources; save Red Stone if you lose map control or need an expansion. |
| Do not hoard Red Stone | 2500+ unused Red Stone while the base is underdeveloped is "slow tech." Spend to keep pace. |
| Skip selectively | Some weapons/items are situational; skipping can speed higher-tier access. |
| Preserve expansion funds | Do not spend your last Red Stone if it prevents future expansion. |

## Resource management

| Resource concept | Commander rule |
|---|---|
| Red Stone | Primary strategic resource. Secure mines, build directly against them, and mine efficiently. |
| Gold | Necessary for units, equipment, towers, spires, forward bases, and approvals. Avoid worker gold mining unless Red Stone is exhausted and base is secure. |
| Power mining | Place Garrison/Sub-lair directly against a Red Stone mine so many players/workers can mine with minimal movement. |
| Furthest mine first | Mine outside sources while safe, preserving home reserves for fallback. |
| NPC economy | Build near Monkits or valuable NPCs when gold is scarce. |
| Commander tax | Guide notes common 46% player-gold tax, adjustable on many servers. |

## Workers

Workers are commander-controlled units and are the commander's dependable labor force. Each commander can have up to 10.

| Worker topic | Notes |
|---|---|
| Primary tasks | Mining, building, repairing, and other labor that field players often cannot spare time for. |
| Cost | Guide notes workers cost 50 Red Stone each. |
| Combat value | Very weak: 250 HP, about 15 damage per hit, slow/poor attacks. |
| Field movement | Send escorts if moving workers through dangerous space. |
| Idle control | Use the idle-worker indicator or `I` to check for workers doing nothing. |
| Defensive bait | A worker near tower range can lure enemies into defensive fire. |

### Build rate reference

| Unit | Minimum | Maximum | Average |
| --- | --- | --- | --- |
| Worker | 857/sec | 857/sec | 857/sec |
| Nomad | 165 | 246.5 | 206 |
| Savage | 162 | 214 | 188 |
| Legionnaire | 98 | 125 | 111 |
| Scavenger | 165 | 246.5 | 206 |
| Stalker | 170 | 210.5 | 190 |
| Predator | 104 | 132 | 118 |

One worker drastically increases construction speed. For forward bases, the guide recommends having at least 2-3 workers present when possible.

## Officers

Officers help bridge commander intent and field execution. They should be active, aggressive, communicative, and willing to follow orders; they do not have to be the top-kill players.

| Officer function | Details |
|---|---|
| Order key | `F` issues contextual orders based on target. |
| Target enemy/NPC | Marks attack target. |
| Target damaged friendly structure | Orders repair. |
| Target friendly unit/siege | Orders defense. |
| No direct target | Orders movement to location. |
| Quantity | Usually about 1 officer per 5 ground units, max 3 officers per team. |

### Officer regeneration reference

| Unit type | Regeneration | HP after 1 minute |
| --- | --- | --- |
| Officer | 6 HP every 5 seconds | 72 |
| Unit near officer | 5 HP every 5 seconds | 60 |
| Unit near 2 officers, not same unit type | 9 HP every 5 seconds | 108 |
| Beast using Rabid near officer | 23 HP every 5 seconds | 276 |
| Beast officer using Rabid | 20 HP every 5 seconds | 240 |
| Siege weapon near officer | 3 HP every second | 180 |
| Officer using siege weapon | 4 HP every second | 240 |

## Base construction and defensive planning

| Defensive concept | Commander logic |
|---|---|
| Easy exit, hard entry | Human bases benefit from one-way traffic and structures that friendly units can climb/exit through. |
| No gaps for Humans | Gaps let Beasts enter and hit multiple structures. |
| Some gaps for Beasts | Beast players need room to leap through their own base and respond quickly. |
| Internal expansion base | Garrison/Sub-lair inside or near main base can provide internal access to otherwise sealed areas. |
| Outsourcing | Build key tech/defense near a safer external mine if main base has poor room. |
| Rotate buildings | Control entrances, exits, sightlines, and defensive exposure. |
| Hidden radius defenses | Hide Shield Towers or Healing Spires behind structures/trees where they still apply effects. |
| Cheap building as shield | Arsenal/Nexus can block attacks against more valuable targets. |
| Repair discipline | Use workers only in emergencies; worker repair costs Red Stone and can be expensive. |

### Human defenses

- Stagger towers close together.
- Protect Shield Towers from Summoner line-of-fire and Sacrifice access.
- Keep repair access for friendly units.
- Avoid sealing a Shield Tower where a Beast Gateway could appear with no friendly access.

### Beast defenses

- Stagger spires.
- Place Healing Spire toward the back.
- Place Flame Spires forward.
- Wind Spire can sit between Flame and Healing to deflect some projectiles.
- Use structures such as Strata Shrine to block incoming siege lines toward Healing Spire when attack angles are predictable.

## Expansion and map-control logic

Important expansion targets include:

| Map feature | Strategic value |
|---|---|
| Choke points | Control movement and deny enemy access. |
| Elevated terrain | Makes enemy attacks harder and friendly attacks easier. |
| Halfway points | Shortens reinforcement time on large maps. |
| Red Stone mines | Determines tech, buffs, forward bases, and defenses. |
| Spawn flags | Alternate spawn without building a forward base; must be defended. |
| NPC groups | Gold/XP economy source, especially around Monkits. |

Risk assessment for forward bases should consider player reliability, enemy traffic, terrain advantage, available workers, allied support, resource reserves, and whether buffs are ready.

## Recommended tech route by map type

| Map / terrain condition | Humans | Beasts |
| --- | --- | --- |
| Small map | Electric > Chemical > Magnetic | Fire > Strata > Entropy |
| Medium map | Electric > Magnetic > Chemical | Strata > Fire > Entropy |
| Large map | Magnetic > Electric > Chemical | Strata > Entropy > Fire |
| Tight enclosed spaces | Chemical > Electric > Magnetic | Fire > Entropy > Strata |
| Open space | Magnetic > Electric > Chemical | Strata > Entropy > Fire |

## Counter-tech guidance

| Enemy plan | Counter choice | Why |
| --- | --- | --- |
| Beast Fire | Human Electric or Chemical | Flux and Land Mines help stop Sacrifice; Chemical gives mines/demos; Magnetic can add Shield Tower. |
| Beast Strata | Human Magnetic or Electric | Magnetic range and Repeater suppressive fire help against Tempest/Frost/Lightning pressure. |
| Beast Entropy | No strict tech counter | Main threat is Gateway; scan map/base and place Sensors. |
| Beast Summoner siege | Human Ballista or Magnetic | Best counter is preventing close Sub-lair/Gateway; Ballista can destroy siege spawn or Summoners from range. |
| Human Chemical | Beast Strata or Fire | Storm Shield counters AOE/mine pressure; Tempest pins; Fire provides Sacrifice/Fire Ward parity. |
| Human Electric | Beast Strata | Tempest is strong versus Flux users and remains useful later. |
| Human Magnetic | Beast Entropy or Strata | Healing Spire and Gateway pressure offset Shield Tower/long-range play; Strata gives stronger weapons if Entropy alone is weak. |
| Human siege | Beast Fire or Strata | Sacrifice kills grouped siege cheaply; Tempest can kill Ballistae from range. |

## Skipping tech

Selective skipping can accelerate higher-tier power but risks leaving the team under-equipped.

| Side | Skippable/situational tech noted by guide | Reason |
|---|---|---|
| Humans | Crossbow | Good early weapon, but skipping saves 300 Red Stone and 15 seconds. |
| Humans | Marksman Bow | Slow reload, low ammo, defensive playstyle; Coil often preferred. |
| Humans | Incinerator | Guide calls original version very weak; required if continuing Chemical line. |
| Humans | Immobilizer | Useful but often not carried due to inventory competition. |
| Humans | Catapult | Powerful but expensive and easy to waste with new players. |
| Beasts | Chaos Bolt | Slow projectile and low practical value after early minutes. |
| Beasts | Surge | High damage but burns mana quickly. |
| Beasts | Rupture | Large AOE, but Tempest is tier 2 and often better. |
| Beasts | Sixth Sense | Less valuable because Humans are easy to see and lack Beast-style stealth/leap. |
| Beasts | Snare | Useful but competes with stronger relics; snared Humans can still block or Relocate. |
| Both | Second-tier units | Can skip Stalker/Summoner and go toward Predator/Behemoth, but expensive and risky. |
| Both | Full healer investment | Full healer ability line is Red Stone-heavy and may reduce field damage on small teams. |

## Early-game strategy examples

### Human strategies

| Strategy | Required | Optional | Concept |
| --- | --- | --- | --- |
| Siege Rush | 8-10 workers, Arrow Tower, Arsenal, Crossbow, Level 2 Stronghold, Research Center, Siege Workshop, Health Packs, Ballistae | Ammo Pack, Forward Garrison, Savage | Fast Tier 2 siege; time forward Garrison with Ballista availability. |
| Flux Rush | 8-10 workers, Arrow Tower, Arsenal, Crossbow, Level 2 Stronghold, Research Center, Electric Factorium, Health Packs & Ammo, Flux Gun | Savage | Early Electric pressure; Flux has lots of ammo and short-range damage. |
| Repeater Rush | 8-10 workers, Arrow Tower, Arsenal, Crossbow, Level 2 Stronghold, Research Center, Magnetic Factorium, Health Packs & Ammo, Repeater | Savage | Suppressive Magnetic fire plus Shield Tower path. |
| Demo Rush | 8-10 workers, Arrow Tower, Arsenal, Crossbow, Chemical Factorium, Health Packs & Ammo, Research Center, Demolition Packs | Savage, Forward Garrison | Small-map anti-base rush; forward Garrison near/elevated over Lair. |
| Demo + Mortar Rush | Demo Rush plus Level 2 Stronghold, Incinerator, Mortar, Land Mines | Mortar Tower | Adds Mortar and mines for more structure damage; risk is short-range/inaccurate Chemical line. |

### Beast strategies

| Strategy | Required | Optional | Concept |
| --- | --- | --- | --- |
| Sacrifice Rush | 8-10 workers, Defensive Spire, Nexus, Fire Shrine, Level 2 Lair, Arcanum, Rabid, Sacrifice | Venomous, Fire Wards, Frenzy, Ember | Use spawn flags/Sub-lair and terrain to deliver Sacrifice quickly. |
| Melee Champions | 8-10 workers, Defensive Spire, Nexus, Level 2 Lair, Fire Shrine, Charm Shrine, Level 3 Lair, melee relics, Strata Shrine, Arcanum, Predator | Mana Crystal, Ember, Blaze, Frost Bolt, Tempest | Delay while teching to Predator; strong if team survives Tier 1 gap. |
| Tempest Pin | 8-10 workers, Defensive Spire, Nexus, Strata Shrine, Level 2 Lair, Arcanum, Frost Bolt, Stalkers, Tempest, Mana Crystal | Venomous, Rabid, Frenzy, Lightning | Use Tempest group fire to pin enemies; manage mana with crystals/Sub-lair/NPCs/melee. |
| Semi-Early Gate | 8-10 workers, Defensive Spire, Nexus, Fire or Strata Shrine, Entropy Shrine, Level 2 Lair | - | Build Gateway availability around five minutes after Entropy Shrine completes; follow with stronger damage tech. |

## Target priority when destroying bases

| Enemy base | Recommended priority |
|---|---|
| Human base | Shield Tower -> Siege Workshop -> Research Center -> Magnetic/Electric/Chemical Factoriums |
| Beast base | Healing Spire -> Charm Shrine -> Nexus -> Fire/Strata/Entropy Shrines |

A Human Shield Tower provides 80% damage reduction to nearby buildings. A Beast Healing Spire constantly repairs nearby structures. These should usually be first targets.

## Commander experience reference

| Commander action | Experience gained |
| --- | --- |
| Order given | 1 |
| Order followed | 1 |
| Power-up given | 5 |
| Structure built | 20 |
| Technology researched | 10 |
| Enemy structure destroyed | 50 |
| 1000 resources gathered | 1 |
| Demolish own building | -20 |

## End-game discipline

The guide warns commanders not to abandon the seat merely to avoid a loss. Leaving command briefly to solve a low-population emergency can be valid, but it risks confusion, loss of buffs, and another player taking the seat. The last player in the commander seat receives the recorded win/loss.

The practical commander mindset: take losses as feedback, not proof that every decision was wrong. Public teams are unpredictable, and even good commanding can lose to better execution or unusual player behavior.


---

> **End disclaimer:** The game has evolved since the source guide was written. Treat all numbers and tactical recommendations as historical guide data unless confirmed against the current Savage XR build/server configuration.
