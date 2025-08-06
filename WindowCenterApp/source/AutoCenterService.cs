using System.Text;

namespace WindowManager
{
    /// <summary>
    /// Minimalist service for auto-centering Windows Start and Search only
    /// Dịch vụ tối giản chỉ tự động căn giữa Windows Start và Search
    /// </summary>
    public class AutoCenterService
    {
        #region Fields

        private IntPtr _winEventHook = IntPtr.Zero;
        private WindowAPI.WinEventDelegate? _winEventDelegate;
        private bool _isRunning = false;

        // Only track Start Menu and Search windows
        private readonly string[] StartMenuClasses = 
        {
            "DV2ControlHost",               // Windows 10 Start Menu
            "Windows.UI.Core.CoreWindow",   // Windows 11 Start Menu  
            "StartMenuExperienceHost",      // Windows 11 Start Menu Host
            "Microsoft.Windows.StartMenuExperienceHost", // Full Start Menu class
            "ApplicationFrameHost",         // Start Menu container
            "Windows.Internal.Shell.Exp.StartMenu",      // Internal Start Menu
            "Shell_TrayWnd",               // Taskbar window
            "StartMenu",                   // Direct Start Menu
            "ImmersiveShell",              // Immersive Start Menu
            "Progman"                      // Program Manager (fallback)
        };

        private readonly string[] SearchClasses = 
        {
            "Windows.UI.Core.CoreWindow",   // Search window
            "SearchHost",                   // Search host
            "CortanaUI",                    // Cortana/Search UI
            "Microsoft.Windows.Cortana",   // Cortana window
            "SearchApp"                     // Search application
        };

        #endregion

        #region Events

        public event Action<string>? OnWindowCentered;
        public event Action<string>? OnError;

        #endregion

        #region Public Methods

        /// <summary>
        /// Start the auto-centering service
        /// Bắt đầu dịch vụ tự động căn giữa
        /// </summary>
        public bool Start()
        {
            if (_isRunning) return true;

            try
            {
                // Create event delegate
                _winEventDelegate = WinEventProc;

                // Hook window events for foreground changes
                _winEventHook = WindowAPI.SetWinEventHook(
                    WindowAPI.EVENT_SYSTEM_FOREGROUND,
                    WindowAPI.EVENT_SYSTEM_FOREGROUND,
                    IntPtr.Zero,
                    _winEventDelegate,
                    0, 0,
                    WindowAPI.WINEVENT_OUTOFCONTEXT | WindowAPI.WINEVENT_SKIPOWNPROCESS
                );

                if (_winEventHook == IntPtr.Zero)
                {
                    OnError?.Invoke("Failed to set window event hook");
                    return false;
                }

                _isRunning = true;
                OnWindowCentered?.Invoke("Auto-centering service started successfully");
                return true;
            }
            catch (Exception ex)
            {
                OnError?.Invoke($"Failed to start service: {ex.Message}");
                return false;
            }
        }

        /// <summary>
        /// Stop the auto-centering service
        /// Dừng dịch vụ tự động căn giữa
        /// </summary>
        public void Stop()
        {
            if (!_isRunning) return;

            try
            {
                if (_winEventHook != IntPtr.Zero)
                {
                    WindowAPI.UnhookWinEvent(_winEventHook);
                    _winEventHook = IntPtr.Zero;
                }

                _winEventDelegate = null;
                _isRunning = false;
                OnWindowCentered?.Invoke("Auto-centering service stopped");
            }
            catch (Exception ex)
            {
                OnError?.Invoke($"Error stopping service: {ex.Message}");
            }
        }

        /// <summary>
        /// Check if service is running
        /// Kiểm tra xem dịch vụ có đang chạy không
        /// </summary>
        public bool IsRunning => _isRunning;

        #endregion

        #region Private Methods

