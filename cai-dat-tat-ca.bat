@echo off
echo ===============================================
echo   Toi uu Windows Search va Desktop
echo   Bo cong cu toi uu Windows cho nguoi Viet
echo ===============================================
echo.

echo 🎯 Chuong trinh nay se toi uu Windows cua ban:
echo.
echo    1. 🔍 Toi uu Windows Search (taskbar gon, giu tim kiem web)
echo    2. 🎯 Tu dong can giua Start Menu va Search window
echo    3. 🚀 Co the them vao Startup tu dong khoi dong
echo.

set /p choice="Ban co muon tiep tuc? (Y/N): "
if /i "%choice%" neq "Y" goto :end

echo.
echo Chay script toi uu...
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0toi-uu-windows.ps1"

echo.
echo 🎉 Hoan thanh!

:end
pause
