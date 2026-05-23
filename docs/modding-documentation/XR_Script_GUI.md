# XR Script GUI

This document is a cleaned Markdown reference for Savage XR GUI scripting commands, widget modifiers, widget creation commands, and the XR widget frame helper script.

## Basic GUI Commands

| Command | Description |
|---|---|
| `create <widgettype>` | Creates a widget. |
| `hide <panel>:<object>` | Hides a widget. |
| `show <panel>:<object>` | Shows a hidden widget. |
| `move <panel>:<object> x y` | Moves a widget. Use the new absolute values, not a relative difference. |
| `select <panel>:<object>` | Selects a widget for variable manipulation. |
| `fadein <object> [time]` | Fades a widget in, like the minimap toggler. |
| `fadeout <object> [time]` | Fades a widget out. |
| `focus <panel>:<object>` | Brings a widget to the front/focus. |
| `on <event> cmd` | Executes a command when the event occurs. |
| `resize <panel>:<object> w h` | Resizes a widget. Use the new absolute values, not a relative difference. |
| `hideall` | Hides all widgets. |
| `staticdepth <0\|1>` | Sets whether widgets can change layer positions in the GUI. |
| `destroy <widget>` | Destroys a widget. |
| `reloadgui` | Clears GUI buffer files and reloads the GUI by executing `ui_main` and `ui_game` files. |

### Events

The `on <event> cmd` command can use the following events:

```text
mousedown
mouseover
mouseup
mouseout
show
hide
move
```

## Modifier Commands

### `menu`

```text
menu <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all menu widgets currently loaded. |
| `add <panel:object> <name> <command>` | Adds an item to the menu. Each menu item can be linked to a command. |
| `remove <panel:object> <name>` | Removes an item from the menu list. |
| `select <panelname:object> <name>` | Selects an item from the list, imitating a click. |
| `clear <panel:object>` | Empties the menu list. |
| `param <param> <value>` | Alters parameters of the selected widget. |
| `itemizefiles <panel:object> <path> <wildcard> <command>` | Creates a list based on files in a folder. For example, `.cfg` parses files with that string in the filename. |
| `itemizedirs <panel:object> <path> <command>` | Creates a menu based on directories in a folder. |

### `floater`

```text
floater <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all floater widgets currently loaded. |
| `param <param> <value>` | Alters parameters of the selected widget. |

### `swatch`

```text
swatch <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all swatch widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `variables <panel:object> <r g b a>` | Sets the color variables used by the swatch. |

### `keygrab`

```text
keygrab <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all keygrab widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `activate <panel:object>` | Activates a keygrab. It takes focus and starts reading input. |
| `deactivate <panel:object>` | Deactivates a keygrab. It loses focus and stops reading input. |
| `abort <panel:object>` | Same as `deactivate`. |
| `commit <panel:object>` | Commits a keygrab. It loses focus, stops reading input, and executes `exec_cmd`. |

### `togglebutton`

```text
togglebutton <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all togglebutton widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `toggle <panel:object>` | Toggles the current value. |
| `up <panel:object>` | Executes the `up_command` parameter. |
| `down <panel:object>` | Executes the `command` parameter. |

### `o_scrollbuffer`

```text
o_scrollbuffer <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all ordered scrollbuffer widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `print <panel:object> <string>` | Adds the string to the buffer list. |
| `scroll <panel:object> <value>` | Scrolls up or down the list. Used for scroll bars. |

### `scrollbuffer`

```text
scrollbuffer <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all scrollbuffer widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `print <panel:object> <string>` | Adds the string to the buffer list. |
| `scroll <panel:object> <value>` | Scrolls up or down the list. Used for scroll bars. |

### `map`

```text
map <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all map widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |

### `playermap`

```text
playermap <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all playermap widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |

### `textbuffer`

```text
textbuffer <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all textbuffer widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `print <panel:object> <string>` | Adds the string to the buffer list. |

### `userlist`

```text
userlist <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all userlist widgets currently loaded. |

### `chatbox`

```text
chatbox <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all chatbox widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `say <panel:object> <name> <string>` | Prints the string in the chatbox. |

### `textbox`

```text
textbox <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all textbox widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `activate <panel:object>` | Activates a textbox. It takes focus and starts reading input. |
| `deactivate <panel:object>` | Deactivates a textbox. It loses focus and stops reading input. |
| `abort <panel:object>` | Same as `deactivate`. |
| `commit <panel:object>` | Commits a textbox. It loses focus, stops reading input, and executes `exec_cmd`. |

### `graphic`

```text
graphic <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all graphic widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |

### `label`

```text
label <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all label widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |

### `slider`

```text
slider <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all slider widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |
| `variable <variable>` | Sets the variable represented by the slider. |
| `range <min> <max>` | Sets the minimum and maximum range of the slider. |
| `direction <horizontal/vertical>` | Sets the slider direction. |

