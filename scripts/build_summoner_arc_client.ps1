[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = [System.IO.Path]::GetFullPath($RepoRoot)

function Join-RepoPath {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    return [System.IO.Path]::GetFullPath((Join-Path $RepoRoot $RelativePath))
}

function Assert-UnderRepo {
    param([Parameter(Mandatory = $true)][string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    $rootWithSep = $RepoRoot
    if (-not $rootWithSep.EndsWith([System.IO.Path]::DirectorySeparatorChar)) {
        $rootWithSep += [System.IO.Path]::DirectorySeparatorChar
    }

    if ($fullPath -ne $RepoRoot -and -not $fullPath.StartsWith($rootWithSep, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to operate outside repository root: $fullPath"
    }

    return $fullPath
}

function Remove-RepoPath {
    param([Parameter(Mandatory = $true)][string]$Path)

    $safePath = Assert-UnderRepo $Path
    if (Test-Path -LiteralPath $safePath) {
        Remove-Item -LiteralPath $safePath -Recurse -Force
    }
}

function Copy-DirectoryContents {
    param(
        [Parameter(Mandatory = $true)][string]$SourceDir,
        [Parameter(Mandatory = $true)][string]$DestinationDir
    )

    New-Item -ItemType Directory -Path $DestinationDir -Force | Out-Null

    Get-ChildItem -LiteralPath $SourceDir -Recurse -File | ForEach-Object {
        $relativePath = [System.IO.Path]::GetRelativePath($SourceDir, $_.FullName)
        $targetPath = Join-Path $DestinationDir $relativePath
        $targetDir = Split-Path -Parent $targetPath
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $targetPath -Force
    }
}

function Write-TextFile {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )

    $targetDir = Split-Path -Parent $Path
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Set-Content -LiteralPath $Path -Value $Content -Encoding utf8
}

function Copy-SummonerArcSources {
    param([Parameter(Mandatory = $true)][string]$DestinationRoot)

    $destinationConfig = Join-Path $DestinationRoot 'mods/master/summoner_arc.cfg'
    $destinationScriptDir = Join-Path $DestinationRoot 'script/summoner_arc'

    New-Item -ItemType Directory -Path (Split-Path -Parent $destinationConfig) -Force | Out-Null
    Copy-Item -LiteralPath $sourceConfig -Destination $destinationConfig -Force
    Copy-DirectoryContents -SourceDir $sourceScriptDir -DestinationDir $destinationScriptDir
}

function Set-ClientOnlyAimBounds {
    param([Parameter(Mandatory = $true)][string]$ObjectPath)

    $content = Get-Content -LiteralPath $ObjectPath -Raw
    $replacements = [ordered]@{
        '(?m)^objSet minAimX .*$' = 'objSet minAimX 0.000000'
        '(?m)^objSet maxAimX .*$' = 'objSet maxAimX 1.000000'
        '(?m)^objSet minAimY .*$' = 'objSet minAimY 0.000000'
        '(?m)^objSet maxAimY .*$' = 'objSet maxAimY 1.000000'
    }

    foreach ($pattern in $replacements.Keys) {
        $updated = [regex]::Replace($content, $pattern, $replacements[$pattern])
        if ($updated -eq $content) {
            throw "Could not apply client-only aim bound replacement '$pattern' in $ObjectPath"
        }
        $content = $updated
    }

    Set-Content -LiteralPath $ObjectPath -Value $content -NoNewline -Encoding utf8
}

function Write-SummonerArcClientGui {
    param([Parameter(Mandatory = $true)][string]$DestinationRoot)

    $uiGame = @'
set gui_basepath "/gui/standard"
set gui_convpath "/gui/standard"
reloadfont standard

// Execute Standard GUI
exec #gui_basepath#/ui_game_startup.cfg
exec #gui_basepath#/ui_presets.cfg
exec #gui_basepath#/gridmenus/hotkeys.cfg
exec #gui_basepath#/ui_spawnpoint_select_loadout.cfg
exec #gui_basepath#/ui_status_unit_select.cfg
exec #gui_basepath#/ui_status_lobby.cfg

hideall

exec /gui/summoner_arc/ui_aim_box.cfg
'@

    $aimBox = @'
set _summoner_arc_aim_left 0.330000
set _summoner_arc_aim_right 0.670000
set _summoner_arc_aim_top 0.280000
set _summoner_arc_aim_bottom 0.620000
set _summoner_arc_aim_width [gui_coordWidth * (_summoner_arc_aim_right - _summoner_arc_aim_left)]
set _summoner_arc_aim_height [gui_coordHeight * (_summoner_arc_aim_bottom - _summoner_arc_aim_top)]

create panel "summoner_arc_aim_box" [gui_coordWidth * _summoner_arc_aim_left] [gui_coordHeight * _summoner_arc_aim_top]

	create graphic top 0 0 [_summoner_arc_aim_width] 2
		param image /gui/standard/white.s2g
		param color .45 .8 1
		param alpha .72

	create graphic bottom 0 [_summoner_arc_aim_height - 2] [_summoner_arc_aim_width] 2
		param image /gui/standard/white.s2g
		param color .45 .8 1
		param alpha .72

	create graphic left 0 0 2 [_summoner_arc_aim_height]
		param image /gui/standard/white.s2g
		param color .45 .8 1
		param alpha .72

	create graphic right [_summoner_arc_aim_width - 2] 0 2 [_summoner_arc_aim_height]
		param image /gui/standard/white.s2g
		param color .45 .8 1
		param alpha .72

hide summoner_arc_aim_box

set _summoner_arc_mbutton_held 0
set _summoner_arc_pending_shot 0
set _summoner_arc_pending_firing 0
set _summoner_arc_is_summoner 0

set _summoner_arc_refresh_unit "ask stringsMatch #player_currentunit# beast_summoner; set _summoner_arc_is_summoner #answer#"
set _summoner_arc_default_lbutton_down "button1 1"
set _summoner_arc_default_lbutton_up "button1 0"
set _summoner_arc_default_rbutton_down "if [_block_switch] invswitch 0; button2 1"
set _summoner_arc_default_rbutton_up "button2 0"
set _summoner_arc_default_mbutton "toggle _zoomMode; if [_zoomMode] cl_fov 20; if [_zoomMode == 0] cl_fov 90"

set _summoner_arc_show_if_summoner "do _summoner_arc_refresh_unit; if [_summoner_arc_is_summoner] \"set _summoner_arc_mbutton_held 1; show summoner_arc_aim_box; focus summoner_arc_aim_box\"; if [!_summoner_arc_is_summoner] \"do _summoner_arc_default_mbutton\""
set _summoner_arc_mbutton_down "ask isCommander; set _summoner_arc_is_commander #answer#; if [_summoner_arc_is_commander] \"cl_cmdr_lockCameraToMouse 1\"; if [!_summoner_arc_is_commander] \"do _summoner_arc_show_if_summoner\""
set _summoner_arc_mbutton_up "set _summoner_arc_mbutton_held 0; hide summoner_arc_aim_box; ask isCommander; if [answer] \"cl_cmdr_lockCameraToMouse 0\""

set _summoner_arc_lbutton_down "do _summoner_arc_refresh_unit; if [_summoner_arc_is_summoner & _summoner_arc_mbutton_held] \"set _summoner_arc_pending_shot 1\"; if [!_summoner_arc_is_summoner | !_summoner_arc_mbutton_held] \"do _summoner_arc_default_lbutton_down\""
set _summoner_arc_lbutton_up "do _summoner_arc_default_lbutton_up"

set _summoner_arc_rbutton_down "do _summoner_arc_refresh_unit; set _summoner_arc_pending_firing 0; if [_summoner_arc_is_summoner & _summoner_arc_pending_shot & !_summoner_arc_mbutton_held] \"set _summoner_arc_pending_firing 1; button1 1\"; if [!_summoner_arc_is_summoner | !_summoner_arc_pending_shot | _summoner_arc_mbutton_held] \"do _summoner_arc_default_rbutton_down\""
set _summoner_arc_rbutton_up "if [_summoner_arc_pending_firing] \"button1 0; set _summoner_arc_pending_shot 0; set _summoner_arc_pending_firing 0\"; if [!_summoner_arc_pending_firing] \"do _summoner_arc_default_rbutton_up\""

bind lbutton "do _summoner_arc_lbutton_down"
bindup lbutton "do _summoner_arc_lbutton_up"
bind rbutton "do _summoner_arc_rbutton_down"
bindup rbutton "do _summoner_arc_rbutton_up"
bind mbutton "do _summoner_arc_mbutton_down"
bindup mbutton "do _summoner_arc_mbutton_up"
'@

    Write-TextFile -Path (Join-Path $DestinationRoot 'gui/standard/ui_game.cfg') -Content $uiGame
    Write-TextFile -Path (Join-Path $DestinationRoot 'gui/summoner_arc/ui_aim_box.cfg') -Content $aimBox
}

function Write-ZipFromDirectory {
    param(
        [Parameter(Mandatory = $true)][string]$SourceDir,
        [Parameter(Mandatory = $true)][string]$ArchivePath
    )

    Remove-RepoPath $ArchivePath
    [System.IO.Compression.ZipFile]::CreateFromDirectory(
        $SourceDir,
        $ArchivePath,
        [System.IO.Compression.CompressionLevel]::Optimal,
        $false
    )
}

$sourceConfig = Join-RepoPath 'game/mods/master/summoner_arc.cfg'
$sourceScriptDir = Join-RepoPath 'game/script/summoner_arc'
$clientRoot = Join-RepoPath 'Clientside'
$clientConfig = Join-Path $clientRoot 'mods/master/summoner_arc.cfg'
$clientScriptDir = Join-Path $clientRoot 'script/summoner_arc'
$clientGuiDir = Join-Path $clientRoot 'gui/summoner_arc'
$clientUiGame = Join-Path $clientRoot 'gui/standard/ui_game.cfg'
$distDir = Join-RepoPath 'dist'
$serverStageRoot = Join-RepoPath 'dist/.summoner_arc_server_package'
$clientStageRoot = Join-RepoPath 'dist/.summoner_arc_client_package'

if (-not (Test-Path -LiteralPath $sourceConfig -PathType Leaf)) {
    throw "Missing source config: $sourceConfig"
}

if (-not (Test-Path -LiteralPath $sourceScriptDir -PathType Container)) {
    throw "Missing source script directory: $sourceScriptDir"
}

New-Item -ItemType Directory -Path $distDir -Force | Out-Null
Remove-RepoPath $serverStageRoot
Remove-RepoPath $clientStageRoot
Remove-RepoPath $clientConfig
Remove-RepoPath $clientScriptDir
Remove-RepoPath $clientGuiDir
Remove-RepoPath $clientUiGame

Copy-SummonerArcSources -DestinationRoot $serverStageRoot
Copy-SummonerArcSources -DestinationRoot $clientStageRoot
Copy-SummonerArcSources -DestinationRoot $clientRoot

Set-ClientOnlyAimBounds -ObjectPath (Join-Path $clientStageRoot 'script/summoner_arc/objects/beast_summoner.object')
Set-ClientOnlyAimBounds -ObjectPath (Join-Path $clientRoot 'script/summoner_arc/objects/beast_summoner.object')
Write-SummonerArcClientGui -DestinationRoot $clientStageRoot
Write-SummonerArcClientGui -DestinationRoot $clientRoot

Add-Type -AssemblyName System.IO.Compression.FileSystem

Write-ZipFromDirectory -SourceDir $clientStageRoot -ArchivePath (Join-Path $distDir 'savage1.s2z')
Write-Host "Wrote $(Join-Path $distDir 'savage1.s2z')"

Write-ZipFromDirectory -SourceDir $serverStageRoot -ArchivePath (Join-Path $distDir 'summoner_arc.s2z')
Write-Host "Wrote $(Join-Path $distDir 'summoner_arc.s2z')"

Remove-RepoPath $serverStageRoot
Remove-RepoPath $clientStageRoot

Write-Host 'Synced Clientside Summoner Arc overlay and generated client/server archives.'
