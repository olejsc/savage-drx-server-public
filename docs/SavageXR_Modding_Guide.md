# Savage XR Modding Guide

If help is ever required, we — the Official Savage XR Modding Team, along with other modders and Devs — can mostly be found on IRC:

- `irc.newerth.com`
- `#savagemods`

## The Very Basics

If you have absolutely no idea of the basics, keep on reading. Otherwise, skip the next part.

Let's begin with Savage's basic files.

Go into your `./Savage XR/game/` directory and look for a file called `savage0.s2z`. The `savage0.s2z` file is actually an archive and can be opened as one. Every archiver that can pack or unpack `.zip` files should be able to open it.

The following list gives you a basic understanding of the different sections:

- `effects`
- `gui`
- `models`
- `script`
- `shaders`
- `sound`
- `textures`

### Effects

All the visual and auditory feedback you witness in-game, such as the green sparkles for the speed buff.

### GUI

The graphics you see on your screen when playing. This includes the main menu, the options, the HP and mana bars, and anything else related. GUI stands for **Graphical User Interface**.

### Models

This is where all models seen in-game are located, excluding environment models. For example, the nomad unit is a model.

### Script

Contains everything else that can be used to mod, including:

- EXP tables, such as levels and upgrades for your unit
- Objects, such as weapons, items, and units
- States, such as firebuff and adrenaline, which influence an object over a period of time
- Stringtables, such as sound links, in-game text, and some GUI links
- Team upgrades, which are not implemented
- Server configs
- Voice chats

### Shaders

The in-game shaders can be found here. You really do not want to touch them.

### Sound

All sounds, including the music heard in-game. The exception is sound files externally packed into map files.

### Textures

All graphics that are not directly linked to models and GUI are found here, such as minimap dots and icons.

## Game Mode Folders

If you open the `scripts` directory, you will find another list of folders. These folders represent the currently existing **game modes** available in Savage. `standard` is probably the one you are looking for, as it is the normal game mode.

## Opening Savage File Types

By now, it is time to ask yourself: **How the Trigardon do you open that?**

Check this list to see what you need to open these files:

| Extension | Description | How to open |
|---|---|---|
| `.effect` | Effects found in Savage, such as weapon effects. | A normal text editor. |
| `.s2g` | A graphic file. | Use the S2G Exporter: <http://www.newerth.com/?id=downloads&op=displayDownload&category=6&file=S2G_Converter.zip> |
| `.s2z` | Acts as an archive. | Use an archiver that can open `.zip` files. |
| `.anim` | An animation, such as walking. | Can be opened with a text editor and 3ds Max using the 3ds Max importer/exporter: <http://www.newerth.com/?id=downloads&op=displayDownload&category=6&file=SavageXR_Plugin.zip> |
| `.clip` | A state of an animation. | 3ds Max via the importer/exporter. |
| `.model` | Mostly a single model. | Only with 3ds Max using the importer/exporter. |
| `.mat` | Material. | Used in 3ds Max and can possibly be opened with it. |
| `.gs` | Gamescripts. | A normal text editor. |
| `.object` | An object, such as the legionnaire or behemoth. | A normal text editor. |
| `.state` | A state in Savage, such as firebuff. | A normal text editor. |
| `.str` | Stringtables. | A normal text editor. |
| `.sndmat` | Sound material. | A normal text editor. |

## What Should You Begin With?

The simplest option to mod is writing binds.

There are different ways to add binds:

- Write it into `autoexec.cfg`, which can be found in the `./Savage XR/game/` directory.
- Write it into the console in Savage, which can be opened with `^`.
- Write it into chat. Add a `/` before the whole command; this is absolutely necessary in chat.

The bind syntax is:

```text
bind <key> <command>
```

The `bind` command asks for a key — the key you want the bind to be set on — and for a command — what the bind should do.

As every tutorial starts with the infamous words of "Hello World":

```text
bind "k" "chat Hello World!"
```