### `button`

```text
button <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all button widgets currently loaded. |
| `param <panel:object> <param> <value>` | Alters parameters of the selected widget. |

### `panel`

```text
panel <command> <args>
```

| Command | Description |
|---|---|
| `list` | Lists all panel widgets currently loaded. |
| `param <panel> <param> <value>` | Alters parameters of the selected panel. |
| `end <panel>` | Purpose unknown in the original reference. |
| `move <panel> <x> <y>` | Moves a panel to a new coordinate pair. |
| `show <panel>` | Shows a hidden panel. |
| `focus <panel>` | Brings a panel to the front/focus. |
| `hide <panel>` | Hides a panel. |
| `remove <panel>` | Destroys a panel. |
| `link <panel1> <panel2> <top/bottom/left/right>` | Snaps two panels together. |

## Creation Commands

### `thumbnailgrid`

```text
create thumbnailgrid name x y columns thumbnail_displaysize cvar_t cmd
```

Creates a thumbnail grid, possibly for commander-related UI.

### `floater`

```text
create floater name x y w h
```

Creates a handle that allows widgets to be moved dynamically with the mouse.

### `graphic`

```text
create graphic name x y w h
```

Creates a graphic. A graphic can be an image, such as TGA or PNG, or a movie. The original reference notes Blink/Theora support and mentions JPG support as pending.

```text
graphic param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `image <image>` | Changes the image. |
| `char_height <size>` | Changes the text size. |
| `textcolor <r> <g> <b>` | Changes the text color. |
| `color <r> <g> <b>` | Changes the color of the image. |
| `text <text>` | Sets text. |
| `animate <startframe> <endframe> <numloops> <freezeframe>` | Sets animation parameters. |
| `fps <float>` | Sets the frames per second of the animation. |

### `menu`

```text
create menu name x y w
```

Creates a pull-down menu.

```text
menu param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `bg_color <r> <g> <b>` | Sets the background color. |
| `text_color <r> <g> <b>` | Sets the text color. |
| `highlight_color <r> <g> <b>` | Sets the highlighted text color. |
| `char_height <height>` | Sets the font height in pixels. |
| `visible_items <items>` | Sets the maximum number of menu items visible at one time. |

### `swatch`

```text
create swatch name x y w h
```

Creates color slider widgets, such as those used in the editor.

```text
swatch param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `variables <var1> <var2> <var3> <var4>` | Sets the variables represented by the swatch. |

### `keygrab`

```text
create keygrab name x y width height [var]
```

Creates a text box that grabs a key, typically for key binding.

```text
keygrab param <panel:object> <param> <args>
```

| Parameter | Description |
|---|---|
| `commit_cmd` | Command to execute if Enter is pressed. |
| `abort_cmd` | Command to execute if Esc is pressed. |
| `char_height` | Text height. |
| `border` | Border size drawn around the widget. |
| `type` | Value type: `float`, `int`, or `string`. |

### `togglebutton`

```text
create togglebutton name x y w h
```

Creates a toggle checkbox-style button, such as those used in the options menu.

```text
togglebutton param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `command <command>` | Command to execute when the button is pressed. |
| `up_command <command>` | Command to execute when the button is released. |
| `down_image <image>` | Image used when the button is down/pressed. |
| `down_hover_image <image>` | Image used when the button is down and hovered. |
| `up_image <image>` | Image used when the button is up/normal. |
| `up_hover_image <image>` | Image used when the button is up and hovered. |
| `text <text>` | Text overlaid on the button. |
| `variable <varname>` | Cvar used to control the toggle state. |

### `o_scrollbuffer`

```text
create o_scrollbuffer name x y width height
```

Creates an ordered buffer to hold a list of strings, such as a server list.

```text
o_scrollbuffer param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `thickness` | Line thickness of the box. |
| `delay_secs` | Seconds before text fades. |
| `char_height` | Character/font height. |
| `icon_height` | Icon height. |
| `textcolor r g b` | Text color. |
| `selected_textcolor r g b` | Selected text color. |
| `selected_bgcolor r g b` | Background color of selected text. |
| `dropshadow` | Set to `1` to draw a drop shadow. |
| `dropshadowoffset` | Offset of the drop shadow. |
| `dropshadowcolor r g b` | Drop shadow color. |
| `rows` | Number of rows in the ordered scrollbuffer. |
| `linewrap` | Turns line wrapping on or off. |
| `variable` | Variable to set the value to. |
| `scrollvariable` | Variable used to determine scroll amount. |
| `rclick_cmd` | Command to run when someone right-clicks. |
| `sort_column` | Column to sort on. |
| `colpos <pos>` | Pixel position where column `<i>` starts. |
| `url` | URL to grab data from and put into the ordered scrollbuffer. |

