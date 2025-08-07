# WindowsSearchOptimizer v2025.1.2

### 🔧 Cho người dùng
- Chạy `cai-dat-tat-ca` với quyền Administrator để cài đặt chương trình.
- Chạy `go-bo-tat-ca` với quyền Administrator để khôi phục tất cả về cài đặt gốc.

### 🔧 Cho developer
- **Clone**: `git clone https://github.com/Ji-Eung/WindowsSearchOptimizer.git`
- **Build**: Chạy `WindowCenterApp/build/build.bat` trước khi sử dụng
- **Chạy trực tiếp**: `powershell -ExecutionPolicy Bypass -File "toi-uu-windows.ps1"`

**Bộ công cụ tối ưu WindowsSearch**

> 🚀 **Tải về sẵn sàng**: [Download phiên bản mới nhất](../../releases/latest) - Giải nén và chạy ngay!

## 🎯 Tính năng chính

✅ **Taskbar gọn gàng** - Chỉ hiển thị icon search thay vì ô to  
✅ **Start Menu căn giữa** - Luôn mở ở giữa màn hình  
✅ **Search window căn giữa** - Dễ nhìn và sử dụng  
✅ **Vẫn search web được** - Giữ nguyên tính năng tìm kiếm web  
✅ **Tắt Cortana** - Không còn bị làm phiền  
✅ **Hỗ trợ nhiều màn hình** - Hoạt động trên setup đa màn hình  
✅ **Tự động khởi động** - Có thể chạy cùng Windows (tùy chọn)  

## 🚀 Cách sử dụng

### 📦 Cài đặt (Khuyên dùng)
- **Tải về**: [WindowsSearchOptimizer-v2025.1.2.zip](../../releases/latest)
- **Giải nén** ở bất kỳ đâu
- **Chuột phải** vào `cai-dat-tat-ca.bat` → **"Chạy với quyền quản trị"**
- **Xong!** Tận hưởng Windows đã được tối ưu

### � Gỡ bỏ
- Chạy `go-bo-tat-ca.bat` với quyền Administrator để khôi phục tất cả về cài đặt gốc.

### �🔧 Cho developer
- **Clone**: `git clone https://github.com/Ji-Eung/WindowsSearchOptimizer.git`
- **Build**: Chạy `WindowCenterApp/build/build.bat` trước
- **Chạy trực tiếp**: `powershell -ExecutionPolicy Bypass -File "toi-uu-windows.ps1"`

## ⚙️ Yêu cầu hệ thống
- **Hệ điều hành**: Windows 10/11
- **Quyền**: Cần quyền Administrator
- **.NET 8.0**: Chỉ cần khi build từ source code

## 🔄 Gỡ bỏ dễ dàng
Chạy `go-bo-tat-ca.bat` với quyền Administrator để khôi phục tất cả về cài đặt gốc.

## ⚙️ Tùy chọn nâng cao

### 🔧 Chạy trực tiếp script PowerShell

### � Chạy trực tiếp script PowerShell
```powershell
# Cài đặt
powershell -ExecutionPolicy Bypass -File "toi-uu-windows.ps1"

# Gỡ bỏ 
powershell -ExecutionPolicy Bypass -File "toi-uu-windows.ps1" -Restore
```

### 📊 Thông tin kỹ thuật
- **Script chính**: `toi-uu-windows.ps1` - Gộp tất cả tính năng
- **Không xung đột**: Tất cả trong 1 file, tránh conflict
- **Dễ bảo trì**: Cấu trúc đơn giản, ít file rác

---

## 📁 Cấu trúc dự án (Đơn giản)

```
WindowsSearchOptimizer/
├── cai-dat-tat-ca.bat          # 🚀 Cài đặt tất cả (Chạy file này)
├── go-bo-tat-ca.bat            # 🗑️ Gỡ bỏ tất cả
├── toi-uu-windows.ps1          # 💎 Script chính All-in-One
├── README.md                   # File hướng dẫn này
│
└── WindowCenterApp/            # 🎯 Ứng dụng căn giữa cửa sổ
    ├── source/                 # Mã nguồn C#
    └── build/                  # Công cụ build (tạo AutoCenterMinimal.exe)
```

> ⚠️ **Lưu ý**: File `AutoCenterMinimal.exe` cần build từ source code vì quá lớn để đưa vào Git.

## 🎬 Trước và sau khi dùng

**Trước:**
- Taskbar có ô search to, chiếm chỗ
- Cửa sổ search mở bừa bãi
- Cortana hay xuất hiện làm phiền

**Sau:**
- Taskbar gọn với icon search nhỏ
- Cửa sổ search luôn ở giữa màn hình
- Vẫn search web bình thường
- Không còn Cortana
- Có thể tự động khởi động cùng Windows

## 🆘 Hỗ trợ

**Vấn đề thường gặp:**
- **Lỗi "Access denied"** → Chạy với quyền Administrator
- **Search không thay đổi** → Khởi động lại Explorer hoặc máy tính
- **App không chạy** → Kiểm tra antivirus/firewall

**Báo lỗi**: [Tạo issue mới](../../issues)

## 📝 Thông tin

- **Phiên bản**: 2025.1.2
- **Tương thích**: Windows 10/11
- **Ngôn ngữ**: Tiếng Việt
- **Miễn phí**: cho sử dụng cá nhân

---
# 🎯 Mục tiêu: Làm Windows đẹp hơn, gọn hơn, tiện hơn cho người Việt!
