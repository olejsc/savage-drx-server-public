> **Disclaimer:** This reference is compiled from the 2nd Edition *Savage: Conquering Newerth* guide for *Savage / Savage XR: Battle for Newerth*. The game has evolved since that guide was written, so balance values, names, UI behavior, and live-server mechanics may be out of date. Verify against the current Savage XR version or server settings.

Source basis: *Savage: Conquering Newerth - Newerth Official Strategy Guide, 2nd Edition* by Muhammad Ali, with tables and recommendations interpreted from the uploaded guide PDF.

# Savage XR / Battle for Newerth - Detailed Human Reference

## Table abbreviations

| Abbreviation | Meaning |
|---|---|
| Udmg | Unit damage |
| Bdmg | Building damage |
| Sdmg | Siege damage |
| Acc | Accuracy |
| TT | Trajectory type |
| Rng | Range |
| AOE | Area of effect |
| Chrg | Charge time for maximum damage |
| Rfsh | Refresh time before next shot |
| ROF | Rate-of-fire behavior: BU = build-up, REP = repeat, CON = continuous |
| PV | Projectile velocity |

## Human units

| Unit | Move speed | Attack speed | Tier | Requires | Player cost | Research cost | Research time | HP by level 1-2 / 3-5 / 6-8 / 9+ | Base dmg L1-3 / L4+ | Unit dmg L1-3 / L4+ | Building dmg L1-3 / L4+ | Siege dmg L1-3 / L4+ | Level 8+ building dmg | Bags dropped | XP reward | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Nomad | 75 | 0.767 | Free | Nothing | Free | NA | NA | 250 / 260 / 270 / 320 | 80 / 90 | 120 / 135 | 60 / 67.5 | 56 / 63 | 112.5 | 4 | 10 | Basic worker-fighter. Fastest human build/repair rate among player units; low hit points. |
| Savage | 75 | 0.8 | 2 | Level 2 Stronghold | 2500 Gold | 600 Red Stone | 75 s | 400 / 410 / 420 / 470 | 126 / 136 | 189 / 204 | 189 / 204 | 63 / 68 | 272 | 6 | 10 | Well-rounded medium unit; good for field combat and average construction. |
| Legionnaire | 75 | 2.16 | 3 | Level 3 Stronghold | 4000 Gold | 1200 Red Stone | 75 s | 550 / 560 / 570 / 620 | 180 / 190 | 234 / 247 | 270 / 285 | 180 / 190 | 380 | 8 | 10 | Heavy melee unit with long axe reach and high durability; slow builder/repairer. |
| Chaplain | 75 | 0.65 | 2 | Level 2 Stronghold + Monastery | 1500 Gold | 500 Red Stone | 40 s | 250 / 260 / 270 / 320 | 75 / NA | 75 / NA | 36 / NA | 56 / NA | NA | 5 | 10 | Human healer/support. Fast attack rate helps building/repairing; no ranged weapon. |
| Ballista | Slow | 1.5 | 2 siege | Level 2 Stronghold + Siege Workshop | 4000 Gold | 500 Red Stone | 40 s | 1000 / 1010 / 1020 / 1070 | 1500 / 1500 | 1500 / 1500 | 1500 / 1500 | 600 / 600 | 1500 | 8 | 20 | Long-range accurate siege; 15 ammo; 234-unit range. |
| Catapult | Slow | 4.0 | 3 siege | Level 3 Stronghold + Siege Workshop | 7500 Gold | 800 Red Stone | 80 s | 3000 / 3010 / 3020 / 3070 | 5000 / 5000 | 5000 / 5000 | 5000 / 5000 | 1500 / 1500 | 5000 | 8 | 20 | High-HP area siege; short 150-unit range and large arc; hard to aim. |

## Human weapon statistics

