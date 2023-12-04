#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTesterDeinit);

class TOnTesterDeinit{
public:
   static EventOnTesterDeinit* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTesterDeinit s_event; 
};

EventOnTesterDeinit TOnTesterDeinit::s_event;

#endif