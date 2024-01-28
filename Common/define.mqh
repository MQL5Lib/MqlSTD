#ifdef __DEBUG__
   #define DEL(ptr) do if (ptr) delete ptr; while(false)
#else
   #define DEL(ptr) delete ptr
#endif

const string g_emptyString = "";