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
cd /d "%~dp0\WindowCenterApp"
echo Dang khoi dong ung dung can giua cua so...
call chay-voi-quyen-admin.bat

echo.
echo ===== BUOC 3: Them vao Startup (Tu chon) =====
set /p startup_choice="Ban co muon AutoCenter tu dong khoi dong cung Windows? (Y/N): "
if /i "%startup_choice%" equ "Y" (
    echo Dang them vao Startup...
    call them-vao-startup.bat
)

echo.
echo 🎉 Cai dat hoan thanh!
echo.
echo ✅ Nhung gi da thay doi:
echo    • Taskbar search chi con icon nho gon
echo    • Tim kiem web van hoat dong binh thuong
echo    • Start Menu va Search luon o giua man hinh
echo    • Ung dung can giua chay tu dong trong system tray
if /i "%startup_choice%" equ "Y" (
    echo    • AutoCenter se tu dong khoi dong cung Windows
)
echo.
echo Ban co the test thu bang cach bam Start hoac tim kiem!
echo.

:end
pause
