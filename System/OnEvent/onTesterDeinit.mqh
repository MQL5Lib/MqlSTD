#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTesterDeinit);

class STDOnTesterDeinit{
public:
   static EventOnTesterDeinit* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTesterDeinit s_event; 
};

EventOnTesterDeinit STDOnTesterDeinit::s_event;

#endif