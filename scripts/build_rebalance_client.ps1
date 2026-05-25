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

function Copy-RebalanceMarkerConfig {
    param([Parameter(Mandatory = $true)][string]$StageRoot)

    $sourcePath = Join-RepoPath 'game/mods/master/rebalance.cfg'
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        throw "Missing source config: $sourcePath"
    }

    $targetDir = Join-Path $StageRoot 'mods/master'
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Copy-Item -LiteralPath $sourcePath -Destination (Join-Path $targetDir 'rebalance.cfg') -Force
}

function Copy-RebalanceClientGui {
    param([Parameter(Mandatory = $true)][string]$StageRoot)

    $targetDir = Join-Path $StageRoot 'gui/standard'
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null

    foreach ($fileName in @('ui_tithe.cfg', 'frame_event.cfg')) {
        $sourcePath = Join-RepoPath "Clientside/gui/standard/$fileName"
        if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
            throw "Missing source GUI: $sourcePath"
        }

        Copy-Item -LiteralPath $sourcePath -Destination (Join-Path $targetDir $fileName) -Force
    }

    $frameEventPath = Join-RepoPath 'Clientside/gui/standard/frame_event.cfg'
    Copy-Item -LiteralPath $frameEventPath -Destination (Join-Path $StageRoot 'frame_event.cfg') -Force
}

$distDir = Join-RepoPath 'dist'
$serverStageRoot = Join-RepoPath 'dist/.rebalance_server_package'
$clientStageRoot = Join-RepoPath 'dist/.rebalance_client_package'
$serverArchivePath = Join-Path $distDir 'rebalance.s2z'
$clientArchivePath = Join-Path $distDir 'savage1.s2z'

New-Item -ItemType Directory -Path $distDir -Force | Out-Null
Remove-RepoPath $serverStageRoot
Remove-RepoPath $clientStageRoot

Copy-RebalanceMarkerConfig -StageRoot $serverStageRoot
Copy-RebalanceClientGui -StageRoot $serverStageRoot
Copy-RebalanceClientGui -StageRoot $clientStageRoot

Add-Type -AssemblyName System.IO.Compression.FileSystem

Write-ZipFromDirectory -SourceDir $serverStageRoot -ArchivePath $serverArchivePath
Write-Host "Wrote $serverArchivePath"

Write-ZipFromDirectory -SourceDir $clientStageRoot -ArchivePath $clientArchivePath
Write-Host "Wrote $clientArchivePath"

Remove-RepoPath $serverStageRoot
Remove-RepoPath $clientStageRoot
