#include "../../event.mqh"
#include "../../Common/types.mqh"

_stdEvent2(OnInit,_stdSizeT,datetime);

class TOnInit{
public:
   static void Add(__OnInit_funcGlobal func) {m_event.Add(func);}
   static void Add(void* ptr, __OnInit_funcObj func) {m_event.Add(ptr,func);}
   static void Invoke() {m_event.Invoke((_stdSizeT)iVolume(_Symbol,PERIOD_CURRENT,0),TimeCurrent());}
private:
   TOnInit();
private:
   static EventOnInit m_event; 
};

EventOnInit TOnInit::m_event;