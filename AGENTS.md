# Repository Instructions

## Client-Side Mod Layout

Treat `Clientside/` as the baseline client asset library. Do not edit files in `Clientside/` for client-side mod work unless the user explicitly asks to change the shared baseline assets.

Client-side mods must live under `clientside-mods/`. Each mod gets its own child folder named with the target client archive load order and a short mod name, for example:

```text
clientside-mods/
  savage001-rebalance/
    gui/standard/ui_tithe.cfg
    gui/standard/frame_event.cfg
  savage010-summoner-arc/
    gui/standard/ui_game.cfg
    script/summoner_arc/objects/beast_summoner.object
```

When modifying a client asset for a mod:

1. Copy the source file from `Clientside/` into the appropriate `clientside-mods/<savageXXX-mod-name>/` child folder.
2. Preserve the path relative to `Clientside/`; the child folder contents should mirror the folder structure that will be placed at the root of `savageXXX.s2z`.
3. Modify only the copied file under `clientside-mods/`.
4. Keep separate mods in separate child folders so their package contents and load order remain explicit.

Build scripts for client-side mod packages should stage files from `clientside-mods/<savageXXX-mod-name>/` and write the archive as `savageXXX.s2z`, where `XXX` is the client load-order number represented by the mod folder name.

## Server-Side Mod Layout

Treat `game/` as the baseline server asset library. Do not edit files under `game/`, including `game/config/`, for server-side mod work unless the user explicitly asks to change the shared baseline server.

Server-side mods must live under `serverside-mods/`. Each mod gets its own child folder named after the server archive or feature it owns. The child folder contents should mirror paths relative to the `game/` root:

```text
serverside-mods/
  rebalance/
    mods/master/rebalance.cfg
    config/maps_lookup.cfg
    python/triggers/sv_rebalance_building_hp.py
  summoner_arc/
    mods/master/summoner_arc.cfg
    script/summoner_arc/XR.objlist
    script/summoner_arc/objects/beast_summoner.object
```

When modifying a server asset for a mod:

1. Copy the source file from `game/` into the appropriate `serverside-mods/<mod-name>/` child folder.
2. Preserve the path relative to `game/`; the child folder contents should either mirror the root of the server archive `.s2z` or the overlay path that a build/deploy script will copy into `game/`.
3. Modify only the copied file under `serverside-mods/`.
4. Keep separate server mods in separate child folders so their package contents, config changes, and load requirements remain explicit.

Avoid piling feature-specific settings into shared config files such as `game/config/default.cfg` or `game/config/maps_lookup.cfg`. If a mod needs config changes, place the changed config file under that mod's `serverside-mods/<mod-name>/config/` folder and have build or deployment scripts compose the selected mod overlays. If two mods need to edit the same config file, prefer a profile-specific composed config under `serverside-mods/<profile-name>/config/` instead of silently merging unrelated features into the baseline.

Build scripts for server-side mod packages should stage files from `serverside-mods/<mod-name>/` and write mod archives such as `<mod-name>.s2z`. Scripts that prepare a runnable server should explicitly copy or overlay the selected `serverside-mods/` folders into the final `game/` tree, rather than using `game/` itself as the working area for mod edits.
