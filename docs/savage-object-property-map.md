# Savage Object Property Map

This repository stores game tuning in `game/script/<conversion>/objects/*.object`,
`states/*.state`, and object lists such as `XR.objlist`. The `summoner_arc`
conversion overrides only the Summoner files and falls back to `standard/` for
everything else.

## Summoner Arc Overrides

- `game/script/summoner_arc/objects/beast_summoner.object`
  - `description "Summoner Arc"` as a visible load check in the spawn UI
  - `isVehicle 1`, `canEject 1`, `ejectUnit "beast_scavenger"` as the first
    Ballista/Catapult-style control experiment
  - `fixedPitch 0.000000`
  - `allowFirstPerson 1`
  - `minAimX 0.330000`, `maxAimX 0.670000`
  - `minAimY 0.280000`, `maxAimY 0.620000`
- `game/script/summoner_arc/objects/beast_summoner_weapon.object`
  - keeps `velocity 900.000000 900.000000`
  - keeps `gravity 0.220000`
  - keeps `fuseTime 2700 2700`
  - keeps `hitBuilding`, `hitUnit`, and `hitWorld` as `"die"`
  - changes `bounce` from `0.500000` to `0.000000`

## Projectile Tuning Knobs

- `velocity`: horizontal projectile speed range. With `fuseTime`, this is the
  practical maximum distance before the projectile vanishes.
- `vertVelocity`: extra vertical launch speed range. Most ranged weapons leave
  this at `0.000000 0.000000`; thrown or arcing items sometimes use nonzero
  values.
- `gravity`: downward acceleration applied to the projectile. Higher values make
  the projectile drop sooner.
- `fuseTime`: lifetime range in milliseconds. When it expires, the projectile
  dies even if it has not hit anything.
- `hitWorld`, `hitUnit`, `hitBuilding`: collision behavior. Observed values
  include `"die"` and `"bounce"`.
- `bounce`: bounce factor used when the projectile is allowed to bounce.
- `accelerate`: changes projectile speed over time. `human_boomerang` uses a
  negative value.
- `minVelocity`, `maxVelocity`: observed on ranged weapons and items, usually
  `0.000000` unless the weapon supports charged velocity.
- `radius`: blast radius range; `0.000000 0.000000` means direct-hit damage.
- `damage`, `unitpierce`, `bldpierce`, `siegepierce`, `damageFlags`: damage
  tuning and target-category modifiers.
- `muzzleRightOffset`, `muzzleFwdOffset`, `muzzleUpOffset`: projectile spawn
  offset from the firing unit or weapon bone.
- `inheritVelocity`: whether projectile motion inherits shooter velocity.
- `trailEffect`, `trailPeriod`, `projectileEffect`, `deathEffect`: visual
  feedback for flight and impact/death.

## Ballista Aim Box Reference

`game/script/standard/objects/human_ballista.object` constrains player aim with:

- `fixedPitch 0.000000`
- `allowFirstPerson 1`
- `minAimX 0.330000`, `maxAimX 0.670000`
- `minAimY 0.280000`, `maxAimY 0.620000`

The Summoner arc override copies these aim bounds for the config-only v1.
It does not copy Ballista's `bmin_*`/`bmax_*` values; those are physical object
collision bounds, not the mouse aim box.

## Observed Property Names

These names were extracted from the checked-in `.object` and `.state` files.
They are observed config keys, not a full engine API guarantee.

### Unit `objSet`

`aggressionChance`, `aggressionInterval`, `aggressionRange`, `airControl`,
`alias`, `allowFirstPerson`, `allowInventory0..15`, `allowSiege`,
`alwaysAvailable`, `alwaysWaypoint`, `animSpeed`, `attachBone`, `attachBone2`,
`attackEnemyDistance`, `attackMeleeChance`, `attackMissileChance`,
`attackPoundChance`, `attackProbability`, `attackSuicideChance`,
`autoConstructDistance`, `autoMineDistance`, `backbone`, `backmodel`,
`backskin`, `backwardsSpeed`, `basePointValue`, `bldpierce`, `blockArc`,
`blockPower`, `bloodEffect1..3`, `bmin_x`, `bmin_y`, `bmin_z`, `bmax_x`,
`bmax_y`, `bmax_z`, `bobAmount`, `bobSpeedRun`, `bobSpeedSprint`, `builder1..3`,
`buildingGoldIncomeMult`, `buildRate`, `canBeRepaired`, `canBeSilenced`,
`canClaim`, `canDodge`, `canEject`, `canEnter`, `canGrab`, `canPurchase`,
`canPush`, `canRepairBuildings`, `canRepairUnits`, `canRide`, `canSprint`,
`cloakAtIdle`, `cmdrScale`, `cmdrSelectionScaleAdjust`, `cost`, `description`,
`distOffset`, `dodgeChance`, `dodgeDistance`, `dodgeRestTime`, `drawHealth`,
`drawName`, `drawTeamIcon`, `effect`, `ejectUnit`, `expMult`,
`extraRespawnTime`, `fixedPitch`, `fleeChance`, `fleeThreshhold`, `footstepType`,
`forceInventory0..15`, `friction`, `fullHealth`, `gridmenu`, `healAmount`,
`healRate`, `icon`, `isMount`, `isNPC`, `isPassive`, `isScared`,
`isSiegeWeapon`, `isVehicle`, `isVulnerable`, `isWorker`, `jumpHeight`,
`killGoldReward`, `killResourceReward`, `knockBackMult`, `leftMeleeModel`,
`level`, `manaRegenAmount`, `manaRegenRate`, `mapIcon`, `mass`, `maxAimX`,
`maxAimY`, `maxCarry`, `maxMana`, `maxPopulation`, `maxRiders`, `maxStamina`,
`maxWeapPoints`, `meleeOnlyVulnerable`, `minAimX`, `minAimY`, `mineRate`,
`model`, `needBasePoints`, `needTechPoints`, `npcTarget`, `objclass`,
`pitch`, `playerCost`, `proximity`, `race`, `repairRate`, `requirement1..3`,
`researchTime`, `respawnTime`, `revealHidden`, `revivable`, `rightMeleeModel`,
`roll`, `scale`, `scanRange`, `selectionIcon`, `selectionSound`, `shader`,
`shopIdOnly`, `siegepierce`, `skin`, `spawnEffect`, `spawnFrom`, `speed`,
`staminaRegenRate`, `stepHeight`, `targetFlags`, `techPointValue`, `techType`,
`thornDamage`, `tooltip`, `totalLives`, `turnRate`, `unitpierce`,
`viewDistance`, `viewHeight`, `voiceMenu`, `yaw`.

