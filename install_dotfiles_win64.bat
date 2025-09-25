@echo off
REM Check for admin rights by testing access to a system command only admins can run
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ################################################
    echo # ERROR: This script must be run as Administrator.
    echo # Please right-click the batch file and choose:
    echo # "Run as Administrator"
    echo ################################################
    pause
    exit /b 1
)

REM Your existing script commands below
REM Get the directory of this batch file
set ScriptDir=%~dp0

REM Build the full path to the PowerShell script
set PS1Script=%ScriptDir%install_dotfiles_win64.ps1

REM Run the PowerShell script with bypass of execution policy and no profile loaded
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PS1Script%"

pause
