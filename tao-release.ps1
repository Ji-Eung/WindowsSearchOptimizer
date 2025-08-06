param([string]$Version = "2025.1.1")

$RootDir = Get-Location
$ReleaseDir = Join-Path $RootDir "Release"
$PackageDir = Join-Path $ReleaseDir "WindowsSearchOptimizer-Ready-v$Version"

Write-Host "Tao package release v$Version..." -ForegroundColor Green

if (Test-Path $ReleaseDir) {
    Remove-Item $ReleaseDir -Recurse -Force
}
New-Item -ItemType Directory -Path $ReleaseDir | Out-Null
New-Item -ItemType Directory -Path $PackageDir | Out-Null

$FilesToCopy = @("README.md", "cai-dat-tat-ca.bat", "go-bo-tat-ca.bat", "SearchOptimizer", "WindowCenterApp")

foreach ($file in $FilesToCopy) {
    $SourcePath = Join-Path $RootDir $file
    $DestPath = Join-Path $PackageDir $file
    
    if (Test-Path $SourcePath) {
        if (Test-Path $SourcePath -PathType Container) {
            Copy-Item $SourcePath $DestPath -Recurse -Force
        } else {
            Copy-Item $SourcePath $DestPath -Force
        }
        Write-Host "   Da copy: $file" -ForegroundColor Gray
    }
}

$DirsToRemove = @("WindowCenterApp\source\bin", "WindowCenterApp\source\obj", "WindowCenterApp\source\.vs")
foreach ($dir in $DirsToRemove) {
    $DirPath = Join-Path $PackageDir $dir
    if (Test-Path $DirPath) {
        Remove-Item $DirPath -Recurse -Force
    }
}

$ZipPath = Join-Path $ReleaseDir "WindowsSearchOptimizer-Ready-v$Version.zip"
Compress-Archive -Path "$PackageDir\*" -DestinationPath $ZipPath -Force

$ZipSize = [math]::Round((Get-Item $ZipPath).Length / 1MB, 1)
Write-Host ""
Write-Host "Hoan thanh!" -ForegroundColor Green
Write-Host "ZIP file: $ZipPath ($ZipSize MB)" -ForegroundColor Cyan

Start-Process explorer.exe -ArgumentList $ReleaseDir