### Weapon `objSet`

`accelerate`, `accuracy`, `allowFirstPerson`, `alwaysAvailable`,
`alwaysWaypoint`, `ammoCost`, `ammoGroup`, `ammoMax`, `ammoName`, `ammoStart`,
`animGroup`, `attachBone`, `backfireEffect`, `backfireTime`, `basePointValue`,
`bldpierce`, `bounce`, `bounceEffect`, `builder1`, `builder2`,
`buildingGoldIncomeMult`, `canBeSilenced`, `canDodge`, `canOverheat`,
`chargeFlags`, `chargeTime`, `continuous`, `continuousBeamShader`,
`continuousBeamType`, `cooldownTime`, `cost`, `count`, `damage`, `damageFlags`,
`deathEffect`, `description`, `drawTeamIcon`, `effect`, `expMult`,
`fireDelay`, `flybyEffect`, `focusDegraderate`, `focusPenalty`,
`focusRecoverRate`, `fullHealth`, `fuseTime`, `gravity`, `handEffect`,
`handModel`, `handSkin`, `heatFlags`, `hitBlock`, `hitBuilding`, `hitUnit`,
`hitWorld`, `icon`, `inheritVelocity`, `isSelectable`, `isVulnerable`,
`manaCost`, `mapIcon`, `maxHold`, `maxVelocity`, `minVelocity`, `minfov`,
`model`, `muzzleFwdOffset`, `muzzleRightOffset`, `muzzleUpOffset`,
`needBasePoints`, `needTechPoints`, `objclass`, `overheatTime`, `pitch`,
`playerCost`, `projectileEffect`, `projectileModel`, `projectileRadius`,
`projectileScale`, `projectileShader`, `projectileSkin`, `projectileSound`,
`race`, `radius`, `rechargeTime`, `refreshTime`, `repeat`, `requirement1..3`,
`researchTime`, `revealHidden`, `roll`, `scale`, `scanRange`, `selectionIcon`,
`shader`, `shopIdOnly`, `siegepierce`, `skin`, `spawnEffect`,
`speedPenalty`, `spindownTime`, `spinupTime`, `staminaDrain`,
`startFuseAtCharge`, `stopEffect`, `targetFlags`, `techPointValue`, `techType`,
`trailEffect`, `trailPeriod`, `transferHealth`, `twangAmount`,
`twangPingPong`, `twangTime`, `unitpierce`, `useMana`, `useWeaponFire`,
`velocity`, `vertVelocity`, `weapon`, `weaponFireEffect`, `weapPointValue`,
`yaw`.

### `atkSet`

`CanJump`, `ChargeTime`, `damage`, `damageFlags`, `flurry`, `flurryTime`,
`forward`, `horzKick`, `impact`, `lockAngles`, `lunge`, `lungeTime`, `range`,
`restTime`, `right`, `SpecialOne`, `SpecialTwo`, `speed`, `time`, `vertKick`,
`xLunge`, `yLunge`.

### `stateSet`

`armorAdd`, `armorMult`, `attackSpeedAdd`, `attackSpeedMult`, `bone1..5`,
`cloak`, `damage`, `damageAdd`, `damageFlags`, `damageFrequency`, `damageMult`,
`effect`, `effectPeriod`, `energyArmorAdd`, `energyArmorMult`, `healthAdd`,
`healthMult`, `icon`, `indicatorBlue`, `indicatorGreen`, `indicatorRed`,
`isVulnerable`, `jumpAdd`, `jumpMult`, `lockdownTech`, `manaRateMult`,
`manaRegenAdd`, `manaRegenRateMult`, `manaShield`, `markEnemies`, `model1..5`,
`modelsize1`, `neverDisplayTime`, `priority`, `radius`, `radiusDamage`,
`radiusDamageFreq`, `radiusState`, `radiusTargets`, `regenAdd`, `regenMult`,
`regenRateAdd`, `regenRateMult`, `rooting`, `siegeArmorAdd`, `siegeArmorMult`,
`silence`, `singleShader`, `skin1..5`, `slot`, `speedAdd`, `speedMult`,
`splashProtect`, `staminaRegenAdjust`, `useCharAnim1..5`, `useIndicator`,
`weaponBldPierceAdd`, `weaponBldPierceMult`, `weaponSiegePierceAdd`,
`weaponSiegePierceMult`, `weaponUnitPierceAdd`, `weaponUnitPierceMult`.
