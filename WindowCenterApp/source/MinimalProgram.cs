using System.Diagnostics;

namespace WindowManager
{
    /// <summary>
    /// Minimalist auto-center application - no UI, no hotkeys, just auto-centering
    /// Ứng dụng tự động căn giữa tối giản - không UI, không phím tắt, chỉ tự động căn giữa
    /// </summary>
    internal static class MinimalProgram
    {
        private static AutoCenterService? _service;
        private static NotifyIcon? _trayIcon;
        private static bool _shouldExit = false;

        [STAThread]
        static void Main()
        {
            // Enable visual styles for tray icon
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            // Check if already running
            if (IsAlreadyRunning())
            {
                MessageBox.Show(
                    "Auto-Center service is already running!\n" +
                    "Dịch vụ Auto-Center đã đang chạy!",
                    "Already Running / Đã Chạy",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information
                );
                return;
            }

            // Create and start the service
            _service = new AutoCenterService();
            _service.OnWindowCentered += OnWindowCentered;
            _service.OnError += OnError;

            // Create system tray icon
            CreateTrayIcon();

            // Start the service
            if (_service.Start())
            {
                ShowTrayMessage("Auto-Center Started", 
                    "Windows Start and Search will now auto-center\n" +
                    "Start Menu và Search sẽ tự động căn giữa");

                // Run the application loop
                Application.Run();
            }
            else
            {
                MessageBox.Show(
                    "Failed to start Auto-Center service!\n" +
                    "Không thể khởi động dịch vụ Auto-Center!\n\n" +
                    "Please run as Administrator.\n" +
                    "Vui lòng chạy với quyền Administrator.",
                    "Service Failed / Dịch Vụ Thất Bại",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                );
            }

            // Cleanup
            _service?.Dispose();
            _trayIcon?.Dispose();
        }

        /// <summary>
        /// Create system tray icon for minimal control
        /// Tạo icon system tray để điều khiển tối giản
        /// </summary>
        private static void CreateTrayIcon()
        {
            _trayIcon = new NotifyIcon();
            
            // Create a simple icon (you can replace this with a proper .ico file)
            _trayIcon.Icon = CreateSimpleIcon();
            _trayIcon.Text = "Auto-Center Service - Windows Start & Search";
            _trayIcon.Visible = true;

            // Create context menu
            var contextMenu = new ContextMenuStrip();
            
            contextMenu.Items.Add("Status: Running", null, (s, e) => ShowStatus());
            contextMenu.Items.Add("-"); // Separator
            contextMenu.Items.Add("Manual Center Start Menu", null, (s, e) => ManualCenterStartMenu());
            contextMenu.Items.Add("Manual Center Search", null, (s, e) => ManualCenterSearch());
            contextMenu.Items.Add("-"); // Separator
            contextMenu.Items.Add("Show Debug Info", null, (s, e) => ShowDebugInfo());
            contextMenu.Items.Add("-"); // Separator
            contextMenu.Items.Add("Show Info / Hiển thị thông tin", null, (s, e) => ShowInfo());
            contextMenu.Items.Add("-"); // Separator
            contextMenu.Items.Add("Exit / Thoát", null, (s, e) => ExitApplication());

            _trayIcon.ContextMenuStrip = contextMenu;
            
            // Double-click to show status
            _trayIcon.DoubleClick += (s, e) => ShowStatus();
        }

        /// <summary>
        /// Create a simple icon for the tray
        /// Tạo icon đơn giản cho tray
        /// </summary>
        private static Icon CreateSimpleIcon()
        {
            var bitmap = new Bitmap(16, 16);
            using (var g = Graphics.FromImage(bitmap))
            {
                g.Clear(Color.Transparent);
                g.FillEllipse(Brushes.DodgerBlue, 2, 2, 12, 12);
                g.FillEllipse(Brushes.White, 5, 5, 6, 6);
            }
            return Icon.FromHandle(bitmap.GetHicon());
        }

        /// <summary>
        /// Manually center Start Menu
        /// Căn giữa Start Menu thủ công
        /// </summary>
        private static void ManualCenterStartMenu()
        {
            _service?.TryFindAndCenterStartMenu();
            ShowTrayMessage("Manual Center", "Attempted to center Start Menu manually");
        }

        /// <summary>
        /// Manually center Search window
        /// Căn giữa Search window thủ công
        /// </summary>
        private static void ManualCenterSearch()
        {
            // Try to find and center current foreground window if it's search
            IntPtr foreground = WindowAPI.GetForegroundWindow();
            if (foreground != IntPtr.Zero)
            {
                string className = WindowAPI.GetWindowClassName(foreground);
                string title = WindowAPI.GetWindowText(foreground);
                
                if (className.Contains("Search", StringComparison.OrdinalIgnoreCase) ||
                    title.Contains("Search", StringComparison.OrdinalIgnoreCase) ||
                    className.Contains("Cortana", StringComparison.OrdinalIgnoreCase))
                {
                    if (WindowAPI.CenterWindow(foreground))
                    {
                        ShowTrayMessage("Manual Center", $"Centered Search window: {className}");
                        return;
                    }
                }
            }
            
            ShowTrayMessage("Manual Center", "No Search window found to center");
        }

