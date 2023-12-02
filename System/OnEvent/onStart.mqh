#include "../../event.mqh"

_stdEvent0(OnStart);

class TOnStart{
public:
   static void Add(__OnStart_funcGlobal func) {m_event.Add(func);}
   static void Add(void* ptr, __OnStart_funcObj func) {m_event.Add(ptr,func);}
   static void Invoke() {m_event.Invoke();}
private:
   TOnStart();
private:
   static EventOnStart m_event; 
};

EventOnStart TOnStart::m_event;