This is a fairly simple command, but you can do very advanced things with bindings.

Groentjuh once wrote a great guide about this, so check it out: <http://www.newerth.com/smf/index.php/topic,519.0.html>

Next, we shall take a look at **States**, **Objects**, and **Gamescripts**. To do this, move to the following path:

```text
./SavageXR/game/savage0.s2z/script/
```

# States

## Editing Existing States

Let's start off small. We shall change something that already exists: increasing a unit's movement speed under the effects of a chaplain's potion.

When a chaplain throws a potion, which then shatters, it applies a state to all units in range. We do not have to change anything about the chaplain or the potion. All we are interested in is the state that is granted.

Open the folder `states`. Here you will find all existing Savage states. The one we are looking for is called `human_potion.state`. Open it with any text editor. This file contains all attributes and properties that this specific state has.

The most difficult part is finding the attribute we want to change. Fortunately, we are starting off simple. Find the following attributes:

- `stateSet speedAdd`
- `stateSet speedMult`

To spare yourself the trouble, use <kbd>Ctrl</kbd> + <kbd>F</kbd> and search for those words.

Change the value behind `speedAdd` to `3.000000`. Save the file. Any unit affected by this state will have its speed increased by `3`, which is a lot.

Start Savage to test the change. Once Savage is done loading, open the console and input:

```text
devworld eden2
```

This will start a private server with all units and weapons enabled right away, which is perfect for testing.

Join the human team to select a chaplain and spawn. Run around a little to witness the normal speed, then throw a potion onto the ground so that the state affects you. Run around and witness the increase in speed.

Play around with some of the existing states to get familiar with them. There are a lot of attributes that can be changed, most of them with obvious results. If you cannot figure out what a specific attribute does, there is no shame in asking an experienced modder to explain.

Now let's create our own state and implement it into Savage.

## Creating Your Own States

Return to the `states` folder where we changed `human_potion.state`.

You could either create a state file from scratch, or do yourself the favor of copying one so you do not have to rewrite all the attributes. Copy any state — this guide uses `adrenaline.state` — and set all values to their default, meaning no effect.

If you are using `adrenaline.state`, reset `speedMult` to `1.000000`. Also reset anything else you may have changed while experimenting.

Rename the file to something else. This guide will use:

```text
myState.state
```

Once done, search for the file `statelist.cfg` in the same folder. Any states you add have to be registered in that file; otherwise, they will not be loaded.

Add this to the list:

```text
stateload myState
```

Savage will now recognize and read this new state.

While the state will now be loaded, we are not done yet. Nothing actually causes the state to occur.

Go back one folder to `standard`, then open `objects`, followed by `scripts`. We will only pay a short visit to these scripts and return later.

Open the file `beast_rabid.gs` with any text editor. Inside, replace `rabid` with `myState`. Save and close the file.

This file governs the state for rabid, which we just replaced with our own. This means that when a unit equips and then spawns with the rabid item, our state will be loaded onto that unit.

Start Savage to test our state. Once Savage is done loading, open the console and input again:

```text
devworld eden2
```

Join the beast team, equip a rabid item, and then spawn. We did not actually change any attributes in our state, but if you copied `adrenaline.state` as this guide did, you will have the green sparkly effect following your unit now.

Change `myState` however you please. You have just successfully implemented a state into Savage.

# Objects

## Editing Existing Objects

Return to the folder `standard` and open the folder `objects`. Just as with states, we can easily open one of these files and edit some values.

Open `human_nomad.object`. Notice that it looks similar to the state files, only with different attributes.

To keep it simple, search for the attribute `speed`, not `bobSpeedRun`. Change the value to whatever you want. The default is `1.750000`. Change it significantly so the difference is easier to notice. Save the file and close it.

Start Savage to test the change. Once Savage is done loading, open the console and input:

```text
devworld eden2
```

Join the human team to select a nomad and spawn, then run around. If you changed the value greatly enough, you will notice a change in speed.

