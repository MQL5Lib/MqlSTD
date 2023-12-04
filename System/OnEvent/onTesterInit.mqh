#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTesterInit);

class TOnTesterInit{
public:
   static EventOnTesterInit* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTesterInit s_event; 
};

EventOnTesterInit TOnTesterInit::s_event;

#endif