# XR Script Reference

## Introduction

This document covers the basics of Savage scripting.

The best way to learn Savage scripting is to inspect existing scripts from the game itself. The script system is responsible for many game settings and for much of the GUI shown in-game. Levels, items, units, and other game data are all defined through script files.

---

## Savage Script Basics

### Basic Commands and Symbols

| Command / Symbol | Description |
|---|---|
| `~` | Line-feed call. When the engine compiles the script, the next line is inserted at this point. This is useful for long `if` statements or multi-command lines. |
| `;` | Command termination symbol. Used to separate commands executed within quoted strings. |
| `\` | Escape character. Used to separate nested quotes, `#`, and `$` markers inside commands. |
| `createvar <varname> [optional value]` | Declares a variable for scripts. |
| `set <varname> <value>` | Sets a variable value. No equals sign is used. |
| `exec <path/scriptname>` | Executes another script from within the current script. Paths use forward slashes `/`, can move up with `../`, or start from root with `/`. |
| `@<mini-function name>` | Creates a label or mini-function target for `goto`. |
| `goto <mini-function name>` | Jumps to the mini-function label and skips anything between the `goto` and the matching `@<name>`. |
| `echo <variable>` | Prints a variable or string to the console. |
| `if <case> <action>` | Runs an action if a condition is true. Quotes are not required for a single action, but multiple actions must be quoted. |
| `#variable#` | Expands the value contained in a variable. |
| `$<variable>$` | Variable reference syntax used by the script engine. |
| `ask` | Asks the engine for information. The result is usually returned in the variable `answer`. |
| `do` | Executes the contents of a variable as though it were a command. |
| `inc <variable> <value>` | Increases a variable by the given value. |
| `toggle <variable>` | Toggles a boolean variable between `0` and `1`. |

### Line Feed Example

```cfg
if [test == 3] ~
show test;~
hide test2;
```

### Escaping Example

```cfg
if [test] goto new; echo \"test\"; show test_#object_\#num\##_obj;
```

### Variable Examples

```cfg
createvar TS_test2
set TS_test 2
```

---

## Conditional Operators

Conditional cases are similar to C-style operators.

| Operator | Meaning | Example |
|---|---|---|
| `==` | Equal to | `if [test == 3] goto done` |
| `!=` | Not equal to | `if [test != 4] goto done` |
| `<` | Less than | `if [test < 3] goto done` |
| `>` | Greater than | `if [test > 3] goto done` |
| `<=` | Less than or equal to | `if [test <= 3] goto done` |
| `>=` | Greater than or equal to | `if [test >= 3] goto done` |
| `\|\|` | OR | `if [test == 3 || test == 2] goto done` |
| `&` | AND | `if [test == 3 & test4 == 3] goto done` |
| `!` | NOT | `if [!test] goto done` |

Numerical cases require brackets:

```cfg
if [test] goto done
```

---

## Ask Queries

The `ask` command asks the engine a question and returns the result, usually as a boolean value in the `answer` variable.

Known query names include:

| Query |
|---|
| `stringsMatch` |
| `fileExists` |
| `currentDir` |
| `isResearched` |
| `isAvailable` |
| `isResearchable` |
| `isResearching` |
| `hasWeapon` |
| `ammo` |
| `maxAmmo` |
| `isInInventory` |
| `inventorySlot` |
| `whoIsCommander` |
| `playerState` |
| `stateIcon` |
| `buildItem` |
| `selection` |
| `objectType` |
| `isAlly` |
| `isOfficer` |
| `X` |

---

## Example: Chat-All Bind

The following is an example from Savage's scripts. It puts `Global->` in the text box when the chat-all key is pressed.

```cfg
bind #key_chatall# "select endgame_chat_box_panel:endgame_input_textbox; param commit_cmd \"chat #lobby_chat_msg#; select endgame_chat_box_panel:endgame_input_target_label; param text \\\"\\\"; set lobby_chat_msg \\\"\\\"\"; select endgame_chat_box_panel:endgame_input_target_label; param text \"Global->\"; textbox activate endgame_chat_box_panel:endgame_input_textbox"
```

### Breakdown

