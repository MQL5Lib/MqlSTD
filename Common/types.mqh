#ifdef __MQL5__
   #define _stdSizeT ulong
#else
   #define _stdSizeT uint
#endif

enum EUpDown{
   eDown = -1,
   eEqual = 0,
   eUp = 1
};

#define _stdDirect EUpDown
#define _stdUp eUp
#define _stdDown eDown