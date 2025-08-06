# Windows Search Optimization Script (Keep Browser Search)
# Script Toi Uu Windows Search (Giu Lai Tim Kiem Trinh Duyet)

param(
    [switch]$Restore,
    [switch]$Help
)

# Colors for output
$Green = @{ ForegroundColor = "Green" }
$Yellow = @{ ForegroundColor = "Yellow" }
$Red = @{ ForegroundColor = "Red" }
$Cyan = @{ ForegroundColor = "Cyan" }

function Show-Help {
    Write-Host @"
========================================
 Windows Search Optimization (Keep Web)
 Toi uu Windows Search (Giu lai Web)
========================================

USAGE / SU DUNG:
  .\optimize-search.ps1          # Apply optimization / Ap dung toi uu
  .\optimize-search.ps1 -Restore # Restore defaults / Khoi phuc mac dinh
  .\optimize-search.ps1 -Help    # Show this help / Hien thi help

WHAT IT DOES / CHUC NANG:
✅ Keeps web search ENABLED for convenience / GIU LAI tim kiem web de tien loi
✅ MAINTAINS browser search integration / DUY TRI tich hop tim kiem trinh duyet
✅ Disables Cortana only / Chi tat Cortana thoi  
✅ Optimizes search suggestions / Toi uu goi y tim kiem
✅ Minimizes taskbar search box / Thu nho hop tim kiem taskbar
✅ Keeps useful search history / Giu lai lich su tim kiem huu ich
✅ Local + Web search combined / Ket hop tim kiem local va web
✅ Quick access to browser results / Truy cap nhanh ket qua trinh duyet

"@ @Cyan
}

function Test-AdminRights {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Set-RegistryValue {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [string]$Type = "DWORD"
    )
    
    try {
        # Handle HKLM (Local Machine) paths that require admin
        $isSystemPath = $Path.StartsWith("HKLM:")
        
        if (!(Test-Path $Path)) {
            if ($isSystemPath) {
                # For system paths, create with proper permissions
                $null = New-Item -Path $Path -Force -ErrorAction Stop
            } else {
                $null = New-Item -Path $Path -Force -ErrorAction Stop
            }
        }
        
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force -ErrorAction Stop
        return $true
    } catch {
        Write-Host "❌ Failed: $($_.Exception.Message)" @Red
        return $false
    }
}

