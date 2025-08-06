# 🚀 Quick GitHub Upload Guide
## Hướng dẫn nhanh đưa lên GitHub

### ⚡ Các bước thực hiện:

#### 1. Tạo release package
```cmd
# Chạy script tự động
create-release.bat

# Hoặc manual tạo PowerShell
powershell -ExecutionPolicy Bypass -File create-release.ps1 -Version "1.0"
```

#### 2. Kiểm tra package
- Folder `Release/WindowsSearchOptimizer-Ready-v1.0/`
- File ZIP: `WindowsSearchOptimizer-Ready-v1.0.zip`
- Test extract ZIP và chạy `setup-everything.bat`

#### 3. Setup Git repository
```bash
# Trong folder dự án
git init
git add .
git commit -m "Initial release v1.0"

# Tạo repo trên GitHub và connect
git remote add origin https://github.com/[YOUR-USERNAME]/WindowsSearchOptimizer.git
git branch -M main
git push -u origin main
```

#### 4. Tạo GitHub Release
1. Vào GitHub repo → **Releases** → **Create a new release**
2. **Tag**: `v1.0.0`
3. **Title**: `Windows Search Optimizer v1.0 - Ready to Use`  
4. **Description**: Copy từ template trong `GITHUB-RELEASE-GUIDE.md`
5. **Attach file**: Upload file `WindowsSearchOptimizer-Ready-v1.0.zip`
6. **Publish release**

#### 5. Cập nhật links
- Cập nhật download links trong README.md
- Test download link hoạt động

### ✅ Checklist cuối:
- [ ] Release package test OK
- [ ] GitHub repo created
- [ ] Source code pushed  
- [ ] GitHub Release created với ZIP file
- [ ] Download links work
- [ ] README.md updated

### 🎯 Tips:
- **Repository name**: `WindowsSearchOptimizer` 
- **Visibility**: Public
- **License**: Tùy chọn (MIT, GPL, etc.)
- **Description**: "Optimize Windows Search and auto-center Start Menu"

---
**Ready to share with the world! 🌍**
