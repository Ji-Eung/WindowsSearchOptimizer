@echo off
echo ===============================================
echo   Uninstall Windows Desktop Enhancement
echo   Go bo toi uu Windows Desktop
echo ===============================================
echo.

echo ⚠️  This will restore your Windows to original settings:
echo     Dieu nay se khoi phuc Windows ve cai dat goc:
echo.
echo     • Restore Windows Search to default
echo       Khoi phuc Windows Search ve mac dinh
echo     • Stop Window Center app
echo       Dung ung dung Window Center
echo     • Remove all optimizations
echo       Xoa tat ca toi uu hoa
echo.

set /p choice="Are you sure? (Y/N) / Ban co chac khong? (Y/N): "
if /i "%choice%" neq "Y" goto :end

echo.
echo ===== Stopping Window Center App =====
echo ===== Dung ung dung Window Center =====
taskkill /f /im "AutoCenterMinimal.exe" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo ✅ Window Center app stopped
    echo ✅ Ung dung Window Center da dung
) else (
    echo ⚠️  Window Center app was not running
    echo ⚠️  Ung dung Window Center khong chay
)

echo.
echo ===== Restoring Search Settings =====
echo ===== Khoi phuc cai dat tim kiem =====
cd /d "%~dp0\SearchOptimizer"

REM Check if running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ Administrator privileges required for search restore
    echo ❌ Can quyen Administrator de khoi phuc tim kiem
    echo Please run this file as Administrator
    echo Vui long chay file nay voi quyen Administrator
    goto :end
)

echo Running Search restore...
echo Dang chay khoi phuc tim kiem...
powershell -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; .\optimize-search.ps1 -Restore"

echo.
echo 🎉 Uninstall Complete! / Go bo hoan thanh!
echo.
echo ✅ What's restored / Nhung gi da khoi phuc:
echo    • Windows Search back to default settings
echo      Windows Search ve cai dat mac dinh
echo    • Taskbar search box restored (if was full box before)
echo      Hop tim kiem taskbar duoc khoi phuc
echo    • Window auto-centering stopped
echo      Tu dong can giua cua so da dung
echo.
echo You may need to restart Windows Explorer or reboot
echo Ban co the can khoi dong lai Windows Explorer hoac reboot
echo.

:end
pause
