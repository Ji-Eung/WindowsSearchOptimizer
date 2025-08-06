# 🔍 Windows Search Optimizer
**Tối ưu Windows Search (Giữ lại tìm kiếm web)**

## 📋 Mô tả / Description
Tool tối ưu Windows Search để có giao diện gọn gàng nhưng vẫn giữ lại khả năng tìm kiếm web và mở trình duyệt để tiết kiệm thời gian.

**English:** Optimizes Windows Search for a cleaner interface while keeping web search and browser integration for convenience.

## 🚀 Cách sử dụng / Usage

### Phương pháp đơn giản (Recommended):
1. **Right-click** file `run-optimize-search.bat`
2. Chọn **"Run as administrator"**
3. Chờ script hoàn thành

### Phương pháp PowerShell:
```powershell
# Mở PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\optimize-search.ps1
```

### Khôi phục cài đặt gốc:
```powershell
.\optimize-search.ps1 -Restore
```

## ✅ Những gì sẽ thay đổi / What Changes

### 🎯 Tối ưu được:
- ✅ **Taskbar search** chỉ hiển thị **ICON** (gọn gàng hơn)
- ✅ **Tắt Cortana** (loại bỏ tính năng phiền toái)
- ✅ **Giữ lại web search** (tiết kiệm thời gian tra cứu)
- ✅ **Giữ lại browser integration** (mở kết quả web trực tiếp)
- ✅ **Tắt location tracking** (bảo vệ privacy)
- ✅ **Cân bằng search history** (UX tốt hơn)

### 🌐 Giữ nguyên:
- ✅ **Bing search enabled** - tìm kiếm web nhanh
- ✅ **Cloud search** - đồng bộ với Microsoft account
- ✅ **Web search trong Start Menu** - tiện lợi
- ✅ **Search suggestions** - gợi ý thông minh
- ✅ **Browser integration** - mở kết quả trực tiếp

## 🔧 Kết quả mong đợi / Expected Results

**Trước khi dùng:**
- Taskbar có search box lớn, chiếm không gian
- Cortana luôn hiện và gây phiền toái
- Search có thể chậm do quá nhiều tính năng

**Sau khi dùng:**
- Taskbar gọn gàng với search icon nhỏ
- Không còn Cortana
- Vẫn search được web + local cùng lúc
- Kết quả web mở trực tiếp trong browser
- Tốc độ search được cải thiện

## 🛠️ Files trong thư mục

| File | Mô tả |
|------|-------|
| `optimize-search.ps1` | Script PowerShell chính |
| `run-optimize-search.bat` | File batch chạy với quyền admin |
| `README.md` | Hướng dẫn sử dụng |

## ⚠️ Lưu ý quan trọng

1. **Cần quyền Administrator** để thay đổi registry
2. **Windows Explorer sẽ restart** trong quá trình tối ưu
3. **Có thể khôi phục** bằng parameter `-Restore`
4. **Tương thích** với Windows 10/11

## 🔄 Troubleshooting

**Nếu gặp lỗi:**
1. Chạy PowerShell as Administrator
2. Kiểm tra `Set-ExecutionPolicy`
3. Đảm bảo đang chạy trên Windows 10/11

**Để khôi phục:**
```powershell
.\optimize-search.ps1 -Restore
```

---
**Made with ❤️ for better Windows Search experience**
