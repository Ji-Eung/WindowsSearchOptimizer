@echo off
echo ===============================================
echo   Toi uu Windows Search va Desktop
echo   Bo cong cu toi uu Windows cho nguoi Viet
echo ===============================================
echo.

echo 🎯 Chuong trinh nay se toi uu Windows cua ban:
echo.
echo    1. 🔍 Toi uu Windows Search (giu tim kiem web)
echo.
echo    2. 🎯 Tu dong can giua Start Menu va Search
echo.

set /p choice="Ban co muon tiep tuc? (Y/N): "
if /i "%choice%" neq "Y" goto :end

echo.
echo ===== BUOC 1: Toi uu tim kiem =====
cd /d "%~dp0\SearchOptimizer"
echo Dang chay toi uu Search...
call chay-toi-uu-search.bat

echo.
echo ===== BUOC 2: Can giua cua so ===== 
echo ===== BUOC 2: Ung dung can giua cua so =====
cd /d "%~dp0\WindowCenterApp"
echo Starting Window Center App...
echo Dang khoi dong Window Center App...
cd /d "%~dp0\WindowCenterApp"
echo Dang khoi dong ung dung can giua cua so...
call chay-voi-quyen-admin.bat

echo.
echo 🎉 Cai dat hoan thanh!
echo.
echo ✅ Nhung gi da thay doi:
echo    • Taskbar search chi con icon nho gon
echo    • Tim kiem web van hoat dong binh thuong
echo    • Start Menu va Search luon o giua man hinh
echo    • Ung dung can giua chay tu dong trong system tray
echo.
echo Ban co the test thu bang cach bam Start hoac tim kiem!
echo.

:end
pause
