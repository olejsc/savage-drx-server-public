import ctypes
import os

import core
import server

import sv_defs


CVARS = {
    'enabled': 'sv_rebalanceBuildingHp',
}

HUMAN_BASES = ('human_stronghold', 'human_stronghold2', 'human_stronghold3')
BEAST_BASES = ('beast_lair', 'beast_lair2', 'beast_lair3')
LEVEL_FRACTIONS = {
    1: (1, 3),
    2: (2, 3),
    3: (1, 1),
}

EXCLUDED_OBJECTS = set([
    'human_arrow_tower',
    'human_chemical_tower',
    'human_electric_tower',
    'human_magnetic_tower',
    'human_cannon_tower',
    'human_shield_tower',
    'beast_fire_ward',
    'beast_lightning_spire',
    'beast_spire',
    'beast_fire_spire',
    'beast_strata_spire',
    'beast_entropy_spire',
])

OBJECT_LIST_PATHS = (
    'game/script/standard/XR.objlist',
    'script/standard/XR.objlist',
)
OBJECT_PATH_PATTERNS = (
    'game/script/standard/objects/%s.object',
    'script/standard/objects/%s.object',
)

# Runtime addresses are relative to bin/game64.so. They were identified from the
# dedicated server binary because the script API exposes health, but not max health.
GAME64_OBJECTS_PTR_OFFSET = 0x16c160
SERVER_OBJECT_STRIDE = 0x0f88
SERVER_OBJECT_HEALTH_OFFSET = 0x014c
SERVER_OBJECT_FULL_HEALTH_OFFSET = 0x0150
SERVER_OBJECT_MAX_HEALTH_OFFSET = 0x0758

LOG_PREFIX = '[rebalance_hp] '


class _Context:
    initialized = False
    definition_names = []
    original_full_health = {}
    object_race = {}
    race_level = {}
    race_applied_level = {}
    tracked_max_health = {}
    last_enabled = None
    last_check_time = 0
    memory_warned = False


class _Memory:
    attempted = False
    base = None
    object_array = None


def _log(message):
    try:
        core.ConsolePrint(LOG_PREFIX + message + '\n')
    except:
        pass


def _is_enabled():
    try:
        return bool(int(core.Cvar_Get(CVARS['enabled'])))
    except:
        return False


def _scaled_full_health(full_health, level):
    numerator, denominator = LEVEL_FRACTIONS.get(level, LEVEL_FRACTIONS[3])
    return max(1, int(round(float(full_health) * float(numerator) / float(denominator))))


def _object_setting(object_name, setting_name):
    setting_name = setting_name.lower()

    for path_pattern in OBJECT_PATH_PATTERNS:
        path = path_pattern % object_name
        try:
            object_file = open(path, 'r')
        except:
            continue

        try:
            for line in object_file:
                line = line.split('//', 1)[0].strip()
                if not line:
                    continue

                parts = line.split(None, 2)
                if len(parts) < 3:
                    continue
                if parts[0].lower() != 'objset':
                    continue
                if parts[1].lower() != setting_name:
                    continue

                return parts[2].strip().strip('"')
        finally:
            try:
                object_file.close()
            except:
                pass

    return ''


def _object_full_health(object_name):
    try:
        value = _object_setting(object_name, 'fullHealth')
        return int(float(value))
    except:
        return 0


def _set_object_full_health(object_name, full_health):
    try:
        core.CommandExec('objedit %s; objSet fullHealth %d' % (object_name, full_health))
    except:
        pass


def _initialize():
    if _Context.initialized:
        return

    _Context.initialized = True
    _Context.object_race = {}
    _Context.original_full_health = {}
    _Context.definition_names = _load_object_definition_names()

    for object_name in _Context.definition_names:
        if not object_name:
            continue
        if not _object_is_scaled_building_name(object_name):
            continue

        full_health = _object_full_health(object_name)
        if full_health <= 0:
            continue

        race = _race_for_object_name(object_name)
        if race is None:
            continue

        _Context.original_full_health[object_name] = full_health
        _Context.object_race[object_name] = race

    _Context.race_level = {
        'human': 1,
        'beast': 1,
    }
    _Context.race_applied_level = {}
    _Context.tracked_max_health = {}

    _log('initialized with %d scaled building types' % len(_Context.original_full_health))