| Weapon | Requires | Player cost | Research cost | Research time | Udmg | Bdmg | Sdmg | Acc | TT | Rng | Zoom | AOE | Chrg | Rfsh | ROF | PV | Ammo | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Hunting Bow | None | Free | None | None | 72 | 8 | 80 | 1.00 | Arc | 225+ | No | NA | 1 | 0.8 | BU | 2000 | 20 | Starter weapon; arcing arrows, slow refresh. |
| Crossbow | Arsenal | 100 Gold | 300 Red Stone | 15 s | 67.5 | 9 | 90 | 1.00 | Arc | 300+ | No | NA | 0 | 0.7 | REP | 3000 | 18 | Accurate, fast early weapon; limited ammo. |
| Marksman Bow | Arsenal | 500 Gold | 400 Red Stone | 30 s | 242 | 30 | 150 | 1.00 | Arc | 360+ | Yes | NA | 3 | 2.43 | BU | 22000 | 5 | Very accurate sniper bow; very slow reload and movement penalty. |
| Scattergun | Magnetic | Free | 200 Red Stone | 20 s | 180 | 192 | 240 | 0.10 | Str | 88 | No | NA | 1 | 0.7 | REP | 3000 | 10 | Shotgun-style; devastating up close, weak at range. |
| Repeater | Magnetic | 250 Gold | 300 Red Stone | 30 s | 19.5 | 5.2 | 26 | 0.80 | Str | 119 | No | NA | 0 | 0.12 | REP | 2000 | 110 | Beginner-friendly suppressive fire; huge clip, low long-range accuracy. |
| Coil Rifle | Magnetic | 500 Gold | 400 Red Stone | 40 s | 112 | 70 | 140 | 1.00 | Str | 223 | Yes | NA | 0 | 0.9 | REP | 2000 | 13 | Accurate rifle; can pass through multiple targets; bring ammo. |
| Discharger | Electric | Free | 200 Red Stone | 20 s | 150 | 100 | 200 | 1.00 | Str | 71 | No | NA | 1 | 0.5 | BU | 2000 | 20 | Charge weapon; dangerous if built up, risky at melee range. |
| Flux Gun | Electric | 250 Gold | 300 Red Stone | 30 s | 12 | 4.8 | 9.6 | 1.00 | Str | 54 | No | NA | 0 | 0.05 | CON | 500 | 250 | Continuous beam; slows targets, excellent anti-sac defense if aimed well. |
| Pulse Cannon | Electric | 500 Gold | 400 Red Stone | 40 s | 105 | 49 | 140 | 1.00 | Str | 171 | No | 30 | 0 | 0.4 | REP | 1200 | 25 | Slow projectile with area damage; useful against siege; weak vs Storm Shield. |
| Incinerator | Chemical | Free | 200 Red Stone | 20 s | 6 | 3.8 | 5 | 0.9 | Str | 21 | No | NA | 0 | 0.05 | CON | 300 | 180 | Short cone flame; guide considers it weak in original balance. |
| Mortar | Chemical | 250 Gold | 300 Red Stone | 30 s | 150 | 370 | 200 | 1.0 | Arc | 135 | No | 100 | 0 | 0.9 | REP | 200 | 8 | High building damage; awkward bouncing short-range projectile. |
| Launcher | Chemical | 500 Gold | 400 Red Stone | 40 s | 220 | 385 | 275 | 0.95 | Arc | 176 | No | 50 | 0 | 1.5 | REP | 450 | 10 | High damage and good anti-structure performance; slow projectiles and low ammo. |

## Human item statistics

| Item | Requires | Player cost | Research cost | Research time | Detailed effect |
| --- | --- | --- | --- | --- | --- |
| Health Pack | Research Center | 500 Gold | 300 Red Stone | 25 s | Carry up to 3; instantly restores 82/132/181 HP depending on unit size. |
| Ammo Pack | Research Center | 800 Gold | 300 Red Stone | 25 s | Carry 1; doubles ammo capacity for the carried weapon. |
| Demolition Pack | Chemical Factorium | 1000 Gold | 300 Red Stone | 25 s | Carry 1; 6000 building damage; 125-unit blast radius; 8-second timer; 250 HP before destroyed. |
| Land Mine | Chemical Factorium | 500 Gold | 300 Red Stone | 35 s | Carry 5; 500 damage; triggers within 50 units; team limit 25 active mines. |
| Sensor | Magnetic Factorium | 500 Gold | 200 Red Stone | 25 s | Reveals nearby enemies/Gateways with red beam/dot; 200 HP; team limit 25; max carried 3 if all inventory slots used. |
| Immobilizer | Magnetic Factorium | 250 Gold | 300 Red Stone | 35 s | Carry 2 stacked; thrown short range; 60-unit blast; roots/slows for 5 seconds. |
| Disruptor | Research Center | 500 Gold | 200 Red Stone | 25 s | Carry 3 stacked; 80-unit blast; 300 damage to friendly/enemy units; disables Flame/Healing/Wind spires for 10 seconds. |
| Relocater | Research Center | 500 Gold | 300 Red Stone | 25 s | Carry 1; places a 50-HP pad and teleports the user back to it. |

## Human structures

| Structure | Requires | Cost | Hit points | Build time | Detailed effect / notes |
| --- | --- | --- | --- | --- | --- |
| Arsenal | None | 500 Stone | 15,000 | Short | Researches weapons/equipment; required for Stronghold Level 2; if lost, only Garrisons and Towers can be built until rebuilt. |
| Garrison | None | 1000 Gold + 1000 Stone | 15,000 | Medium | Forward spawn, loadout, resupply, and worker drop-off point. |
| Research Center | Arsenal | 500 Stone | 15,000 | Short | Researches equipment; low/long profile can be used defensively or as climbable cover. |
| Siege Workshop | Arsenal + Level 2 Stronghold | 800 Stone | 15,000 | Long | Unlocks siege units; required for Level 3 Stronghold. |
| Monastery | Arsenal | 500 Stone | 15,000 | Long | Unlocks Chaplains and their support abilities. |
| Magnetic Factorium | Arsenal | 800 Stone | 15,000 | Long | Creates 100 Magnetism pool points; unlocks magnetic weapons/items, Shield Tower, Sensor, Shield buff. |
| Electrical Factorium | Arsenal | 800 Stone | 15,000 | Long | Creates 100 Electricity pool points; unlocks electric weapons/items, Shock Tower, Relocater, Electricity buff. |
| Chemical Factorium | Arsenal | 800 Stone | 15,000 | Long | Creates 100 Chemical pool points; unlocks chemical weapons/items, Mortar/Concussion Tower, Adrenaline buff. |

