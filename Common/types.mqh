#ifdef __MQL5__
   #define _stdSizeT ulong
   #define _stdSSizeT long
#else
   #define _stdSizeT uint
   #define _stdSSizeT int
#endif

enum EUpDown{
   eDown = -1,
   eEqual = 0,
   eUp = 1
};

#define _stdDirect EUpDown
#define _stdUp eUp
#define _stdDown eDown