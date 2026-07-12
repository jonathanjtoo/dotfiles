$ErrorActionPreference = "Stop"

# Resolve this script's own directory, following symlinks/relative invocation correctly.
$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) {
    $ScriptDir = Split-Path -Parent (Resolve-Path -LiteralPath $MyInvocation.MyCommand.Path)
}

$Chezmoi = Get-Command chezmoi -ErrorAction SilentlyContinue

if (-not $Chezmoi) {
    Write-Host "chezmoi not found, installing..."

    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install twpayne.chezmoi --exact --silent --accept-package-agreements --accept-source-agreements
        $Chezmoi = Get-Command chezmoi -ErrorAction SilentlyContinue
    }

    if (-not $Chezmoi) {
        # Fall back to installing the binary directly into a user-writable location,
        # no admin rights required.
        $BinDir = Join-Path $HOME ".local\bin"
        New-Item -ItemType Directory -Force -Path $BinDir | Out-Null

        $ArchiveUrl = "https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi_windows_amd64.zip"
        $ZipPath = Join-Path $env:TEMP "chezmoi.zip"

        Invoke-WebRequest -Uri $ArchiveUrl -OutFile $ZipPath
        Expand-Archive -Path $ZipPath -DestinationPath $BinDir -Force
        Remove-Item $ZipPath

        $env:Path = "$BinDir;$env:Path"
        $Chezmoi = Get-Command chezmoi -ErrorAction SilentlyContinue

        if (-not $Chezmoi) {
            Write-Error "chezmoi install failed. Install it manually: https://www.chezmoi.io/install/"
            exit 1
        }
    }
}

Write-Host "Applying dotfiles..."
& $Chezmoi.Source init --apply "--source=$ScriptDir"