## Human towers and tower upgrades

| Tower | Requires | Cost | Upgrade time | HP | Scan range | Damage | Accuracy / velocity | Ammo refresh | Detailed effect / notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Arrow Tower | None | 250 Stone + 1500 Gold | None | 2500 | 500 | 68 | 1.0 / 1500 | 2.0 | Basic auto-defense; needs Sensor support to attack cloaked Beast. |
| Mortar Tower / Concussion Tower | Chemical Factorium | 250 Stone + 3000 Gold | 30 s | 4000 | 500 | 100 | 0.7 / 500 | 2.1 | Fires 5 mortars every 2 seconds; 50-unit AOE. |
| Shock Tower / Electrical Tower | Electrical Factorium | 250 Stone + 3000 Gold | 30 s | 4000 | 500 | 68 / 150 | 1.0 / 1500 | 2.0 | Fires arrows, helps against slow projectiles, and reflects some melee damage. |
| Shield Tower | Magnetic Factorium | 250 Stone + 3000 Gold | 30 s | 4000 | 500 | NA | NA | NA | 80% damage reduction to surrounding buildings; multiple shields do not stack. |

## Stronghold levels

| Stronghold level | Requires | Stone cost | Hit points | Research time |
| --- | --- | --- | --- | --- |
| Level 1 | Nothing | None | 25,000 | None |
| Level 2 | Arsenal | 750 Stone | 38,000 | 80 s |
| Level 3 | Siege Workshop + Research Center | 1500 Stone | 50,000 | 120 s |

## Human commander buffs

| Buff | Pool cost | Duration | Effect | Best use |
| --- | --- | --- | --- | --- |
| Shield | 75 Magnetic points | 10 s | Absorbs 80% incoming damage | Protect key attacker/builder or structure push. |
| Electricity | 75 Electric points | 10 s | 3x normal damage | Medium/heavy unit attacking structures or enemies. |
| Adrenaline | 50 Chemical points | 10 s | Speed burst | Capture spawn flag, reach/destroy Gateway, catch group, or slip through defenses. |

## Human healer details

| Chaplain ability | Requires | Player cost | Research cost | Research time | Effect |
| --- | --- | --- | --- | --- | --- |
| Healing Beam | Monastery | Free | None | NA | Continuous short-range healing; full bar gives about 400 HP over 6 seconds. |
| Potions | Monastery | Free | 300 Red Stone | 25 s | 60 HP over 11 seconds; 12 potions before restock; can heal grouped units and siege. |
| Resurrect | Monastery | Free | 400 Red Stone | 35 s | Revives fallen teammates; grants 500 gold and 5 XP; caster invulnerable during resurrection. |

## Human strategic notes by asset

### Units

- **Nomad:** Best for early construction/repair and cheap utility. Avoid brawling larger Beast units unless necessary.
- **Savage:** Medium unit suited for uncertain forward building because it can both fight and build.
- **Legionnaire:** Heavy melee threat with strong building damage and long reach, but slow attack/build rhythm.
- **Chaplain:** Saves resources through healing and resurrection; do not use as a front-line brawler unless forced.
- **Ballista:** Excellent ranged siege. Needs cover, spotting, and protection.
- **Catapult:** Very destructive but short-range and difficult; inexperienced users can waste team resources.

### Weapons

- **Crossbow** and **Repeater** are practical early weapons for many players.
- **Coil Rifle** is the guide's practical alternative to Marksman Bow for players who want accurate ranged pressure.
- **Flux Gun** is important against Sacrifice runs because it slows and damages approaching Beasts.
- **Mortar**, **Launcher**, and **Demolition Pack** are Human anti-building staples.

### Items

- **Health Pack** is one of the highest-priority early researches.
- **Ammo Pack** is essential for low-ammo weapons such as Coil Rifle, Launcher, Mortar, or Marksman Bow.
- **Sensor** placement determines whether towers can respond to hidden Beast approaches and Gateways.
- **Relocater** rewards survival and lets expensive units return to defend.

### Structures

- **Shield Tower** is often the highest-priority Human defensive structure because it reduces damage to nearby buildings by 80%.
- **Research Center** is cheap, low, and sometimes doubles as a physical defensive layout piece.
- **Siege Workshop** is strategically important and should be easy for players to notice and repair.


---

> **End disclaimer:** The game has evolved since the source guide was written. Treat all numbers and tactical recommendations as historical guide data unless confirmed against the current Savage XR build/server configuration.
