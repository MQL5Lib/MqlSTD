#include "../../event.mqh"
#include "../../Common/types.mqh"

_stdEvent2(OnTick,_stdSizeT,datetime);

class TOnTick{
public:
   static void Add(__OnTick_funcGlobal func) {m_event.Add(func);}
   static void Add(void* ptr, __OnTick_funcObj func) {m_event.Add(ptr,func);}
   static void Remove(__OnTick_funcGlobal func) {m_event.Remove(func);}
   static void Remove(void* ptr, __OnTick_funcObj func) {m_event.Remove(ptr,func);}
   static void Invoke() {m_event.Invoke((_stdSizeT)iVolume(_Symbol,PERIOD_CURRENT,0),TimeCurrent());}
private:
   TOnTick();
private:
   static EventOnTick m_event; 
};

EventOnTick TOnTick::m_event;