def _load_object_definition_names():
    for path in OBJECT_LIST_PATHS:
        try:
            objlist = open(path, 'r')
        except:
            continue

        names = []
        try:
            for line in objlist:
                line = line.split('//', 1)[0].strip()
                if not line.startswith('objload '):
                    continue

                parts = line.split()
                if len(parts) < 2:
                    continue

                names.append(parts[1].strip().strip('"'))
        finally:
            try:
                objlist.close()
            except:
                pass

        if names:
            return names

    names = []
    for object_name in sv_defs.objectList_Name:
        if object_name and object_name not in names:
            names.append(object_name)

    return names


def _object_is_scaled_building_name(object_name):
    if object_name in EXCLUDED_OBJECTS:
        return False
    if object_name in HUMAN_BASES or object_name in BEAST_BASES:
        return False
    if _object_setting(object_name, 'objclass') != 'building':
        return False
    if not _object_setting(object_name, 'builder1') and not _object_setting(object_name, 'builder2'):
        return False
    return _race_for_object_name(object_name) in ('human', 'beast')


def _race_for_object_name(object_name):
    race = _object_setting(object_name, 'race')
    if race in ('human', 'beast'):
        return race

    if object_name.startswith('human_'):
        return 'human'
    if object_name.startswith('beast_'):
        return 'beast'
    return None


def _find_game64_base_from_proc_maps():
    maps_path = '/proc/self/maps'
    if not os.path.exists(maps_path):
        return None

    try:
        maps_file = open(maps_path, 'r')
    except:
        return None

    try:
        for line in maps_file:
            if 'game64.so' not in line:
                continue

            fields = line.split()
            if len(fields) < 3:
                continue

            address_range = fields[0].split('-')
            if len(address_range) != 2:
                continue

            start = int(address_range[0], 16)
            offset = int(fields[2], 16)
            return start - offset
    except:
        return None
    finally:
        try:
            maps_file.close()
        except:
            pass

    return None


def _find_game64_base_from_exported_symbol():
    try:
        handle = ctypes.CDLL(None)
        function = getattr(handle, '_Z18SV_FillInBaseStatsP14serverObject_s')
        address = ctypes.cast(function, ctypes.c_void_p).value
        if address:
            return address - 0x0f5cc0
    except:
        pass

    return None


def _ensure_memory_access():
    if _Memory.object_array:
        return True

    if _Memory.attempted:
        return False

    _Memory.attempted = True
    _Memory.base = _find_game64_base_from_proc_maps()
    if _Memory.base is None:
        _Memory.base = _find_game64_base_from_exported_symbol()

    if _Memory.base is None:
        _warn_memory_unavailable('could not locate game64.so in process memory')
        return False

    try:
        pointer_address = _Memory.base + GAME64_OBJECTS_PTR_OFFSET
        _Memory.object_array = ctypes.c_void_p.from_address(pointer_address).value
    except:
        _Memory.object_array = None

    if not _Memory.object_array:
        _warn_memory_unavailable('could not resolve server object array')
        return False

    _log('live server-object max-health access enabled')
    return True


def _warn_memory_unavailable(reason):
    if _Context.memory_warned:
        return

    _Context.memory_warned = True
    _log('warning: %s; existing buildings cannot be auto-rescaled' % reason)


def _server_object_address(index):
    if index < 0:
        return None
    if not _ensure_memory_access():
        return None

    return _Memory.object_array + (index * SERVER_OBJECT_STRIDE)


def _read_live_int(index, offset, default_value):
    address = _server_object_address(index)
    if address is None:
        return default_value

    try:
        return int(ctypes.c_int.from_address(address + offset).value)
    except:
        return default_value


