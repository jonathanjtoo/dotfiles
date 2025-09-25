# Requires running PowerShell as Administrator
# Function to check admin rights
function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Check if running as admin, exit if not
if (-not (Test-IsAdmin)) {
    Write-Host "This install_dotfiles_win64 script requires Administrator privileges. Please run as Administrator." -ForegroundColor Red
    exit 1
}

# Get the directory where this script is located (root of dotfiles repo)
$dotfilesDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Define config targets
$nvimConfigDir = Join-Path $Env:LOCALAPPDATA "nvim"
$vimConfigDir = $Env:USERPROFILE

# Create nvim config dir if it doesn't exist
if (-Not (Test-Path $nvimConfigDir)) {
    New-Item -ItemType Directory -Path $nvimConfigDir
    Write-Host "Created directory $nvimConfigDir"
}

# Create symlink for Neovim config directory
$nvimTarget = $nvimConfigDir
$nvimSource = Join-Path $dotfilesDir "nvim"

if (Test-Path $nvimTarget) {
    Remove-Item $nvimTarget -Recurse -Force
    Write-Host "Removed existing symlink/directory $nvimTarget"
}

New-Item -ItemType SymbolicLink -Path $nvimTarget -Target $nvimSource
Write-Host "Created symlink: $nvimTarget -> $nvimSource"

# Create symlink for Vim _vimrc
$vimTarget = Join-Path $vimConfigDir "_vimrc"
$vimSource = Join-Path $dotfilesDir "vim\vimrc"

if (Test-Path $vimTarget) {
    Remove-Item $vimTarget -Force
    Write-Host "Removed existing symlink/file $vimTarget"
}

New-Item -ItemType SymbolicLink -Path $vimTarget -Target $vimSource
Write-Host "Created symlink: $vimTarget -> $vimSource"

Write-Host "Symlink creation complete."
