# Tối ưu Windows Search và Desktop - All-in-One
# Gộp cả Search Optimizer và Window Center App

param(
    [switch]$Restore = $false
)

$ErrorActionPreference = "Stop"

# Check if running as Administrator
function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "❌ Can quyen Administrator" -ForegroundColor Red
    Write-Host "Vui long chay PowerShell voi quyen Administrator" -ForegroundColor Yellow
    Read-Host "Nhan Enter de thoat"
    exit 1
}

Write-Host "=============================================" -ForegroundColor Green
Write-Host "  Toi uu Windows Search va Desktop" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host ""

if ($Restore) {
    Write-Host "🔄 Khoi phuc cai dat goc..." -ForegroundColor Yellow
    
    # Stop Window Center App
    Write-Host "Dung ung dung can giua cua so..."
    taskkill /f /im "AutoCenterMinimal.exe" 2>$null
    
    # Remove from Startup
    Write-Host "Xoa khoi Windows Startup..."
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsSearchOptimizer" -ErrorAction SilentlyContinue
    
    # Restore Search Settings
    Write-Host "Khoi phuc cai dat Search..."
    
    # Enable Cortana
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaEnabled" -Value 1 -Force
    
    # Restore Search Box to full
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 2 -Force
    
    # Enable web search
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 1 -Force
    
    Write-Host "✅ Khoi phuc hoan thanh!" -ForegroundColor Green
    Write-Host "Ban co the can khoi dong lai Explorer hoac may tinh." -ForegroundColor Yellow
    
} else {
    Write-Host "🚀 Bat dau toi uu..." -ForegroundColor Yellow
    
    # === SEARCH OPTIMIZATION ===
    Write-Host ""
    Write-Host "=== TIET 1: Toi uu Windows Search ===" -ForegroundColor Cyan
    
    # Disable Cortana
    Write-Host "Tat Cortana..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaEnabled" -Value 0 -Force
    
    # Set search to icon only
    Write-Host "Chuyen search box thanh icon..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 1 -Force
    
    # Keep web search enabled
    Write-Host "Giu lai tim kiem web..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 1 -Force
    
    # Disable search highlights
    Write-Host "Tat search highlights..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDeviceSearchHistoryEnabled" -Value 0 -Force
    
    Write-Host "✅ Toi uu Search hoan thanh!" -ForegroundColor Green
    
    # === WINDOW CENTER APP ===
    Write-Host ""
    Write-Host "=== TIET 2: Khoi dong Window Center App ===" -ForegroundColor Cyan
    
    $exePath = Join-Path $PSScriptRoot "WindowCenterApp\AutoCenterMinimal.exe"
    
    if (Test-Path $exePath) {
        Write-Host "Khoi dong ung dung can giua cua so..."
        Start-Process $exePath -WindowStyle Hidden
        Start-Sleep 2
        
        # Check if started successfully
        if (Get-Process "AutoCenterMinimal" -ErrorAction SilentlyContinue) {
            Write-Host "✅ Window Center App da khoi dong!" -ForegroundColor Green
        } else {
            Write-Host "⚠️  Khong the khoi dong Window Center App" -ForegroundColor Yellow
        }
    } else {
        Write-Host "⚠️  Khong tim thay AutoCenterMinimal.exe" -ForegroundColor Yellow
        Write-Host "Vui long build tu source code truoc" -ForegroundColor Yellow
    }
    
    # === ADD TO STARTUP (Optional) ===
    Write-Host ""
    Write-Host "=== TIET 3: Them vao Startup (Tu chon) ===" -ForegroundColor Cyan
    
    $addStartup = Read-Host "Ban co muon AutoCenter tu dong khoi dong cung Windows? (Y/N)"
    if ($addStartup -eq "Y" -or $addStartup -eq "y") {
        Write-Host "Them vao Windows Startup..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsSearchOptimizer" -Value "`"$exePath`"" -Force
        Write-Host "✅ Da them vao Startup!" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "🎉 Toi uu hoan thanh!" -ForegroundColor Green
    Write-Host ""
    Write-Host "✅ Nhung gi da thay doi:" -ForegroundColor Yellow
    Write-Host "   • Taskbar search chi con icon nho gon" -ForegroundColor White
    Write-Host "   • Start Menu va Search luon o giua man hinh" -ForegroundColor White
    Write-Host "   • Tim kiem web van hoat dong binh thuong" -ForegroundColor White
    Write-Host "   • Khong con Cortana lam phien" -ForegroundColor White
    if ($addStartup -eq "Y" -or $addStartup -eq "y") {
        Write-Host "   • AutoCenter se tu dong khoi dong cung Windows" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "Ban co the test thu bang cach bam Start hoac tim kiem!" -ForegroundColor Cyan
}

Write-Host ""
Read-Host "Nhan Enter de thoat"