def _write_live_int(index, offset, value):
    address = _server_object_address(index)
    if address is None:
        return False

    try:
        ctypes.c_int.from_address(address + offset).value = int(value)
        return True
    except:
        return False


def _live_max_health(index, fallback_value):
    return _read_live_int(index, SERVER_OBJECT_MAX_HEALTH_OFFSET, fallback_value)


def _set_live_max_health(index, max_health):
    wrote_full = _write_live_int(index, SERVER_OBJECT_FULL_HEALTH_OFFSET, max_health)
    wrote_max = _write_live_int(index, SERVER_OBJECT_MAX_HEALTH_OFFSET, max_health)

    if wrote_full or wrote_max:
        try:
            sv_defs.objectList_MaxHealth[index] = max_health
        except:
            pass
        return True

    return False


def _base_level_for_team(team):
    level = 1
    try:
        for base_name, base_level in (
            ('human_stronghold3', 3),
            ('human_stronghold2', 2),
            ('human_stronghold', 1),
            ('beast_lair3', 3),
            ('beast_lair2', 2),
            ('beast_lair', 1),
        ):
            if server.GetNumBuildingType(team, base_name) > 0:
                level = max(level, base_level)
    except:
        pass

    return level


def _update_race_levels():
    human_level = 1
    beast_level = 1

    for team in range(1, len(sv_defs.teamList_RaceName)):
        race = sv_defs.teamList_RaceName[team]
        if not race:
            continue

        level = _base_level_for_team(team)
        if race == 'human':
            human_level = max(human_level, level)
        elif race == 'beast':
            beast_level = max(beast_level, level)

    _Context.race_level['human'] = human_level
    _Context.race_level['beast'] = beast_level


def _collect_scaled_buildings(race):
    buildings = []

    for index in range(MAX_CLIENTS, len(sv_defs.objectList_Type)):
        if not sv_defs.objectList_Active[index]:
            continue

        object_type = int(sv_defs.objectList_Type[index])
        if object_type < OBJTYPE_BASE or object_type > OBJTYPE_BUILDING:
            continue

        object_name = sv_defs.objectList_Name[index]
        if _Context.object_race.get(object_name) != race:
            continue

        max_health = int(sv_defs.objectList_MaxHealth[index])
        max_health = _live_max_health(index, max_health)

        buildings.append({
            'index': index,
            'type': object_type,
            'name': object_name,
            'health': int(sv_defs.objectList_Health[index]),
            'max_health': max_health,
            'construct': int(sv_defs.objectList_Construct[index]),
        })

    return buildings


def _target_instance_health(instance, target_max_health):
    current_health = max(0, int(instance['health']))
    current_max_health = max(1, int(instance['max_health']))

    if instance['construct'] > 0:
        return min(current_health, target_max_health)

    previous_max_health = _Context.tracked_max_health.get(instance['index'], current_max_health)
    previous_max_health = max(1, int(previous_max_health))

    health_fraction = float(current_health) / float(previous_max_health)
    return max(0, min(target_max_health, int(round(float(target_max_health) * health_fraction))))


def _set_instance_health(index, current_health, target_health):
    current_health = int(current_health)
    target_health = int(target_health)

    if target_health == current_health:
        return

    delta = abs(target_health - current_health)
    if delta <= 0:
        return

    if target_health > current_health:
        try:
            server.GameScript(index, '!heal target %d' % delta)
        except:
            pass
    else:
        try:
            server.GameScript(index, '!damage target %d 1' % delta)
        except:
            pass


def _apply_instance_max_and_health(instance, target_max_health):
    index = instance['index']
    current_health = int(instance['health'])
    target_health = _target_instance_health(instance, target_max_health)

    if target_health < current_health:
        _set_instance_health(index, current_health, target_health)
        _set_live_max_health(index, target_max_health)
    else:
        _set_live_max_health(index, target_max_health)
        _set_instance_health(index, current_health, target_health)

    _Context.tracked_max_health[index] = target_max_health


