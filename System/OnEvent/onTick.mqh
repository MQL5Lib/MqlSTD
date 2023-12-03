#include "../../event.mqh"
#include "../../Common/types.mqh"

_stdEvent2(OnTick,_stdSizeT,datetime);

class TOnTick{
public:
   static EventOnTick* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke((_stdSizeT)iVolume(_Symbol,PERIOD_CURRENT,0),TimeCurrent());}
private:
   static EventOnTick s_event; 
};

EventOnTick TOnTick::s_event;