Play around with some existing objects to get familiar with them. There are a lot of attributes that can be changed, most of them with obvious results. If you cannot figure out what a specific attribute does, there is no shame in asking an experienced modder to explain.

## Creating Your Own Objects

Back inside the `objects` folder where we changed `human_nomad.object`, we shall again simply copy a file instead of writing the whole file ourselves.

Copy `human_savage.object` and rename the copy to:

```text
human_unit.object
```

Once done, return back one folder to `standard`. You should be using XR, so open the file `XR.objlist` with any text editor.

Any objects you add have to be registered in this file for Savage to load them. Add this line anywhere in the list:

```text
objload human_unit
```

> **Note:** To be safe, add this `objload human_unit` line to `SEP-3.objlist` as well, since your server settings might be on SFE/SEP rather than XR.

Return to `objects` to change some values before testing in-game. Open your new object, `human_unit.object`.

Search for `description`, although there is no real need to search because it is the second line of the file. This attribute is basically the name of the unit you see in the loadout/spawn screen. This guide names him `Uttar`.

Then search for `rightMeleeModel` and copy the following path after it:

```text
/models/human/weapons/melee/sword/sword.model
```

Then one line below, add what you copied behind `leftMeleeModel`.

It should look like this:

```text
objSet rightMeleeModel "/models/human/weapons/melee/sword/sword.model"
objSet leftMeleeModel "/models/human/weapons/melee/sword/sword.model"
```

Our unit now has a sword in both hands.

Now search for `jumpHeight` and change the value to:

```text
10.00000
```

Start Savage to test our new unit/object. Once Savage is done loading, open the console and input:

```text
devworld eden2
```

Join the human team. If all went well, your new unit should be visible and selectable. Find `Uttar`, select him, and spawn. Jump and witness his superior leg muscles.

# Gamescript

## Show and Tell

We have already gone through states and objects, but we are still lacking one piece of the puzzle: scripting. While not every object needs a script, every object can have a script it follows.

Let us use the Savage item known as `Snare` to understand this better.

- `beast_snare.object` is the physical object itself that you can buy in the shop and then throw at enemies.
- `snare.state` is the state that is applied to all enemy objects hit by the item when it is thrown.

This object and this state have no idea of one another, so we need something that causes the state to occur when the item is thrown. For this purpose, `beast_snare.gs` is necessary.

`.gs` files are scripts that are run whenever something for the same-named object happens.

Inside the `object` folder is another folder called `scripts`, which is where all the GS files are situated. Find `beast_snare.gs` and open it.

```text
@fuse
!givestateradius self 30 snare 3000
!die self
```

For lines of script to occur, the given entry point, indicated by `@`, has to happen in-game. In this case, `@fuse` refers to when the item's lifetime ends, meaning when the item dies or disappears. Once the item fuses, the next lines of code are run until the next `@` appears.

A line of code is indicated by the symbol `!` and stands for a function.

```text
!givestateradius self 30 snare 3000
!die self
```

All functions start with `!` and their name, followed by a target object. After that, all other parameters are given.

`!givestateradius` is a function that grants a given state to all valid targets around the given target. In this case, `snare` is given to all targets around `self`, which is the object itself — the snare that fuses — in a radius of `30` for a time period of `3000` milliseconds.

`!die` is a function that kills the given object. In this case, `self`, the snare that fuses, is removed from the game.

## 1. Simple Item Change

This is probably all quite confusing at first glance, so let's try experimenting with some existing scripts.

Open the file `human_medkit.gs`. Inside, you will notice a new entry point: `@use`. This entry point occurs when the object `human_medkit.object` is used in-game.

When you use a medkit, the line after that is called:

```text
!heal target .33
```

This heals `target`, the unit that used the medkit, for 33% of its maximum health.

Delete these lines of script and add the following:

```text
@use
!damage owner 100 1
```

`!damage` is the opposite of `!heal`. It removes health from the target object. In this case, `owner` is the unit that owns the medkit. The `1` indicates that armor is ignored, meaning shield buff does not reduce the damage.

