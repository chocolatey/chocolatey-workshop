@echo off
setlocal enableextensions enabledelayedexpansion
set psscript="./setup.ps1"
echo ==================================================
echo ============= WRAP POWERSHELL SCRIPT =============
echo ==================================================

echo calling %psscript% with args %*
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%psscript%' %*"

echo ==================================================
endlocal
