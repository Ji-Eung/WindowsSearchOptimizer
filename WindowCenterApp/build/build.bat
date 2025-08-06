@echo off
echo Building Auto-Center Minimal Service...
echo Đang build dịch vụ Auto-Center tối giản...

cd /d "%~dp0"

echo.
echo ===== Cleaning previous builds =====
echo ===== Dọn dẹp build trước đó =====
if exist "..\source\bin" rmdir /s /q "..\source\bin"
if exist "..\source\obj" rmdir /s /q "..\source\obj"

echo.
echo ===== Building Release Version =====
echo ===== Build phiên bản Release =====
cd "..\source"
dotnet build AutoCenterMinimal.csproj -c Release --verbosity normal

if %ERRORLEVEL% neq 0 (
    echo.
    echo ❌ Build failed! / Build thất bại!
    pause
    exit /b 1
)

echo.
echo ===== Publishing Self-Contained Executable =====
echo ===== Publish file thực thi độc lập =====
dotnet publish AutoCenterMinimal.csproj ^
    -c Release ^
    -r win-x64 ^
    --self-contained true ^
    -p:PublishSingleFile=true ^
    -o ".." ^
    --verbosity normal

if %ERRORLEVEL% neq 0 (
    echo.
    echo ❌ Build failed! / Build thất bại!
    pause
    exit /b 1
)
    exit /b 1
)

echo.
echo ✅ Build completed successfully! / Build hoàn thành thành công!
echo.
echo 📁 Output files / File đầu ra:
echo    - bin\Release\net8.0-windows\AutoCenterMinimal.exe (requires .NET 8)
echo    - ..\publish\AutoCenterMinimal.exe (standalone)
echo.
echo 🚀 To use / Để sử dụng:
echo    1. Go to WindowCenterApp folder / Đi tới thư mục WindowCenterApp
echo    2. Right-click run-as-admin.bat
echo    3. Select "Run as administrator" / Chọn "Run as administrator"
echo    4. App will run in system tray / App sẽ chạy trong system tray
echo    5. Right-click tray icon for options / Nhấp chuột phải icon tray để xem tùy chọn
echo.
echo 📋 Features / Tính năng:
echo    - Auto-centers Windows Start Menu / Tự động căn giữa Start Menu
echo    - Auto-centers Windows Search / Tự động căn giữa Windows Search  
echo    - No UI, no hotkeys / Không UI, không phím tắt
echo    - Runs silently in background / Chạy ngầm im lặng
echo    - System tray control / Điều khiển qua system tray
echo.

pause