function Optimize-WindowsSearchSettings {
    Write-Host "`n===== APPLYING SEARCH OPTIMIZATION =====" @Cyan
    Write-Host "===== AP DUNG TOI UU TIM KIEM =====" @Cyan
    
    $settings = @(
        # Core Windows Search Registry Settings - KEEP WEB SEARCH ENABLED
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "BingSearchEnabled"; Value = 1; Description = "Keep Bing web search enabled for convenience" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "AllowSearchToUseLocation"; Value = 0; Description = "Disable location-based search for privacy" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "CortanaConsent"; Value = 0; Description = "Disable Cortana consent" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "CortanaEnabled"; Value = 0; Description = "Disable Cortana completely" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "DeviceHistoryEnabled"; Value = 0; Description = "Disable device history" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "HistoryViewEnabled"; Value = 1; Description = "Keep search history for better experience" },
        
        # Taskbar Search Box Settings - Make it minimal
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Value = 1; Description = "Show search icon only (not full box)" },
        
        # KEEP BROWSER SEARCH INTEGRATION - GIU LAI TIM KIEM TRINH DUYET
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "AllowCloudSearch"; Value = 1; Description = "Allow cloud search for web results" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "ConnectedSearchUseWeb"; Value = 1; Description = "Enable web search in Start Menu" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "ConnectedSearchUseWebOverMeteredConnections"; Value = 0; Description = "Disable web search on metered connections only" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "ConnectedSearchPrivacy"; Value = 1; Description = "Balanced privacy level for search" },
        
        # Optimize Cloud Search Settings
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"; Name = "IsAADCloudSearchEnabled"; Value = 0; Description = "Disable Azure AD cloud search" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"; Name = "IsDeviceSearchHistoryEnabled"; Value = 1; Description = "Keep device search history" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"; Name = "IsMSACloudSearchEnabled"; Value = 1; Description = "Enable Microsoft account cloud search" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"; Name = "SafeSearchMode"; Value = 1; Description = "Enable moderate safe search" },
        
        # System Optimization - Remove heavy policies, keep browser access
        @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"; Name = "AllowCortana"; Value = 0; Description = "System: Disable Cortana only" },
        
        # Explorer Optimization - Keep browser integration
        @{ Path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"; Name = "DisableSearchBoxSuggestions"; Value = 0; Description = "Keep search suggestions for better UX" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ShowCortanaButton"; Value = 0; Description = "Hide Cortana button from taskbar" },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "Start_SearchFiles"; Value = 1; Description = "Allow comprehensive search including web" }
    )
    
    $successCount = 0
    for ($i = 0; $i -lt $settings.Count; $i++) {
        $setting = $settings[$i]
        Write-Host "[$($i+1)/$($settings.Count)] $($setting.Description)..." @Yellow
        
        if (Set-RegistryValue -Path $setting.Path -Name $setting.Name -Value $setting.Value) {
            $successCount++
            Write-Host "  ✅ Success" @Green
        } else {
            Write-Host "  ❌ Failed" @Red
        }
    }
    
    Write-Host "`n🎯 Applied $successCount/$($settings.Count) settings successfully" @Green
}

function Restore-DefaultSettings {
    Write-Host "`n===== RESTORING DEFAULT SETTINGS =====" @Cyan
    Write-Host "===== KHOI PHUC CAI DAT MAC DINH =====" @Cyan
    
    $restoreSettings = @(
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "BingSearchEnabled"; Value = 1 },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "AllowSearchToUseLocation"; Value = 1 },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "CortanaEnabled"; Value = 0 },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Value = 2 },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "HistoryViewEnabled"; Value = 1 },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"; Name = "IsAADCloudSearchEnabled"; Value = 0 },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"; Name = "IsDeviceSearchHistoryEnabled"; Value = 1 },
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"; Name = "IsMSACloudSearchEnabled"; Value = 1 }
    )
    
    Write-Host "Restoring default registry values..." @Yellow
    foreach ($setting in $restoreSettings) {
        try {
            if (Test-Path $setting.Path) {
                Set-ItemProperty -Path $setting.Path -Name $setting.Name -Value $setting.Value -Force
                Write-Host "✅ Restored: $($setting.Name)" @Green
            }
        } catch {
            Write-Host "⚠️ Could not restore: $($setting.Name)" @Yellow
        }
    }
    
    # Remove policy restrictions
    Write-Host "Removing policy restrictions..." @Yellow
    try {
        Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "✅ Policy restrictions removed" @Green
    } catch {
        Write-Host "⚠️ Some policies could not be removed" @Yellow
    }
    
    Write-Host "`n✅ Default settings restored! Please restart Explorer." @Green
    Write-Host "✅ Cai dat mac dinh da khoi phuc! Vui long khoi dong lai Explorer." @Green
}