        /// <summary>
        /// Window event callback
        /// Callback sự kiện cửa sổ
        /// </summary>
        private void WinEventProc(IntPtr hWinEventHook, uint eventType, IntPtr hwnd, int idObject, int idChild, uint dwEventThread, uint dwmsEventTime)
        {
            if (eventType == WindowAPI.EVENT_SYSTEM_FOREGROUND && hwnd != IntPtr.Zero)
            {
                // Log all window changes for debugging
                string className = WindowAPI.GetWindowClassName(hwnd);
                string title = WindowAPI.GetWindowText(hwnd);
                System.Diagnostics.Debug.WriteLine($"🔍 Window changed: {className} - '{title}'");
                
                // Small delay to ensure window is fully loaded
                Task.Delay(150).ContinueWith(_ => ProcessWindow(hwnd));
            }
        }

        /// <summary>
        /// Process and potentially center a window
        /// Xử lý và có thể căn giữa cửa sổ
        /// </summary>
        private void ProcessWindow(IntPtr hwnd)
        {
            try
            {
                if (!WindowAPI.IsWindowVisible(hwnd)) return;

                string className = WindowAPI.GetWindowClassName(hwnd);
                string title = WindowAPI.GetWindowText(hwnd);

                // Check if it's Start Menu
                if (IsStartMenu(hwnd, className, title))
                {
                    if (WindowAPI.CenterWindow(hwnd))
                    {
                        OnWindowCentered?.Invoke($"Centered Start Menu: {className}");
                    }
                    return;
                }

                // Check if it's Search window
                if (IsSearchWindow(hwnd, className, title))
                {
                    if (WindowAPI.CenterWindow(hwnd))
                    {
                        OnWindowCentered?.Invoke($"Centered Search: {className}");
                    }
                    return;
                }
            }
            catch (Exception ex)
            {
                OnError?.Invoke($"Error processing window: {ex.Message}");
            }
        }

        /// <summary>
        /// Check if window is Start Menu
        /// Kiểm tra xem cửa sổ có phải Start Menu không
        /// </summary>
        private bool IsStartMenu(IntPtr hwnd, string className, string title)
        {
            // Method 1: Check class names
            foreach (var startClass in StartMenuClasses)
            {
                if (className.Equals(startClass, StringComparison.OrdinalIgnoreCase))
                {
                    System.Diagnostics.Debug.WriteLine($"✅ Start Menu detected by class: {startClass}");
                    
                    // Additional validation for CoreWindow (used by many apps)
                    if (startClass == "Windows.UI.Core.CoreWindow")
                    {
                        bool isValid = ValidateStartMenuSize(hwnd) || HasStartMenuCharacteristics(title);
                        System.Diagnostics.Debug.WriteLine($"🔍 CoreWindow validation: {isValid}");
                        return isValid;
                    }
                    return true;
                }
            }

            // Method 2: Check title patterns (case insensitive)
            var titlePatterns = new[] { "start", "menu", "démarrer", "开始", "スタート", "меню" };
            foreach (var pattern in titlePatterns)
            {
                if (title.Contains(pattern, StringComparison.OrdinalIgnoreCase))
                {
                    System.Diagnostics.Debug.WriteLine($"✅ Start Menu detected by title: '{title}' contains '{pattern}'");
                    return true;
                }
            }

            // Method 3: Check for specific Start Menu window properties
            if (className.Contains("Shell", StringComparison.OrdinalIgnoreCase) ||
                className.Contains("Start", StringComparison.OrdinalIgnoreCase) ||
                className.Contains("Menu", StringComparison.OrdinalIgnoreCase))
            {
                if (WindowAPI.GetWindowRect(hwnd, out WindowAPI.RECT rect))
                {
                    // Start Menu typically appears in a reasonable size range
                    int width = rect.Width;
                    int height = rect.Height;
                    if (width >= 200 && width <= 1200 && height >= 300 && height <= 1000)
                    {
                        System.Diagnostics.Debug.WriteLine($"✅ Start Menu detected by Shell pattern + size: {width}x{height}");
                        return true;
                    }
                }
            }

            return false;
        }