Save the file and start Savage to test the change. Open the console and input:

```text
devworld 2
```

Join the human team, buy some medkits, and spawn. Select your medkits and look closely at your health. Use a medkit, and you will lose 100 health. Use another medkit, and another 100 health is gone.

## 2. Simple Melee Change

Let's move on to the next example: melee.

Open the folder `scripts` inside `objects`, if you have not already. Find the file `beast_poison.gs`. This script file is the beast melee enchantment `Venomous`.

Yet again, there is a new entry point: `@impact`. This entry point occurs when the weapon hits something.

`!givestate` works similarly to its close cousin `!givestateradius`. The only difference is that it has no radius. Thus, you should be able to tell what that line does.

> **Spoiler:** It grants `target`, the object that was hit, the state `poisoned` for `5000` milliseconds.

`!testnot target ally` is a little more tricky. Basically, if `target`, the object you hit, is an ally, the script does not continue. As such, only enemies will be poisoned.

Let's try something strangely funny. Remove the code and add this instead:

```text
@impact
!push target 0 0 1000
```

Start Savage in devworld as usual. Join the beast team and equip `venomous`. Then start hitting units: workers, neutral NPCs, enemies, and allies.

> **Spoiler:** Anything that is hit is thrown into the air. Static objects like buildings are not affected.

## 3. Adding GS to a Weapon

As should be unsurprising, weapons can also use scripts. However, no existing Savage weapon actually uses a script. As such, let's add a GS file ourselves this time.

Inside the `object` folder are many weapon objects. This guide uses `beast_strata2.object`, which is tempest.

Inside the `scripts` folder, add a new text file, or copy an existing file, and rename it to:

```text
beast_strata2.gs
```

Open it and add the following code:

```text
@impact
!if target enemy @then
!if target ally @then

@then
!push owner 0 0 1000
!teleport target home

@then
!damage target 100 1 1
```

`@then0` through `@then9` are entry points that only occur when an `!if` relays the script to one.

For example:

```text
!if target enemy @then0
```

If the target that is hit is an enemy, the entry point `@then0` is run. If the target is not an enemy, `@then0` is ignored.

Start Savage, join the beast team, equip tempest, and start shooting at things to witness the implementation of your own GS script.

## 4. Adding GS to a Unit

Last, but not least, units have the possibility to undergo gamescript effects in their own unique way. While there are two main routes one can take, we shall start off with general unit GS.

Open the folder `scripts` inside `objects`, if you have not already. Since unit objects do not by default possess any related GS files, we will manually have to add one ourselves again, as with weapons.

Create this file:

```text
human_nomad.gs
```

Open your newly added GS file. Units do not have entry points like `impact` or `use`, but they do have some other useful options. Add the following code:

```text
@wounded
!givestate self magshield 3000
!push target 0 0 1000
```

You have seen `target` used with `@impact` on melee and weapons before. In this case, `target` refers to the unit or building that attacked.

Can you guess what this simple piece of code does?

> **Spoiler:** This script will grant a nomad that is wounded, injured, or attacked a magnetic shield buff for 3 seconds and hurl the attacker into the sky.

Start Savage, join the human team, select nomad — which is already selected by default — and spawn. Find something or someone with a personal interest in hurting you. Witness what happens when something attacks you.

> **Note:** Try `@die` and `@levelup` for more unique entries.

## 5. NPC Behavior via GS

While default Savage has almost no AI/NPC behavior, GS now offers a basic option to implement NPCs that actually show a form of AI.

As usual, open the folder `scripts` inside `objects`. NPCs are units, so you will not find any default GS for NPCs here.

Create this file:

```text
npc_monkit.gs
```

We shall now use some new entry points: `@idling` and `@chasing`. Add the following code:

```text
@idling
!search self 500 unit neutral enemy 1st
!if found [gs_object_id>=0] @then

@then
!exec self "cvarcopy gs_object_id npc_id"
!goal found ##npc_id# object #gs_object_posx# #gs_object_posy#

@chasing
!givestate self adrenaline 1000
```

