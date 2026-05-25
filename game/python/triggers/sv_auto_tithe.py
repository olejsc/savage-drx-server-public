# ---------------------------------------------------------------------------
#           Name: sv_auto_tithe.py
#    Description: Automatically adjusts team tithe from team gold.
# ---------------------------------------------------------------------------

import core
import server

import sh_custom_utils
import sv_defs


CVARS = {
    'enabled': 'sv_autoTithe',
    'interval_ms': 'sv_autoTitheIntervalMs',
    'engine_tithe_enabled': 'sv_enableTithe',
}

DEFAULT_TITHE = 30
GOLD_RESOURCE_INDEX = 2
MAX_TITHE_TEAM = 8
DEFAULT_INTERVAL_MS = 1000
ACTIVE_GAME_STATE = 3
LOG_PREFIX = '[auto_tithe] '


class _Context:
    last_check_time = None
    last_tax_by_team = {}
    managed_teams = set()


def _log(message):
    try:
        core.ConsolePrint(LOG_PREFIX + message + '\n')
    except:
        pass


def _cvar_int(name, default=0):
    try:
        return int(float(core.CvarGetValue(name)))
    except:
        return default


def _cvar_bool(name):
    return _cvar_int(name, 0) != 0


def _interval_ms():
    interval = _cvar_int(CVARS['interval_ms'], DEFAULT_INTERVAL_MS)
    if interval <= 0:
        return DEFAULT_INTERVAL_MS
    return interval


def _game_time():
    try:
        return int(server.GetGameInfo(GAME_TIME))
    except:
        return 0


def _is_active_game():
    try:
        return int(server.GetGameInfo(GAME_STATE)) == ACTIVE_GAME_STATE
    except:
        return False


def _teams_to_manage():
    try:
        team_last = int(sv_defs.teamList_Last)
    except:
        team_last = _cvar_int('sv_numTeams', 0)

    team_last = min(max(team_last, 0), MAX_TITHE_TEAM)
    if team_last < 1:
        return []

    return list(range(1, team_last + 1))


def _active_client_index():
    try:
        client_count = min(len(sv_defs.clientList_Active), MAX_CLIENTS)
    except:
        client_count = 128

    for index in range(0, client_count):
        try:
            if sv_defs.clientList_Active[index]:
                return index
        except:
            pass

    return None


def _refresh_gamescript_cvars():
    client_index = _active_client_index()
    if client_index is None:
        return

    try:
        server.GameScript(client_index, '!test target character')
    except:
        pass


def _team_gold(team):
    return _cvar_int('gs_team%d_resource%d' % (team, GOLD_RESOURCE_INDEX), 0)


def _tax_for_gold(gold):
    if gold >= 40000:
        return 15
    if gold >= 20000:
        return 30
    if gold >= 10000:
        return 40
    if gold >= 4500:
        return 50
    return 70


def _tithe_cvar(team):
    return 'sv_tithe_team%d' % team


def _current_tithe(team):
    return _cvar_int(_tithe_cvar(team), DEFAULT_TITHE)


def _set_tithe(team, tax):
    try:
        core.CvarSetValue(_tithe_cvar(team), tax)
        return True
    except:
        return False


def _apply_team_tithe(team):
    gold = _team_gold(team)
    target_tax = _tax_for_gold(gold)
    current_tax = _current_tithe(team)

    if _Context.last_tax_by_team.get(team) == target_tax and current_tax == target_tax:
        return

    if _set_tithe(team, target_tax):
        _Context.last_tax_by_team[team] = target_tax
        _Context.managed_teams.add(team)
        _log('team %d gold=%d tax=%d%%' % (team, gold, target_tax))


def _restore_default_tithes():
    teams = set(_Context.managed_teams)

    for team in sorted(teams):
        if team < 1 or team > MAX_TITHE_TEAM:
            continue
        if _current_tithe(team) == DEFAULT_TITHE:
            continue
        if _set_tithe(team, DEFAULT_TITHE):
            _log('team %d tax reset to %d%%' % (team, DEFAULT_TITHE))

    _Context.last_tax_by_team = {}
    _Context.managed_teams = set()


def _should_run_now():
    current_time = _game_time()
    if _Context.last_check_time is None:
        return True
    if current_time < _Context.last_check_time:
        return True
    return current_time - _Context.last_check_time >= _interval_ms()


def check():
    try:
        return 1 if _should_run_now() else 0
    except:
        sh_custom_utils.get_and_log_exception_info()
        return 0


def execute():
    try:
        _Context.last_check_time = _game_time()

        if not _cvar_bool(CVARS['enabled']) or not _cvar_bool(CVARS['engine_tithe_enabled']) or not _is_active_game():
            _restore_default_tithes()
            return

        _refresh_gamescript_cvars()

        for team in _teams_to_manage():
            _apply_team_tithe(team)
    except:
        sh_custom_utils.get_and_log_exception_info()
