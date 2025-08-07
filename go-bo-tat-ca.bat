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
echo     • Xoa khoi Windows Startup
echo.

set /p choice="Ban co chac chan muon go bo? (Y/N): "
if /i "%choice%" neq "Y" goto :end

echo.
echo Chay script khoi phuc...
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "%~dp0toi-uu-windows.ps1" -Restore

echo.
echo 🎉 Go bo hoan thanh!

:end
pause