function Restart-Explorer {
    Write-Host "`n===== RESTARTING WINDOWS EXPLORER =====" @Yellow
    Write-Host "Refreshing taskbar and search interface..." @Yellow
    Write-Host "Lam moi taskbar va giao dien tim kiem..." @Yellow
    
    try {
        # Kill explorer and search processes
        Write-Host "Stopping Explorer and Search processes..." @Yellow
        Get-Process -Name "explorer" -ErrorAction SilentlyContinue | Stop-Process -Force
        Get-Process -Name "SearchUI" -ErrorAction SilentlyContinue | Stop-Process -Force
        Get-Process -Name "StartMenuExperienceHost" -ErrorAction SilentlyContinue | Stop-Process -Force
        
        Start-Sleep -Seconds 3
        
        # Restart explorer
        Write-Host "Restarting Explorer..." @Yellow
        Start-Process "explorer.exe"
        
        Start-Sleep -Seconds 2
        Write-Host "✅ Windows interface refreshed successfully" @Green
        Write-Host "✅ Giao dien Windows da duoc lam moi thanh cong" @Green
    } catch {
        Write-Host "⚠️ Please restart Windows Explorer manually (Ctrl+Shift+Esc → Explorer → Restart)" @Yellow
        Write-Host "⚠️ Vui long khoi dong lai Explorer thu cong" @Yellow
    }
}

function Show-Results {
    Write-Host @"

🎉 SEARCH OPTIMIZATION COMPLETED! / TOI UU TIM KIEM HOAN THANH!

📋 CHANGES APPLIED / THAY DOI DA AP DUNG:
┌─────────────────────────────────────────────────────┐
│ ✅ Web search ENABLED for convenience              │
│    Tim kiem web DUOC BAT de tien loi               │
│ ✅ Browser search integration MAINTAINED           │
│    Tich hop tim kiem trinh duyet DUOC GIU LAI      │
│ ✅ Cortana disabled (annoying features removed)    │
│    Cortana da tat (xoa tinh nang gay phen)         │
│ ✅ Search suggestions optimized                    │
│    Goi y tim kiem da toi uu                       │
│ ✅ Taskbar search shows ICON ONLY                  │
│    Tim kiem taskbar CHI HIEN THI ICON             │
│ ✅ Search history kept for better experience       │
│    Lich su tim kiem duoc giu lai de trai nghiem tot│
│ ✅ Privacy settings balanced                       │
│    Cai dat rieng tu duoc can bang                 │
│ ✅ Fast access to web results                      │
│    Truy cap nhanh ket qua web                     │
└─────────────────────────────────────────────────────┘

🔧 HOW TO USE / CACH SU DUNG:
• Click the search ICON on taskbar (compact design)
  Nhap vao ICON tim kiem tren taskbar (thiet ke gon gang)
• Press Win + S to open optimized search window
  Nhan Win + S de mo cua so tim kiem toi uu
• Type to search LOCAL FILES, APPLICATIONS, and WEB
  Go de tim kiem FILE LOCAL, UNG DUNG, va WEB
• Web results will open in your default browser
  Ket qua web se mo trong trinh duyet mac dinh
• Best of both worlds: local + web search together
  Ket hop tot nhat: tim kiem local + web cung luc

🔄 TO RESTORE / DE KHOI PHUC:
• Run: .\optimize-search.ps1 -Restore
• Or manually reset via Windows Settings
  Hoac dat lai thu cong qua Windows Settings

"@ @Green
}

# Main execution
if ($Help) {
    Show-Help
    exit
}

Write-Host @"
========================================
 Windows Search Optimization (Keep Web)
 Toi uu Windows Search (Giu lai Web)
========================================
"@ @Cyan

# Check admin rights
if (!(Test-AdminRights)) {
    Write-Host "❌ ERROR: This script requires Administrator privileges!" @Red
    Write-Host "LOI: Script nay can quyen Administrator!" @Red
    Write-Host "`nRight-click PowerShell and select 'Run as administrator'" @Yellow
    Write-Host "Nhap chuot phai PowerShell va chon 'Run as administrator'" @Yellow
    exit 1
}

if ($Restore) {
    Restore-DefaultSettings
    Restart-Explorer
    Write-Host "`nPress any key to exit..." @Yellow
    Read-Host
    exit
}

# Apply optimized settings
Optimize-WindowsSearchSettings

# Restart Explorer
Restart-Explorer

# Show results
Show-Results

Write-Host "`nConfiguration complete! Press any key to exit..." @Yellow
Read-Host