        /// <summary>
        /// Show debug information
        /// Hiển thị thông tin debug
        /// </summary>
        private static void ShowDebugInfo()
        {
            IntPtr foreground = WindowAPI.GetForegroundWindow();
            string info = "Debug Information:\n\n";
            
            if (foreground != IntPtr.Zero)
            {
                string className = WindowAPI.GetWindowClassName(foreground);
                string title = WindowAPI.GetWindowText(foreground);
                
                if (WindowAPI.GetWindowRect(foreground, out WindowAPI.RECT rect))
                {
                    info += $"Current Window:\n";
                    info += $"Class: {className}\n";
                    info += $"Title: {title}\n";
                    info += $"Size: {rect.Width}x{rect.Height}\n";
                    info += $"Position: ({rect.Left}, {rect.Top})\n\n";
                }
            }
            
            info += $"Service Status: {(_service?.IsRunning == true ? "Running" : "Stopped")}\n";
            info += $"Process ID: {System.Diagnostics.Process.GetCurrentProcess().Id}";
            
            MessageBox.Show(info, "Debug Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        private static void ShowStatus()
        {
            string status = _service?.IsRunning == true ? "Running / Đang chạy" : "Stopped / Đã dừng";
            MessageBox.Show(
                $"Auto-Center Service Status: {status}\n\n" +
                "Functions / Chức năng:\n" +
                "• Auto-center Windows Start Menu\n" +
                "• Auto-center Windows Search\n\n" +
                "No hotkeys, no manual controls - fully automatic!\n" +
                "Không phím tắt, không điều khiển thủ công - hoàn toàn tự động!",
                "Service Status / Trạng thái dịch vụ",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information
            );
        }

        /// <summary>
        /// Show application info
        /// Hiển thị thông tin ứng dụng
        /// </summary>
        private static void ShowInfo()
        {
            MessageBox.Show(
                "Minimal Auto-Center Service v1.0\n" +
                "Dịch vụ Auto-Center Tối giản v1.0\n\n" +
                "Purpose / Mục đích:\n" +
                "Automatically center Windows Start Menu and Search\n" +
                "Tự động căn giữa Windows Start Menu và Search\n\n" +
                "Features / Tính năng:\n" +
                "• No UI clutter / Không giao diện rối\n" +
                "• No hotkeys / Không phím tắt\n" +
                "• Runs in background / Chạy ngầm\n" +
                "• System tray control / Điều khiển qua system tray\n\n" +
                "Requirements / Yêu cầu:\n" +
                "• Windows 10/11\n" +
                "• Administrator privileges / Quyền Administrator",
                "About / Giới thiệu",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information
            );
        }

        /// <summary>
        /// Exit the application
        /// Thoát ứng dụng
        /// </summary>
        private static void ExitApplication()
        {
            var result = MessageBox.Show(
                "Exit Auto-Center Service?\n" +
                "Thoát dịch vụ Auto-Center?\n\n" +
                "Windows Start and Search will no longer auto-center.\n" +
                "Start Menu và Search sẽ không còn tự động căn giữa.",
                "Exit Confirmation / Xác nhận thoát",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question
            );

            if (result == DialogResult.Yes)
            {
                _shouldExit = true;
                _trayIcon.Visible = false;
                Application.Exit();
            }
        }

        /// <summary>
        /// Check if application is already running
        /// Kiểm tra xem ứng dụng đã chạy chưa
        /// </summary>
        private static bool IsAlreadyRunning()
        {
            var currentProcess = Process.GetCurrentProcess();
            var processes = Process.GetProcessesByName(currentProcess.ProcessName);
            return processes.Length > 1;
        }

        /// <summary>
        /// Show tray notification message
        /// Hiển thị thông báo tray
        /// </summary>
        private static void ShowTrayMessage(string title, string message)
        {
            _trayIcon?.ShowBalloonTip(3000, title, message, ToolTipIcon.Info);
        }

        /// <summary>
        /// Handle window centered events
        /// Xử lý sự kiện cửa sổ được căn giữa
        /// </summary>
        private static void OnWindowCentered(string message)
        {
            Debug.WriteLine($"[Auto-Center] {message}");
            // Optionally show brief tray notification for first few times
            // Can be disabled for completely silent operation
        }

        /// <summary>
        /// Handle error events
        /// Xử lý sự kiện lỗi
        /// </summary>
        private static void OnError(string error)
        {
            Debug.WriteLine($"[Auto-Center Error] {error}");
            
            // Show error in tray (user can disable this for silent operation)
            _trayIcon?.ShowBalloonTip(5000, "Auto-Center Error", error, ToolTipIcon.Error);
        }
    }
}
