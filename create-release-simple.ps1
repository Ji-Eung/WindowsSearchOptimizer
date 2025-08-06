param(
    [string]$Version = "2025.1.1",
    [switch]$SkipBuild = $false
)

$ErrorActionPreference = "Stop"

Write-Host "=====================================" -ForegroundColor Green
Write-Host "  Windows Search Optimizer Release"
Write-Host "  Tao package Release v$Version"  
Write-Host "=====================================" -ForegroundColor Green
Write-Host ""

$RootDir = Get-Location
$ReleaseDir = Join-Path $RootDir "Release"
$EndUserDir = Join-Path $ReleaseDir "WindowsSearchOptimizer-Ready-v$Version"

Write-Host "Preparing release directories..." -ForegroundColor Yellow

if (Test-Path $ReleaseDir) {
    Remove-Item $ReleaseDir -Recurse -Force
}
New-Item -ItemType Directory -Path $ReleaseDir | Out-Null
New-Item -ItemType Directory -Path $EndUserDir | Out-Null

Write-Host "Directories created" -ForegroundColor Green

Write-Host ""
Write-Host "Creating end-user package..." -ForegroundColor Yellow  

$FilesToCopy = @(
    "README.md",
    "setup-everything.bat", 
    "uninstall-everything.bat",
    "SearchOptimizer",
    "WindowCenterApp"
)

foreach ($file in $FilesToCopy) {
    $SourcePath = Join-Path $RootDir $file
    $DestPath = Join-Path $EndUserDir $file
    
    if (Test-Path $SourcePath) {
        if (Test-Path $SourcePath -PathType Container) {
            Copy-Item $SourcePath $DestPath -Recurse -Force
        } else {
            Copy-Item $SourcePath $DestPath -Force
        }
        Write-Host "   Copied: $file" -ForegroundColor Gray
    } else {
        Write-Warning "   Not found: $file"
    }
}

$ExePath = Join-Path $EndUserDir "WindowCenterApp\AutoCenterMinimal.exe"
if (Test-Path $ExePath) {
    Write-Host "AutoCenterMinimal.exe included" -ForegroundColor Green
} else {
    Write-Warning "AutoCenterMinimal.exe not found!"
}

Write-Host ""
Write-Host "Cleaning up end-user package..." -ForegroundColor Yellow

$DirsToRemove = @(
    "WindowCenterApp\source\bin",
    "WindowCenterApp\source\obj", 
    "WindowCenterApp\source\.vs"
)

foreach ($dir in $DirsToRemove) {
    $DirPath = Join-Path $EndUserDir $dir
    if (Test-Path $DirPath) {
        Remove-Item $DirPath -Recurse -Force
        Write-Host "   Removed: $dir" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Creating ZIP file..." -ForegroundColor Yellow

$ZipPath = Join-Path $ReleaseDir "WindowsSearchOptimizer-Ready-v$Version.zip"
if (Get-Command Compress-Archive -ErrorAction SilentlyContinue) {
    Compress-Archive -Path "$EndUserDir\*" -DestinationPath $ZipPath -Force
    Write-Host "ZIP created: $ZipPath" -ForegroundColor Green
} else {
    Write-Warning "Compress-Archive not available. Please create ZIP manually"
}

Write-Host ""
Write-Host "Release package ready!" -ForegroundColor Green
Write-Host "End-user folder: $EndUserDir" -ForegroundColor Cyan

if (Test-Path $ZipPath) {
    $ZipSize = [math]::Round((Get-Item $ZipPath).Length / 1MB, 1)
    Write-Host "ZIP file: $ZipPath ($ZipSize MB)" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Test the package"
Write-Host "2. Upload to GitHub Releases"
Write-Host "3. Tag: v$Version"
Write-Host ""

$OpenFolder = Read-Host "Open release folder? (Y/N)"
if ($OpenFolder -eq "Y" -or $OpenFolder -eq "y") {
    if (Test-Path $ReleaseDir) {
        Start-Process explorer.exe -ArgumentList $ReleaseDir
    }
}

Write-Host "Done!" -ForegroundColor Green
