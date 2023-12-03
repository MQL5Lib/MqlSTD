#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTrade);

class TOnTrade{
public:
   static EventOnTrade* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTrade s_event; 
};

EventOnTrade TOnTrade::s_event;

#endif