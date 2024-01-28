#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTesterInit);

class STDOnTesterInit{
public:
   static EventOnTesterInit* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTesterInit s_event; 
};

EventOnTesterInit STDOnTesterInit::s_event;

#endif