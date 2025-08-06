@echo off
echo ===============================================
echo   Create Release Package
echo   Tao goi Release
echo ===============================================
echo.

echo This will create a release package for GitHub
echo Dieu nay se tao goi release cho GitHub
echo.

set /p version="Enter version (default 2025.1.1) / Nhap version (mac dinh 2025.1.1): "
if "%version%"=="" set version=2025.1.1

echo.
echo Creating release package v%version%...
echo Dang tao goi release v%version%...
echo.

powershell -ExecutionPolicy Bypass -Command "& '.\create-release.ps1' -Version '%version%'"

echo.
pause
