@echo off
echo ===============================================
echo   Windows Desktop Enhancement Suite
echo   Bo cong cu toi uu trai nghiem Windows
echo ===============================================
echo.

echo 🎯 This will optimize your Windows desktop experience:
echo    Dieu nay se toi uu trai nghiem Windows desktop:
echo.
echo    1. 🔍 Optimize Windows Search (keep web search)
echo       Toi uu Windows Search (giu lai tim kiem web)
echo.
echo    2. 🎯 Auto-center Start Menu and Search windows
echo       Tu dong can giua Start Menu va cua so Search
echo.

set /p choice="Do you want to continue? (Y/N) / Ban co muon tiep tuc? (Y/N): "
if /i "%choice%" neq "Y" goto :end

echo.
echo ===== STEP 1: Search Optimization =====
echo ===== BUOC 1: Toi uu tim kiem =====
cd /d "%~dp0\SearchOptimizer"
echo Running Search Optimizer...
echo Dang chay Search Optimizer...
call run-optimize-search.bat

echo.
echo ===== STEP 2: Window Center App =====
echo ===== BUOC 2: Ung dung can giua cua so =====
cd /d "%~dp0\WindowCenterApp"
echo Starting Window Center App...
echo Dang khoi dong Window Center App...
call run-as-admin.bat

echo.
echo 🎉 Setup Complete! / Cai dat hoan thanh!
echo.
echo ✅ What's changed / Nhung gi da thay doi:
echo    • Taskbar search is now icon-only
echo      Taskbar search bay gio chi la icon
echo    • Web search still works in Start Menu
echo      Tim kiem web van hoat dong trong Start Menu
echo    • Start Menu and Search auto-center
echo      Start Menu va Search tu dong can giua
echo    • Window Center app runs in system tray
echo      Ung dung Window Center chay trong system tray
echo.

:end
pause