> **Warning:** The explanation below is complex. You may want to skip it and simply try it in-game first.

AI is fairly complex, so here is what is happening:

- `@idling` occurs when the object, in this case the monkit, has nothing to do and is idling or standing around.
- `@chasing` occurs when this unit is following or attacking a target.
- When the monkit is standing around without a task, it uses `!search` to determine if the given flags are met.
- In this case, within a `500` area radius, we are looking for units that are neutral or enemy.
- `1st` refers to the closest unit found. Alternatively, `2nd`, `3rd`, and `4th` are valid flags.
- If these flags are met, meaning a valid target is found, the target is used inside the `found` variable.
- The next line makes sure that this `found` target really exists by checking whether `gs_object_id` is greater than `-1`.
- If `found` exists, then the entry point `@then0` is called.
- Inside `@then0`, we copy the cvar `gs_object_id`, which is the ID of `self`, the monkit itself, and paste it into the cvar `npc_id`.
- Then we use the function `!goal` to grant the monkit, `npc_id`, the target `found` as a target to follow or attack via `_posx` and `_posy`.
- `@chasing` is more obvious: while chasing a target, the monkit receives an adrenaline buff.

After attempting to digest this complex work of art, start Savage and see what happens. Join either team, as either unit, and approach a monkit. Repeat this until you understand what is happening.

> **Note:** Try `@walking` for another unique entry. Just keep in mind that `@walking` does not occur when `@chasing` takes effect.

## 6. GS Cvars

Apart from GS functions such as `!damage`, `!givestate`, and `!search`, you also have the option to use `gs_object_*` cvars for your purposes. You can use them to create new cvars, check cvars, or affect functions.

It is important to remember that whatever target you put right after the GS function will be the target for the `gs_object_*` cvars.

For example, if the function states `owner`, the owner's cvars are used. If we used `target`, it would be the `@impact` target that was hit, or the `@wounded` target that hit, and so on.

### Anything

```text
@spawn
!exec owner "createvar myFirstCvar #gs_object_id#"
```

`!exec` is a function that allows you to use normal non-GS scripts, such as GUI, binds, and server scripts.

In this case, we are creating the cvar `myFirstCvar` and putting the value of `gs_object_id` into it. Notice the `#` symbols: they enclose the cvar so that the value of it is used instead of the literal name.

Without the `#` symbols, `myFirstCvar` would not be the ID. Instead, it would be the string `gs_object_id`.

### Weapon

```text
@impact
!push target #gs_object_dirx# #gs_object_dirxy# 0
```

In this case, `gs_object_*` refers to the `target`. Since this is `@impact` on a weapon, it refers to the object that was hit.

`*_dirx`, `*_diry`, and `*_dirz` combined are the vector that indicates the direction the object is facing or looking at. As such, the target will be pushed forward, such as being kicked from behind.

> **Note:** `*_dir` values are fairly small, so you may have to multiply them with a value first to have a proper effect.

### Unit

```text
@wounded
!exec target "chat I was hit by a #gs_object_name# who's name is #gs_object_nick#!"
!exec self "chat After my newest injury, my health is #gs_object_health#!"
```

When this unit is wounded, the object's client will talk in chat:

1. It will tell you what object type damaged you, and then who it was by nickname. Objects not related to clients, like NPCs, do not have nicknames.
2. It will tell you what your current health is at.

### Anywhere

```text
!if target [gs_object_team==0] @then

@then
!givestate target adrenaline 1000
```

If the given `target` belongs to team `0`, it receives an adrenaline buff/state for 1 second.

The list of available GS cvars for objects goes on and on, just as their uses. With a little bit of experience, creativity, and patience, one can accomplish a complex variety of things in GS.

This concludes the modding tutorial by leaving a somewhat efficient remaining impression of how things work in Savage/Silverback.
