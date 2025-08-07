@echo off
echo ===============================================
echo   Them vao Windows Startup
echo   Add to Windows Startup
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

echo Dang them AutoCenter vao Windows Startup...

REM Get current directory
set "CURRENT_DIR=%~dp0"
set "EXE_PATH=%CURRENT_DIR%AutoCenterMinimal.exe"

REM Add to Registry (Current User)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsSearchOptimizer" /t REG_SZ /d "\"%EXE_PATH%\"" /f

if %ERRORLEVEL% equ 0 (
    echo ✅ Da them vao Startup thanh cong!
    echo AutoCenter se tu dong khoi dong cung Windows
) else (
    echo ❌ Loi khi them vao Startup
)

echo.
pause
