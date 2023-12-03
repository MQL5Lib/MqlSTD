#include "../../event.mqh"

_stdEvent3(OnTimer,uint,uint,uint);

class TOnTimer{
public:
   static void Add(__OnTimer_funcGlobal func) {s_event.Add(func);}
   static void Add(void* ptr, __OnTimer_funcObj func) {s_event.Add(ptr,func);}
   static void Remove(__OnTimer_funcGlobal func) {s_event.Remove(func);}
   static void Remove(void* ptr, __OnTimer_funcObj func) {s_event.Remove(ptr,func);}
   static void Invoke(){
      uint now=GetTickCount();
      s_event.Invoke(s_start, s_last, now);
      s_last = now;
   }
private:
   TOnTimer(){}
private:
   static EventOnTimer s_event;
   static uint s_start;
   static uint s_last;
};

EventOnTimer TOnTimer::s_event;
uint TOnTimer::s_start=GetTickCount();
uint TOnTimer::s_last=0;