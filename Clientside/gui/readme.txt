<<< Silverback XR Unified Game Script System >>>
	   >  Mohican / XR Dev Team / 2008  <

The folder /gui/standard/ contains all GUI widgets required to run Savage in RTSS mode.

The silverback engine calls the files: 
  ui_main.cfg -> to build the main menu widgets
  ui_game.cfg -> to build the in-game widgets

When a game conversion is loaded, the engine will try to load these files from the subfolder
name specified in "sv_map_objpath" (see: server_maps_lookup.cfg). 
Example: /gui/samurai/ --> if "sv_map_objpath" value is "samurai/"
If the file is not available from this folder, the standard file will be loaded instead.

The same principle applies to all "status" files (executed automatically, for instance when entering lobby)
The list of status files:
  ui_status_buddy_msg.cfg
  ui_status_commander.cfg
  ui_status_endgame.cfg
  ui_status_game_setup.cfg
  ui_status_ingame_menu.cfg
  ui_status_lobby.cfg
  ui_status_main_menu.cfg
  ui_status_player.cfg
  ui_status_spawnpoint_select.cfg
  ui_status_spectate.cfg
  ui_status_team_select.cfg
  ui_status_unit_select.cfg
  
Note: For an example of partial GUI conversion, look in the folder /gui/samurai/