def _race_needs_apply(race):
    level = _Context.race_level.get(race, 1)
    if _Context.race_applied_level.get(race) != level:
        return True

    for instance in _collect_scaled_buildings(race):
        original_full_health = _Context.original_full_health.get(instance['name'])
        if not original_full_health:
            continue

        target_max_health = _scaled_full_health(original_full_health, level)
        if int(instance['max_health']) != target_max_health:
            return True

    return False


def _apply_race_level(race, force=False):
    level = _Context.race_level.get(race, 1)
    if not force and not _race_needs_apply(race):
        return

    for object_name, original_full_health in _Context.original_full_health.items():
        if _Context.object_race.get(object_name) != race:
            continue

        _set_object_full_health(object_name, _scaled_full_health(original_full_health, level))

    for instance in _collect_scaled_buildings(race):
        original_full_health = _Context.original_full_health.get(instance['name'])
        if not original_full_health:
            continue

        target_max_health = _scaled_full_health(original_full_health, level)
        _apply_instance_max_and_health(instance, target_max_health)

    _Context.race_applied_level[race] = level


def _restore_vanilla_full_health():
    for race in ('human', 'beast'):
        for instance in _collect_scaled_buildings(race):
            original_full_health = _Context.original_full_health.get(instance['name'])
            if not original_full_health:
                continue

            current_health = int(instance['health'])
            target_health = min(current_health, original_full_health)

            if target_health < current_health:
                _set_instance_health(instance['index'], current_health, target_health)

            _set_live_max_health(instance['index'], original_full_health)

    for object_name, original_full_health in _Context.original_full_health.items():
        _set_object_full_health(object_name, original_full_health)

    _Context.race_applied_level = {}
    _Context.tracked_max_health = {}


def on_building_construct(uid, building_type):
    _initialize()
    if not _is_enabled():
        return

    object_name = _event_object_name(uid, building_type)
    race = _Context.object_race.get(object_name)
    if race is None:
        _update_race_levels()
        _apply_race_level('human', force=True)
        _apply_race_level('beast', force=True)
        return

    _update_race_levels()
    level = _Context.race_level.get(race, 1)
    original_full_health = _Context.original_full_health.get(object_name)
    if not original_full_health:
        return

    _set_object_full_health(object_name, _scaled_full_health(original_full_health, level))
    _apply_race_level(race, force=True)


def _event_object_name(uid, object_reference):
    try:
        uid = int(uid)
        if 0 <= uid < len(sv_defs.objectList_Name):
            object_name = sv_defs.objectList_Name[uid]
            if object_name:
                return object_name
    except:
        pass

    if isinstance(object_reference, str):
        return object_reference

    try:
        object_index = int(object_reference)
    except:
        return ''

    if 0 <= object_index < len(_Context.definition_names):
        return _Context.definition_names[object_index]
    if 1 <= object_index <= len(_Context.definition_names):
        return _Context.definition_names[object_index - 1]

    return ''


def on_building_research_complete(uid, research_type):
    _initialize()
    if not _is_enabled():
        return

    research_name = _event_object_name(uid, research_type)
    if research_name not in HUMAN_BASES and research_name not in BEAST_BASES:
        _update_race_levels()
        _apply_race_level('human', force=True)
        _apply_race_level('beast', force=True)
        return

    _update_race_levels()
    if research_name in HUMAN_BASES:
        _apply_race_level('human', force=True)
    else:
        _apply_race_level('beast', force=True)


def execute():
    _initialize()

    enabled = _is_enabled()
    if _Context.last_enabled is None:
        _Context.last_enabled = enabled
    elif _Context.last_enabled != enabled:
        _Context.last_enabled = enabled
        if not enabled:
            _restore_vanilla_full_health()

    if not enabled:
        return

    try:
        current_time = int(server.GetGameInfo(GAME_TIME))
    except:
        current_time = 0
    if current_time - _Context.last_check_time < 1000:
        return

    _Context.last_check_time = current_time
    _update_race_levels()

    _apply_race_level('human')
    _apply_race_level('beast')