| Segment | Meaning |
|---|---|
| `bind #key_chatall#` | Calls the `bind` function. `#key_chatall#` expands to the key currently bound to chat-all. |
| `select endgame_chat_box_panel:endgame_input_textbox` | Selects the text box widget for modification. |
| `param commit_cmd ...` | Sets the command that runs when the text box is committed. |
| `chat #lobby_chat_msg#` | Sends the typed lobby chat message. |
| `select endgame_chat_box_panel:endgame_input_target_label` | Selects the target-label widget. |
| `param text \"Global->\"` | Sets the label text to `Global->`. |
| `textbox activate endgame_chat_box_panel:endgame_input_textbox` | Activates the text box so the user can type. |

Escaping is required because the command contains nested quoted strings. Multiple backslashes are used when the command is nested inside another quoted command.

---

## Quick Start

1. Create a file named `helloWorld.cfg` in the game folder.
2. Edit this file with a plain-text editor.
3. Add the following command:

```cfg
chat Hello World!
```

4. Run the game and host a new game.
5. Execute the script from the console:

```cfg
exec /helloWorld.cfg;
```

Or execute it from the chat box:

```cfg
/exec /helloWorld.cfg
```

You should see the result in chat.

---

## Comments

To comment code, or to disable code, use `#` as the first character on the line.

```cfg
# say hello to the world :)
#chat Hello World!
chat Hello World!
```

---

## Built-in Functions and Variables

The scripting system includes built-in functions and variables. This reference only covers a subset of them.

---

## Custom Variables

Variables can be one of these types:

- `Float`
- `Int`
- `String`

Use `set` to create or change a variable.

Variable names can contain alphanumeric characters, underscores, and hyphens. Be careful not to overwrite built-in variables.

### Integer Variable

```cfg
set myFavouriteNumber 13
chat My favourite number is #myFavouriteNumber#
```

### Float Variable

```cfg
set myFavouriteNumber 13.31
chat My favourite number is #myFavouriteNumber#
```

### String Variable

```cfg
set myFavouriteGame "Savage"
chat My favourite game is #myFavouriteGame#
```

Quotation marks are optional for simple string values, but they are useful for values containing spaces or special characters.

To display a variable value, wrap the variable name in `#` characters:

```cfg
#myFavouriteGame#
```

---

## Custom Functions

A custom function can be stored inside a variable. Use `do` to execute it.

```cfg
set myFunction "chat one; chat two; chat three;"
do myFunction
```

---

## Conditional Statements

Available operators:

```text
==, <=, >=, !=, &, |
```

### Basic Conditional Examples

```cfg
set firstNumber 10
if [firstNumber == 10] chat true; else chat false;
if [firstNumber <= 20] chat true; else chat false;
if [firstNumber != 20] chat true; else chat false;
```

### Combined Conditions

```cfg
set firstNumber 1
set secondNumber 0
if [firstNumber == 1 & secondNumber == 0] chat true; else chat false;
if [firstNumber == 0 | secondNumber == 0] chat true; else chat false;
```

Be careful with extra spaces. For example, this may display `false` because of the trailing space before the closing bracket:

```cfg
set firstNumber 1
set secondNumber 0
if [firstNumber == 1 & secondNumber == 0 ] chat true; else chat false;
```

---

## Loops

Use `for` to create a loop.

```cfg
for <variable> <start value> <end value> <increment> <command>;
```

Example:

```cfg
set fInLoop "chat ^y#vItem#. SPAM!"
createvar vItem
for vItem 1 5 1 #fInLoop#;
```

The loop variable must be created before the loop runs.

---

## Ask Function

`ask` is a special function that can return information about the player or game state.

```cfg
ask <query> <value> [value2]
```

Known query examples include:

- `ammo`
- `inventory`
- `stringsMatch`

To see the full list of query strings available in the engine, run `ask` without parameters.

The result of the function is saved in the variable:

```cfg
answer
```

### Inventory Example

This displays the player's weapon name. In this example, `1` is an inventory slot.

```cfg
ask inventory 1;
chat #answer#;
```

### `stringsMatch` Example

```cfg
ask inventory 1;
# stringsMatch query requires 2 parameters
ask stringsMatch #answer# human_crossbow;
if [answer == 1] chat Behold! I have xbow now!
```

---

## Binds

Binds assign commands or events to keys.

To get the names of special keys, run:

```cfg
listkeys
```

### Bind Example

```cfg
bind x "ask inventory 1; ask stringsMatch #answer# human_crossbow;
 if [answer == 1] chat Behold! I have xbow now!;"
```

---

## Source

Retrieved from:

```text
http://www.newerth.com/wiki/index.php/XR_Script_Reference
```
