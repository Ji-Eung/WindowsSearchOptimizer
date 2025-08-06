@echo off
echo ===============================================
echo   Toi uu Windows Search (Giu lai tim kiem web)
echo ===============================================
echo.

REM Check if running as admin
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Dang chay voi quyen Administrator
    echo.
    goto :run_script
) else (
    echo ❌ Can quyen Administrator
    echo.
    echo Nhap chuot phai file nay va chon "Run as administrator"
    echo.
    pause
    exit /b 1
)

:run_script
echo Starting Windows Search optimization...
echo Dang bat dau toi uu Windows Search...
echo.

cd /d "%~dp0"

REM Enable PowerShell execution
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

REM Run the optimization script
powershell -ExecutionPolicy Bypass -File "optimize-search.ps1"

echo.
echo ===============================================
echo   Search Optimization Complete!
echo   Toi uu tim kiem hoan thanh!
echo ===============================================
echo.
echo Changes made / Thay doi da thuc hien:
echo 1. Taskbar search is now ICON ONLY (compact)
echo    Tim kiem taskbar bay gio CHI LA ICON (gon gang)
echo 2. Web search is ENABLED for convenience
echo    Tim kiem web DUOC BAT de tien loi
echo 3. Click search icon for local + web results
echo    Nhap icon tim kiem de co ket qua local + web
echo 4. Cortana disabled but browser search kept
echo    Cortana da tat nhung giu lai tim kiem trinh duyet
echo.
pause
