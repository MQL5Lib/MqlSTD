#include "../memory.mqh"
#include "../pattern.mqh"

#define _stdProgramm STDSingleton<STDProgramm>::Inst()

class STDProgramm{
public:
   static bool IsDllAlloed() {return (bool)Get(MQL_DLLS_ALLOWED);}
   static bool IsTradeAlloed() {return (bool)Get(MQL_TRADE_ALLOWED);}
   static bool IsSignalsAlloed() {return (bool)Get(MQL_SIGNALS_ALLOWED);}
   static bool IsDebug() {return (bool)Get(MQL_DEBUG);}
   static bool IsProfiller() {return (bool)Get(MQL_PROFILER);}
   static bool IsTester() {return (bool)Get(MQL_TESTER);}
   static bool IsForward() {return (bool)Get(MQL_FORWARD);}
   static bool IsOptimization() {return (bool)Get(MQL_OPTIMIZATION);}
   static bool IsVisualMode() {return (bool)Get(MQL_VISUAL_MODE);}
   static bool IsFrameMode() {return (bool)Get(MQL_FRAME_MODE);}
   
   static int HandlesUsed() {return (int)Get(MQL_HANDLES_USED);}
   static int MemoryLimit() {return (int)Get(MQL_MEMORY_LIMIT);}
   static int MemoryUsed() {return (int)Get(MQL_MEMORY_USED);}
   static int MemoryAviable() {return MemoryLimit() - MemoryUsed();}
   
   static ENUM_PROGRAM_TYPE ProgramType() {return (ENUM_PROGRAM_TYPE)Get(MQL_PROGRAM_TYPE);}
   static ENUM_LICENSE_TYPE LicenseType() {return (ENUM_LICENSE_TYPE)Get(MQL_LICENSE_TYPE);}
   
   static string Name() {return Get(MQL_PROGRAM_NAME);}
   static string Path() {return Get(MQL_PROGRAM_PATH);}   
   
   static long Get(ENUM_MQL_INFO_INTEGER propId) {return MQLInfoInteger(propId);}
   static string Get(ENUM_MQL_INFO_STRING propId) {return MQLInfoString(propId);}
};