        /// <summary>
        /// Check if window is Search window
        /// Kiểm tra xem cửa sổ có phải Search window không
        /// </summary>
        private bool IsSearchWindow(IntPtr hwnd, string className, string title)
        {
            // Check class names
            foreach (var searchClass in SearchClasses)
            {
                if (className.Equals(searchClass, StringComparison.OrdinalIgnoreCase))
                {
                    // Additional validation for CoreWindow
                    if (searchClass == "Windows.UI.Core.CoreWindow")
                    {
                        return HasSearchCharacteristics(title);
                    }
                    return true;
                }
            }

            // Check title patterns
            var titlePatterns = new[] { "search", "cortana", "recherche", "搜索", "検索" };
            foreach (var pattern in titlePatterns)
            {
                if (title.Contains(pattern, StringComparison.OrdinalIgnoreCase))
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// Validate Start Menu by size
        /// Xác thực Start Menu bằng kích thước
        /// </summary>
        private bool ValidateStartMenuSize(IntPtr hwnd)
        {
            if (WindowAPI.GetWindowRect(hwnd, out WindowAPI.RECT rect))
            {
                int width = rect.Width;
                int height = rect.Height;
                
                // Start Menu typical dimensions: 300-1000px wide, 400-1200px tall
                bool isValidSize = width >= 300 && width <= 1000 && height >= 400 && height <= 1200;
                System.Diagnostics.Debug.WriteLine($"📐 Window size: {width}x{height}, Valid: {isValidSize}");
                return isValidSize;
            }
            return false;
        }

        /// <summary>
        /// Try to find Start Menu manually when it opens
        /// Thử tìm Start Menu thủ công khi nó mở
        /// </summary>
        public void TryFindAndCenterStartMenu()
        {
            System.Diagnostics.Debug.WriteLine("🔍 Manually searching for Start Menu...");
            
            // Method 1: Search by known class names
            foreach (var className in StartMenuClasses)
            {
                IntPtr hWnd = WindowAPI.FindWindow(className, null);
                if (hWnd != IntPtr.Zero && WindowAPI.IsWindowVisible(hWnd))
                {
                    System.Diagnostics.Debug.WriteLine($"📋 Found Start Menu by class: {className}");
                    if (WindowAPI.CenterWindow(hWnd))
                    {
                        OnWindowCentered?.Invoke($"Manually centered Start Menu: {className}");
                        return;
                    }
                }
            }
            
            // Method 2: Search by window title
            var titles = new[] { "Start", "Start menu", "Menu démarrer" };
            foreach (var title in titles)
            {
                IntPtr hWnd = WindowAPI.FindWindow(null, title);
                if (hWnd != IntPtr.Zero && WindowAPI.IsWindowVisible(hWnd))
                {
                    System.Diagnostics.Debug.WriteLine($"📋 Found Start Menu by title: {title}");
                    if (WindowAPI.CenterWindow(hWnd))
                    {
                        OnWindowCentered?.Invoke($"Manually centered Start Menu by title: {title}");
                        return;
                    }
                }
            }
            
            System.Diagnostics.Debug.WriteLine("❌ Could not find Start Menu manually");
        }

        /// <summary>
        /// Check for Start Menu characteristics in title
        /// Kiểm tra đặc điểm Start Menu trong tiêu đề
        /// </summary>
        private bool HasStartMenuCharacteristics(string title)
        {
            if (string.IsNullOrEmpty(title)) return false;
            
            var indicators = new[] { "start", "menu", "programs", "apps", "applications" };
            return indicators.Any(indicator => title.Contains(indicator, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// Check for Search characteristics in title
        /// Kiểm tra đặc điểm Search trong tiêu đề
        /// </summary>
        private bool HasSearchCharacteristics(string title)
        {
            if (string.IsNullOrEmpty(title)) return false;
            
            var indicators = new[] { "search", "cortana", "find", "query" };
            return indicators.Any(indicator => title.Contains(indicator, StringComparison.OrdinalIgnoreCase));
        }

        #endregion

        #region IDisposable

        public void Dispose()
        {
            Stop();
        }

        #endregion
    }
}
