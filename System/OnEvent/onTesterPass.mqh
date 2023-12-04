#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTesterPass);

class TOnTesterPass{
public:
   static EventOnTesterPass* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTesterPass s_event; 
};

EventOnTesterPass TOnTesterPass::s_event;

#endif