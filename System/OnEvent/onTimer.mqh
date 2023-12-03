#include "../../event.mqh"

_stdEvent3(OnTimer,uint,uint,uint);

class TOnTimer{
public:
   static EventOnTimer* Event() {return &s_event;}
   static void Invoke(){
      Invoke(GetTickCount());
   }
   static void Invoke(uint tickCount){
      s_event.Invoke(s_start, s_last, tickCount);
      s_last = tickCount;
   }   
private:
   static EventOnTimer s_event;
   static uint s_start;
   static uint s_last;
};

EventOnTimer TOnTimer::s_event;
uint TOnTimer::s_start=GetTickCount();
uint TOnTimer::s_last=0;