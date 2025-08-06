# 🖥️ Tối ưu Windows Search và Desktop
**Bộ công cụ tối ưu Windows cho người Việt**

> 🚀 **Tải về sẵn sàng**: [Download phiên bản mới nhất](../../releases/latest) - Giải nén và chạy ngay!

## 🎯 Tính năng chính

### 🔍 Tối ưu Windows Search
- ✅ **Taskbar gọn gàng** - Chỉ hiển thị icon thay vì ô search to
- ✅ **Vẫn search web được** - Giữ nguyên tính năng tìm kiếm web
- ✅ **Tắt Cortana** - Không còn bị làm phiền
- ✅ **Bảo mật hợp lý** - Cân bằng privacy và tiện ích

### 🎯 Tự động căn giữa cửa sổ
- ✅ **Start Menu luôn ở giữa** - Đẹp và cân đối
- ✅ **Search window ở giữa** - Dễ nhìn và sử dụng
- ✅ **Hỗ trợ nhiều màn hình** - Hoạt động trên setup đa màn hình
- ✅ **Chạy nền tự động** - Không cần thao tác gì

## 🚀 Cách sử dụng

### 📦 Cho người dùng thông thường (Khuyên dùng)
1. **Tải về**: [WindowsSearchOptimizer-Ready-v2025.1.1.zip](../../releases/latest)
2. **Giải nén** ở bất kỳ đâu
3. **Chuột phải** vào `cai-dat-tat-ca.bat` → **"Chạy với quyền quản trị"**
4. **Xong!** Tận hưởng Windows đã được tối ưu

### 🔧 Cho developer
- **Clone**: `git clone https://github.com/Ji-Eung/WindowsSearchOptimizer.git`
- **Build**: Chạy `WindowCenterApp/build/build.bat` trước
- **Contribute**: Hoan nghênh PRs và issues!

## ⚙️ Yêu cầu hệ thống
- **Hệ điều hành**: Windows 10/11
- **Quyền**: Cần quyền Administrator
- **.NET 8.0**: Chỉ cần khi build từ source code

## 🔄 Gỡ bỏ dễ dàng
Chạy `go-bo-tat-ca.bat` với quyền Administrator để khôi phục tất cả về cài đặt gốc.

---

## 📁 Cấu trúc dự án

```
WindowsSearchOptimizer/
├── cai-dat-tat-ca.bat          # 🚀 Cài đặt tất cả (Chạy file này)
├── go-bo-tat-ca.bat            # 🗑️ Gỡ bỏ tất cả
├── README.md                   # File hướng dẫn này
│
├── SearchOptimizer/            # 🔍 Tối ưu Windows Search
│   ├── optimize-search.ps1     # Script PowerShell chính
│   ├── chay-toi-uu-search.bat  # File chạy tối ưu search
│   └── README.md               # Hướng dẫn chi tiết
│
└── WindowCenterApp/            # 🎯 Tự động căn giữa cửa sổ
    ├── AutoCenterMinimal.exe   # Ứng dụng chính
    ├── chay-voi-quyen-admin.bat # File chạy với quyền admin
    ├── README.md               # Hướng dẫn chi tiết
    ├── source/                 # Mã nguồn C#
    └── build/                  # Công cụ build
```

## 🎬 Trước và sau khi dùng

**Trước:**
- Taskbar có ô search to, chiếm chỗ
- Start Menu mở ở góc màn hình
- Cửa sổ search mở bừa bãi
- Cortana hay xuất hiện làm phiền

**Sau:**
- Taskbar gọn với icon search nhỏ
- Start Menu luôn mở ở giữa màn hình
- Cửa sổ search luôn ở giữa màn hình
- Vẫn search web bình thường
- Không còn Cortana

## 🆘 Hỗ trợ

**Vấn đề thường gặp:**
- **Lỗi "Access denied"** → Chạy với quyền Administrator
- **Search không thay đổi** → Khởi động lại Explorer hoặc máy tính
- **App không chạy** → Kiểm tra antivirus/firewall

**Báo lỗi**: [Tạo issue mới](../../issues)

## 📝 Thông tin

- **Phiên bản**: 2025.1.1
- **Tương thích**: Windows 10/11
- **Ngôn ngữ**: Tiếng Việt
- **Miễn phí** cho sử dụng cá nhân

---
# 🎯 Mục tiêu: Làm Windows đẹp hơn, gọn hơn, tiện hơn cho người Việt!
