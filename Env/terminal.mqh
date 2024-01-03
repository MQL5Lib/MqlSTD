#include "../memory.mqh"
#include "../pattern.mqh"

#define _stdTerminal STDSingleton<STDTerminal>::Inst()

class STDTerminal{
public:
   static bool IsCommunityAccount() {return (bool)Get(TERMINAL_COMMUNITY_ACCOUNT);}
   static bool IsCommunityConnection() {return (bool)Get(TERMINAL_COMMUNITY_CONNECTION);}
   static bool IsConnected() {return (bool)Get(TERMINAL_CONNECTED);}
   static bool IsDllAlloed() {return (bool)Get(TERMINAL_DLLS_ALLOWED);}
   static bool IsTradeAlloed() {return (bool)Get(TERMINAL_TRADE_ALLOWED);}
   static bool IsEmailEnabled() {return (bool)Get(TERMINAL_EMAIL_ENABLED);}
   static bool IsFtpEnabled() {return (bool)Get(TERMINAL_FTP_ENABLED);}
   static bool IsNotificationEnabled() {return (bool)Get(TERMINAL_NOTIFICATIONS_ENABLED);}
   static bool HasMqId() {return (bool)Get(TERMINAL_MQID);}
   static bool IsX64() {return (bool)Get(TERMINAL_X64);}
   static bool IsVps() {return (bool)Get(TERMINAL_VPS);}
   
   static int Build() {return (int)Get(TERMINAL_BUILD);}
   static int MaxBars() {return (int)Get(TERMINAL_MAXBARS);}
   static int Codepage() {return (int)Get(TERMINAL_CODEPAGE);}
   static int CpuCores() {return (int)Get(TERMINAL_CPU_CORES);}
   static int DiskSpace() {return (int)Get(TERMINAL_DISK_SPACE);}
   static int MemoryPhisical() {return (int)Get(TERMINAL_MEMORY_PHYSICAL);}
   static int MemoryTotal() {return (int)Get(TERMINAL_MEMORY_TOTAL);}
   static int MemoryAvailable() {return (int)Get(TERMINAL_MEMORY_AVAILABLE);}
   static int MemoryUsed() {return (int)Get(TERMINAL_MEMORY_USED);}
   static int OpenClSupport() {return (int)Get(TERMINAL_OPENCL_SUPPORT);}
   static int ScreenDpi() {return (int)Get(TERMINAL_SCREEN_DPI);}
   static int ScreenLeft() {return (int)Get(TERMINAL_SCREEN_LEFT);}
   static int ScreenTop() {return (int)Get(TERMINAL_SCREEN_TOP);}
   static int ScreenHeight() {return (int)Get(TERMINAL_SCREEN_HEIGHT);}
   static int ScreenWidth() {return (int)Get(TERMINAL_SCREEN_WIDTH);}
   static int Left() {return (int)Get(TERMINAL_LEFT);}
   static int Top() {return (int)Get(TERMINAL_TOP);}
   static int Right() {return (int)Get(TERMINAL_RIGHT);}
   static int Bottom() {return (int)Get(TERMINAL_BOTTOM);}
   static int PingLast() {return (int)Get(TERMINAL_PING_LAST);}   
   
   static int KeyStateLeft() {return (int)Get(TERMINAL_KEYSTATE_LEFT);}   
   static int KeyStateRight() {return (int)Get(TERMINAL_KEYSTATE_RIGHT);}   
   static int KeyStateUp() {return (int)Get(TERMINAL_KEYSTATE_UP);}   
   static int KeyStateDown() {return (int)Get(TERMINAL_KEYSTATE_DOWN);}   
   static int KeyStateShift() {return (int)Get(TERMINAL_KEYSTATE_SHIFT);}   
   static int KeyStateCtrl() {return (int)Get(TERMINAL_KEYSTATE_CONTROL);}   
   static int KeyStateCapsLock() {return (int)Get(TERMINAL_KEYSTATE_CAPSLOCK);}   
   static int KeyStateNumLock() {return (int)Get(TERMINAL_KEYSTATE_NUMLOCK);}   
   static int KeyStateScrLock() {return (int)Get(TERMINAL_KEYSTATE_SCRLOCK);}   
   static int KeyStateEnter() {return (int)Get(TERMINAL_KEYSTATE_ENTER);}   
   static int KeyStateInsert() {return (int)Get(TERMINAL_KEYSTATE_INSERT);}   
   static int KeyStateDelete() {return (int)Get(TERMINAL_KEYSTATE_DELETE);}   
   static int KeyStateHome() {return (int)Get(TERMINAL_KEYSTATE_HOME);}   
   static int KeyStateEnd() {return (int)Get(TERMINAL_KEYSTATE_END);}   
   static int KeyStateTab() {return (int)Get(TERMINAL_KEYSTATE_TAB);}   
   static int KeyStatePageUp() {return (int)Get(TERMINAL_KEYSTATE_PAGEUP);}   
   static int KeyStatePageDown() {return (int)Get(TERMINAL_KEYSTATE_PAGEDOWN);}   
   static int KeyStateEscape() {return (int)Get(TERMINAL_KEYSTATE_ESCAPE);}   
   
   static double Ballance() {return Get(TERMINAL_COMMUNITY_BALANCE);}
   static double Retransmission() {return Get(TERMINAL_RETRANSMISSION);}
   
   static string Language() {return Get(TERMINAL_LANGUAGE);}
   static string Company() {return Get(TERMINAL_COMPANY);}
   static string Name() {return Get(TERMINAL_NAME);}
   static string Path() {return Get(TERMINAL_PATH);}
   static string DataPath() {return Get(TERMINAL_DATA_PATH);}
   static string CommonDataPath() {return Get(TERMINAL_COMMONDATA_PATH);}
   static string CommonCpuName() {return Get(TERMINAL_CPU_NAME);}
   static string CommonCpuArchitecture() {return Get(TERMINAL_CPU_ARCHITECTURE);}
   static string CommonOsVersion() {return Get(TERMINAL_OS_VERSION);}
   
   static long Get(ENUM_TERMINAL_INFO_INTEGER propId) {return TerminalInfoInteger(propId);}
   static double Get(ENUM_TERMINAL_INFO_DOUBLE propId) {return TerminalInfoDouble(propId);}
   static string Get(ENUM_TERMINAL_INFO_STRING propId) {return TerminalInfoString(propId);}
};