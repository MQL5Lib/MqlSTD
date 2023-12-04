#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTrade);

class STDOnTrade{
public:
   static EventOnTrade* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTrade s_event; 
};

EventOnTrade STDOnTrade::s_event;

#endif