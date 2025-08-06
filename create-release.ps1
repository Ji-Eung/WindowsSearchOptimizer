# Release Preparation Script
# Script tự động tạo package cho GitHub release

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

# Get current directory
$RootDir = Get-Location
$ReleaseDir = Join-Path $RootDir "Release"
$EndUserDir = Join-Path $ReleaseDir "WindowsSearchOptimizer-Ready-v$Version"

Write-Host "🔧 Preparing release directories..." -ForegroundColor Yellow
Write-Host "   Chuan bi thu muc release..."

# Create release directory
if (Test-Path $ReleaseDir) {
    Remove-Item $ReleaseDir -Recurse -Force
}
New-Item -ItemType Directory -Path $ReleaseDir | Out-Null
New-Item -ItemType Directory -Path $EndUserDir | Out-Null

Write-Host "✅ Directories created" -ForegroundColor Green

# Build WindowCenterApp if not skipped
if (-not $SkipBuild) {
    Write-Host ""
    Write-Host "🔨 Building WindowCenterApp..." -ForegroundColor Yellow
    Write-Host "   Dang build WindowCenterApp..."
    
    $BuildDir = Join-Path $RootDir "WindowCenterApp\build"
    if (Test-Path $BuildDir) {
        Push-Location $BuildDir
        try {
            & .\build.bat
            if ($LASTEXITCODE -ne 0) {
                throw "Build failed / Build that bai"
            }
            Write-Host "✅ Build completed successfully" -ForegroundColor Green
        }
        finally {
            Pop-Location
        }
    } else {
        Write-Warning "Build directory not found, skipping build"
        Write-Warning "Khong tim thay thu muc build, bo qua build"
    }
}

Write-Host ""
Write-Host "📦 Creating end-user package..." -ForegroundColor Yellow  
Write-Host "   Tao package cho end-user..."

# Copy main files
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
            # Directory
            Copy-Item $SourcePath $DestPath -Recurse -Force
        } else {
            # File  
            Copy-Item $SourcePath $DestPath -Force
        }
        Write-Host "   ✓ Copied: $file" -ForegroundColor Gray
    } else {
        Write-Warning "   ⚠ Not found: $file"
    }
}

# Check if AutoCenterMinimal.exe exists
$ExePath = Join-Path $EndUserDir "WindowCenterApp\AutoCenterMinimal.exe"
if (Test-Path $ExePath) {
    Write-Host "✅ AutoCenterMinimal.exe included" -ForegroundColor Green
} else {
    Write-Warning "❌ AutoCenterMinimal.exe not found!"
    Write-Warning "   Run build.bat first or use -SkipBuild if intentional"
    Write-Warning "   Chay build.bat truoc hoac dung -SkipBuild neu co y"
}

# Clean up unnecessary files from end-user package
Write-Host ""
Write-Host "🧹 Cleaning up end-user package..." -ForegroundColor Yellow
Write-Host "   Don dep package end-user..."

$DirsToRemove = @(
    "WindowCenterApp\source\bin",
    "WindowCenterApp\source\obj", 
    "WindowCenterApp\source\.vs"
)

foreach ($dir in $DirsToRemove) {
    $DirPath = Join-Path $EndUserDir $dir
    if (Test-Path $DirPath) {
        Remove-Item $DirPath -Recurse -Force
        Write-Host "   ✓ Removed: $dir" -ForegroundColor Gray
    }
}

# Create ZIP file for end-user
Write-Host ""
Write-Host "📦 Creating ZIP file..." -ForegroundColor Yellow
Write-Host "   Tao file ZIP..."

$ZipPath = Join-Path $ReleaseDir "WindowsSearchOptimizer-Ready-v$Version.zip"
if (Get-Command Compress-Archive -ErrorAction SilentlyContinue) {
    Compress-Archive -Path $EndUserDir -DestinationPath $ZipPath -Force
    Write-Host "✅ ZIP created: $ZipPath" -ForegroundColor Green
} else {
    Write-Warning "Compress-Archive not available. Please create ZIP manually:"
    Write-Warning "Khong co Compress-Archive. Vui long tao ZIP thu cong:"
    Write-Warning "Folder: $EndUserDir"
}

# Show summary
Write-Host ""
Write-Host "🎉 Release package ready!" -ForegroundColor Green
Write-Host "   Package release da san sang!"
Write-Host ""
Write-Host "📁 End-user folder: $EndUserDir" -ForegroundColor Cyan
if (Test-Path $ZipPath) {
    $ZipSize = [math]::Round((Get-Item $ZipPath).Length / 1MB, 1)
    Write-Host "📦 ZIP file: $ZipPath ($ZipSize MB)" -ForegroundColor Cyan
}
Write-Host ""

# Next steps
Write-Host "🚀 Next steps / Cac buoc tiep theo:" -ForegroundColor Yellow
Write-Host "1. Test the package / Test package:"
Write-Host "   Extract ZIP → Run setup-everything.bat as Admin"
Write-Host ""
Write-Host "2. Upload to GitHub Releases:"
Write-Host "   - Go to GitHub repo → Releases → Create new release"
Write-Host "   - Tag: v$Version"
Write-Host "   - Attach the ZIP file"
Write-Host ""
Write-Host "3. Update download links in README.md"
Write-Host ""

# Optional: Open release folder
$OpenFolder = Read-Host "Open release folder? (Y/N) / Mo thu muc release? (Y/N)"
if ($OpenFolder -eq "Y" -or $OpenFolder -eq "y") {
    if (Test-Path $ReleaseDir) {
        Start-Process explorer.exe -ArgumentList $ReleaseDir
    }
}

Write-Host "Done! / Hoan thanh!" -ForegroundColor Green