### `scrollbuffer`

```text
create scrollbuffer name x y width height
```

Creates a scroll buffer to hold a list of strings.

```text
scrollbuffer param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `thickness` | Line thickness of the box. |
| `delay_secs` | Seconds before text fades. |
| `char_height` | Character/font height. |
| `icon_height` | Icon height. |
| `textcolor r g b` | Text color. |
| `selected_textcolor r g b` | Selected text color. |
| `selected_bgcolor r g b` | Background color of selected text. |
| `dropshadow` | Set to `1` to draw a drop shadow. |
| `dropshadowoffset` | Offset of the drop shadow. |
| `dropshadowcolor r g b` | Drop shadow color. |
| `rows` | Number of rows in the scrollbuffer. |
| `linewrap` | Turns line wrapping on or off. |
| `variable` | Variable to set the value to. |
| `scrollvariable` | Variable used to determine scroll amount. |
| `rclick_cmd` | Command to run when someone right-clicks. |
| `url` | URL to grab data from and put into the scrollbuffer. |

### `map`

```text
create map name x y w h
```

Creates a minimap.

```text
map param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `friend_image <image>` | Icon for friendly objects. |
| `friend_player_image <image>` | Icon for friendly players. |
| `friend_officer_image <image>` | Icon for friendly officers. |
| `friend_seige_image <image>` | Icon for friendly siege objects. |
| `enemy_image <image>` | Icon for enemy objects. |
| `enemy_seige_image <image>` | Icon for enemy siege objects. |
| `other_image <image>` | Icon for neutral objects. |
| `bg_cvar <cvar_name>` | Cvar specifying the background image. |

### `playermap`

```text
create playermap name x y w h
```

Creates a spawn map.

```text
playermap param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `friend_image <image>` | Icon for friendly objects. |
| `friend_player_image <image>` | Icon for friendly players. |
| `friend_seige_image <image>` | Icon for friendly siege weapons. |
| `friend_officer_image <image>` | Icon for friendly officers. |
| `enemy_image <image>` | Icon for enemy objects. |
| `enemy_seige_image <image>` | Icon for enemy siege weapons. |
| `enemy_officer_image <image>` | Icon for enemy officers. |
| `other_image <image>` | Icon for neutral objects. |
| `spawnpoint_image <image>` | Icon for a spawn point. |
| `commandcenter_image <image>` | Icon for the command center. |
| `waypoint_image <image>` | Icon for a waypoint. |
| `player_image <image>` | Icon for the player. |
| `underattack_image <image>` | Icon for a building under attack. |
| `buildingcomplete_image <image>` | Icon for completed building construction. |
| `bg_cvar <cvar_name>` | Cvar specifying the background image. |
| `spawnselect <1\|0>` | Enables or disables spawn selection. |

### `textbuffer`

```text
create textbuffer name x y width rows
```

Shows a text buffer. The original reference notes that this was `B` before a patch.

```text
textbuffer param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `team <number>` | Team to display users from. `-1` displays users from all teams. |
| `type <name\|ping\|score\|deaths>` | Changes whether names, pings, scores, or deaths are drawn. |
| `textcolor <r> <g> <b>` | Text color. |
| `selected_textcolor <r> <g> <b>` | Selected text color. |
| `gap <number>` | Gap between vertical text lines. |
| `interactive` | Allows players to be selected from the widget. |

> Note: the copied source listed this parameter block under `togglebutton`; it appears to describe `textbuffer`.

### `userlist`

```text
create userlist name x y width height
```

Creates a user list. The original reference notes that pressing Tab uses this.

```text
userlist param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `team <number>` | Team to display users from. `-1` displays users from all teams. |
| `type <name\|ping\|score\|deaths>` | Changes whether names, pings, scores, or deaths are drawn. |
| `textcolor <r> <g> <b>` | Text color. |
| `selected_textcolor <r> <g> <b>` | Selected text color. |
| `gap <number>` | Gap between vertical text lines. |
| `interactive` | Allows players to be selected from the widget. |

> Note: the copied source listed this parameter block under `togglebutton`; it appears to describe `userlist`.

### `chatbox`

```text
create chatbox name x y rows cols [thickness] [char_height]
```

Creates a chatbox.

```text
chatbox param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `thickness` | Line thickness of the chatbox. |
| `delay_secs` | Seconds before text fades. |
| `char_height` | Character/font height. |
| `rows` | Number of rows in the chatbox. |
| `width` | Width of the chatbox. |
| `type` | Chatbox type. |

### `textbox`

```text
create textbox name x y width size var [max_length textheight]
```

Creates a text input box, such as one used for chat input.

```text
textbox param <panel:object> <param> <args>
```

