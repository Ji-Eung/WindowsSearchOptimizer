@echo off
echo ===============================================
echo   Go bo toi uu Windows Search va Desktop
echo   Khoi phuc lai cai dat goc cua Windows
echo ===============================================
echo.

echo ⚠️  Chuong trinh nay se khoi phuc Windows ve trang thai ban dau:
echo.
echo     • Khoi phuc Windows Search ve mac dinh
echo     • Dung ung dung can giua cua so
echo     • Xoa tat ca toi uu hoa
echo.

set /p choice="Ban co chac chan muon go bo? (Y/N): "
if /i "%choice%" neq "Y" goto :end

echo.
echo ===== Dung ung dung can giua cua so =====
taskkill /f /im "AutoCenterMinimal.exe" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo ✅ Da dung ung dung can giua cua so
) else (
    echo ⚠️  Ung dung can giua cua so khong chay
)

echo.
echo ===== Khoi phuc cai dat tim kiem =====
cd /d "%~dp0\SearchOptimizer"

REM Check if running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ Can quyen Administrator de khoi phuc tim kiem
    echo Vui long chay file nay voi quyen Administrator
    goto :end
)

echo Dang chay khoi phuc tim kiem...
powershell -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; .\optimize-search.ps1 -Restore"

echo.
echo 🎉 Go bo hoan thanh!
echo.
echo ✅ Nhung gi da khoi phuc:
echo    • Windows Search ve cai dat mac dinh
echo    • Hop tim kiem taskbar duoc khoi phuc
echo    • Dung ung dung can giua cua so
echo.
echo Ban co the can khoi dong lai Windows Explorer hoac may tinh.
echo.

:end
pause
