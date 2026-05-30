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

    if (-not (Test-Path -LiteralPath $SourceDir -PathType Container)) {
        throw "Missing source directory: $SourceDir"
    }

    New-Item -ItemType Directory -Path $DestinationDir -Force | Out-Null

    Get-ChildItem -LiteralPath $SourceDir -Recurse -File | ForEach-Object {
        $relativePath = [System.IO.Path]::GetRelativePath($SourceDir, $_.FullName)
        $targetPath = Join-Path $DestinationDir $relativePath
        $targetDir = Split-Path -Parent $targetPath
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $targetPath -Force
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

$serverSourceRoot = Join-RepoPath 'serverside-mods/human-silo'
$clientSourceRoot = Join-RepoPath 'clientside-mods/savage002-human-silo'
$distDir = Join-RepoPath 'dist'
$serverStageRoot = Join-RepoPath 'dist/.human_silo_server_package'
$clientStageRoot = Join-RepoPath 'dist/.human_silo_client_package'
$serverArchivePath = Join-Path $distDir 'human_silo.s2z'
$clientArchivePath = Join-Path $distDir 'savage002.s2z'

New-Item -ItemType Directory -Path $distDir -Force | Out-Null
Remove-RepoPath $serverStageRoot
Remove-RepoPath $clientStageRoot

Copy-DirectoryContents -SourceDir $serverSourceRoot -DestinationDir $serverStageRoot
Copy-DirectoryContents -SourceDir $clientSourceRoot -DestinationDir $clientStageRoot

Add-Type -AssemblyName System.IO.Compression.FileSystem

Write-ZipFromDirectory -SourceDir $serverStageRoot -ArchivePath $serverArchivePath
Write-Host "Wrote $serverArchivePath"

Write-ZipFromDirectory -SourceDir $clientStageRoot -ArchivePath $clientArchivePath
Write-Host "Wrote $clientArchivePath"

Remove-RepoPath $serverStageRoot
Remove-RepoPath $clientStageRoot
