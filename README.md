# 🖥️ WindowsSearchOptimizer
**Bộ công cụ tối ưu Windows Search**

## 📋 Tổng quan

Bộ công cụ gồm 2 ứng dụng giúp tối ưu trải nghiệm sử dụng Windows:

1. **🔍 SearchOptimizer** - Tối ưu Windows Search (giữ lại web search)
2. **🎯 WindowCenterApp** - Tự động căn giữa Start Menu và Search

## 🎯 Mục tiêu

- ✅ **Giao diện gọn gàng** - Taskbar search chỉ hiển thị icon
- ✅ **Giữ tiện ích** - Vẫn có web search và browser integration  
- ✅ **Căn giữa tự động** - Start Menu và Search luôn ở giữa màn hình
- ✅ **Dễ sử dụng** - Setup đơn giản, chạy tự động
- ✅ **Có thể khôi phục** - Dễ dàng quay về cài đặt gốc

## 📁 Cấu trúc dự án

```
Windows/
├── setup-everything.bat       # 🚀 Setup toàn bộ (Recommended)
├── uninstall-everything.bat   # 🗑️ Gỡ bỏ toàn bộ
├── README.md                  # File này - hướng dẫn tổng hợp
│
├── SearchOptimizer/           # 🔍 Windows Search Optimization
│   ├── optimize-search.ps1    # PowerShell script chính
│   ├── run-optimize-search.bat # Batch runner
│   └── README.md              # Hướng dẫn Search Optimizer
│
└── WindowCenterApp/           # 🎯 Window Auto-Centering
    ├── AutoCenterMinimal.exe  # Ứng dụng chính (cần build từ source)
    ├── run-as-admin.bat       # Admin runner
    ├── README.md              # Hướng dẫn Window Center
    ├── source/                # Source code C#
    │   ├── AutoCenterService.cs
    │   ├── MinimalProgram.cs
    │   ├── WindowAPI.cs
    │   └── AutoCenterMinimal.csproj
    └── build/                 # Build tools
        └── build.bat
```

## 🚀 Hướng dẫn cài đặt nhanh

### ⚠️ **Lưu ý quan trọng:**
**WindowCenterApp cần build từ source code do GitHub file size limit**

### Cách 1: Setup toàn bộ (Recommended)
```cmd
# Bước 1: Build WindowCenterApp
cd WindowCenterApp/build
build.bat

# Bước 2: Setup everything
cd ../../
Right-click/Chuột phải "setup-everything.bat" → "Run as administrator"
```

### Cách 2: Setup từng phần
**Bước 1: Build WindowCenterApp**
```cmd
cd WindowCenterApp/build
build.bat
```

**Bước 2: Tối ưu Windows Search**
```cmd
cd ../../SearchOptimizer
Right-click/Chuột phải "run-optimize-search.bat" → "Run as administrator"
```

**Bước 3: Chạy Window Center App**  
```cmd
cd ../WindowCenterApp
Right-click/Chuột phải "run-as-admin.bat" → "Run as administrator"
```

### Gỡ bỏ toàn bộ:
```
Right-click/Chuột phải "uninstall-everything.bat" → "Run as administrator"
```

## ✅ Tính năng tổng hợp

### 🔍 Tối ưu Search (SearchOptimizer):
- ✅ **Compact taskbar** - Search icon thay vì search box
- ✅ **Web search enabled** - Vẫn search được web
- ✅ **Browser integration** - Mở kết quả trực tiếp browser
- ✅ **Cortana disabled** - Tắt tính năng phiền toái
- ✅ **Privacy balanced** - Cân bằng privacy và tiện ích

### 🎯 Tự động căn giữa (WindowCenterApp):
- ✅ **Start Menu centering** - Tự động căn giữa Start Menu
- ✅ **Search centering** - Tự động căn giữa Windows Search
- ✅ **Multi-monitor support** - Hỗ trợ nhiều màn hình
- ✅ **Manual controls** - Có thể căn giữa thủ công
- ✅ **System tray interface** - Giao diện tối giản

## 🎬 Demo và cách hoạt động

**Trước khi dùng:**
- Taskbar có search box to, chiếm chỗ
- Start Menu mở ở góc, không cân đối
- Search window mở ở vị trí ngẫu nhiên
- Cortana hay xuất hiện gây phiền

**Sau khi dùng:**
- Taskbar gọn với search icon nhỏ
- Start Menu luôn ở giữa màn hình
- Search window luôn ở giữa màn hình  
- Không còn Cortana
- Vẫn search web được bình thường

## ⚙️ Cài đặt nâng cao

### Tùy chỉnh Search Optimizer:
```powershell
# Chỉ xem thông tin, không áp dụng
.\optimize-search.ps1 -Help

# Khôi phục cài đặt gốc
.\optimize-search.ps1 -Restore
```

### Tùy chỉnh Window Center:
- Right-click system tray icon để access menu
- "Manual Center" để căn giữa thủ công
- "Show Debug Info" để kiểm tra hoạt động

## 🔄 Gỡ bỏ và khôi phục

### Khôi phục Search Optimizer:
```powershell
cd SearchOptimizer
.\optimize-search.ps1 -Restore
```

### Tắt Window Center:
- Right-click system tray icon → "Exit"
- Hoặc kill process "AutoCenterMinimal.exe"

## ⚠️ Yêu cầu hệ thống

- **OS:** Windows 10/11
- **Privileges:** Administrator rights
- **Framework:** .NET 8.0 SDK (để build WindowCenterApp)
- **PowerShell:** 5.1+ (cho SearchOptimizer)

### 📋 Yêu cầu setup:
1. **Install .NET 8.0 SDK** từ [Microsoft .NET](https://dotnet.microsoft.com/download)
2. **Chạy build.bat** để tạo AutoCenterMinimal.exe
3. **Run as Administrator** cho tất cả scripts

## 🆘 Hỗ trợ

**Vấn đề thường gặp:**

1. **"Access denied" errors** → Chạy as Administrator
2. **Search không thay đổi** → Restart Explorer hoặc reboot
3. **App không khởi động** → Kiểm tra antivirus/firewall
4. **Window không căn giữa** → Thử manual center từ tray menu

**Debug info:**
- WindowCenterApp có debug menu trong system tray
- SearchOptimizer có verbose output khi chạy

## 📝 License & Credits

- **License:** Free for personal use
- **Made with:** PowerShell, C#, Windows API
- **Compatibility:** Windows 10/11
- **Version:** 2025.1

---
# 🎯 Mục tiêu: Làm cho Windows đẹp hơn, gọn hơn, tiện hơn!