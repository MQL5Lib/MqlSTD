#include "../../event.mqh"

_stdEvent0(OnStart);

class STDOnStart{
public:
   static EventOnStart* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnStart s_event; 
};

EventOnStart STDOnStart::s_event;