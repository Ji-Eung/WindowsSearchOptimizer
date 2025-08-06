@echo off
echo ===============================================
echo   AutoCenter Minimal - Administrator Mode
echo   Tu dong can giua Start Menu va Windows Search
echo ===============================================
echo.

REM Check if running as admin
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Running with Administrator privileges
    echo Dang chay voi quyen Administrator
    echo.
    goto :run_app
) else (
    echo ❌ Administrator privileges required
    echo Can quyen Administrator
    echo.
    echo Right-click this file and select "Run as administrator"
    echo Nhap chuot phai file nay va chon "Run as administrator"
    echo.
    pause
    exit /b 1
)

:run_app
echo Starting AutoCenter Minimal...
echo Dang khoi dong AutoCenter Minimal...
echo.

cd /d "%~dp0"
start /min "" "AutoCenterMinimal.exe"

echo ✅ Application started in system tray
echo Ung dung da khoi dong trong system tray
echo.
echo 📋 USAGE / CACH SU DUNG:
echo • Press Win+S to test Search centering
echo   Nhan Win+S de test can giua Search
echo • Press Win key to test Start Menu centering  
echo   Nhan phim Win de test can giua Start Menu
echo • Right-click tray icon for manual controls
echo   Nhap chuot phai icon tray de dieu khien thu cong
echo.
echo Press any key to exit this window...
echo Nhan phim bat ky de dong cua so nay...
pause >nul