| Parameter | Description |
|---|---|
| `commit_cmd` | Command to execute if Enter is pressed. |
| `abort_cmd` | Command to execute if Esc is pressed. |
| `char_height` | Text height. |
| `border` | Border size drawn around the widget. |
| `dropshadow` | Set to `1` to draw a drop shadow. |
| `dropshadowoffset` | Drop shadow offset. |
| `dropshadowcolor r g b` | Drop shadow color. |
| `type` | Value type: `float`, `int`, or `string`. |
| `hidden` | Set to `1` to hide the contents. |

### `slider`

```text
create slider name x y width height
```

Creates a slider. It may be user-controllable or passive, such as an HP bar or options slider.

```text
slider param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `variable <name>` | Variable used to store the slider value. |
| `value <float>` | Sets the value of the slider. |
| `range <lo> <high>` | Sets the slider range. Values are floats. |
| `slider_color <r> <g> <b>` | Sets the slider color. |
| `bgshader <image>` | Sets the slider background shader. |
| `fillshader <image>` | Sets the slider fill shader. |
| `handleshader <image>` | Sets the slider handle shader. |
| `showvalue <false\|true>` | Turns drawing of the current value off or on. |
| `handlesize <int>` | Sets the slider handle size. |

### `button`

```text
create button name x y w h
```

Creates a button.

```text
button param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `command <command>` | Command to execute when the button is pressed. |
| `mouseover_command <command>` | Command to execute when the mouse enters the widget. |
| `mouseaway_command <command>` | Command to execute when the mouse exits the widget. |
| `down_image <image>` | Image used when the button is down/pressed. |
| `up_image <image>` | Image used when the button is up/normal. |
| `up_hover_image <image>` | Image used when the button is up and hovered. |
| `disable_image <image>` | Image used when the button is disabled. |
| `reset` | Clears all parameters. |
| `enable <true\|false>` | Enables or disables the button. Disabled buttons are unclickable. |
| `text <text>` | Text overlaid on the button. |
| `text_color <r> <g> <b>` | Color of overlaid text. |
| `alt <text>` | Alternate text shown when hovering over the button. |

### `label`

```text
create label name x y w h
```

Creates a text label.

```text
label param <panel:object> <param> <value>
```

| Parameter | Description |
|---|---|
| `char_height <height>` | Vertical font size. |
| `text <text>` | Label text. |
| `cvar <cvarname>` | Cvar used as the label. |
| `textcolor <r> <g> <b>` | Text color. |
| `align <left\|center\|right>` | Text alignment. |

### `panel`

```text
create panel name x y [pivot_x] [pivot_y]
```

Creates a panel. Panels hold widgets and can be used to form a complete UI object.

```text
panel param <panel> <param> <value>
```

| Parameter | Description |
|---|---|
| `char_height <height>` | Vertical font size. |
| `text <text>` | Text to use. |
| `cvar <cvarname>` | Cvar to use. |
| `textcolor <r> <g> <b>` | Text color. |
| `align <left\|center\|right>` | Text alignment. |

> Note: the copied source listed this parameter block under `label`; it appears to describe panel-related parameters or may be a duplicated label block.

## `ui_frame.cfg`: XR Widget Frame System

`ui_frame.cfg` is the XR widget frame system. The following cvars must be defined before calling:

```text
exec ui_frame.cfg
```

### Mandatory Cvars

| Cvar | Description |
|---|---|
| `_x` and `_y` | Top-left corner position of the frame. Placement is relative to the panel or widget being framed. |
| `_height` and `_width` | Total frame size. Frames are not distinct panels; they are `graphic` widgets under the current panel. |
| `_border` | Frame border width. Values of `4` or lower use corners the same size as the bars. Values above `4` make the corners slightly larger, so the bars appear to be shoved into the corners. |
| `_image` | Image set used for frame elements. See the supported image set values below. |

### `_image` Values

| Value | Description |
|---|---|
| `human` | Uses the default HUD frame images for humans. The code switches the source from `/human/frameleft.s2g` to `/beast/frameleft.s2g` when the player joins team 2, beasts. |
| `standard` | Uses the old metallic-looking frame with large corners, associated with the Savage 1 alpha-style frames. |
| `neutral` | Forces the game to keep human-looking frames, even if they are not one of the special kinds. Useful for windows shown before joining a team, such as menus. |
| `old` | Uses old orange-ish frames with old semi-transparent corners. |
| `oldthin` | Uses old 1px white stretched borders. |
| `thin` | Forces frame corners to match the width and height of the bars. |

### Special Cvars

| Cvar | Description |
|---|---|
| `_frame_alpha` | Sets the frame transparency level. |
| `_variation 1` | Marks the frame as part of the frame set that changes appearance according to the selected HUD interface: hi-res, minimal, smoke, or old. This is reset to `0` after each frame is drawn. |

## Source

Retrieved from:

```text
http://www.newerth.com/wiki/index.php/XR_Script_GUI
```
