@echo off
echo ===============================================
echo   Xoa khoi Windows Startup
echo   Remove from Windows Startup
echo ===============================================
echo.

REM Check if running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ Can quyen Administrator
    echo Vui long chay file nay voi quyen Administrator
    echo.
    pause
    exit /b 1
)

echo Dang xoa AutoCenter khoi Windows Startup...

REM Remove from Registry
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsSearchOptimizer" /f

if %ERRORLEVEL% equ 0 (
    echo ✅ Da xoa khoi Startup thanh cong!
    echo AutoCenter se khong tu dong khoi dong nua
) else (
    echo ⚠️  AutoCenter khong co trong Startup hoac da duoc xoa
)

echo.
pause
