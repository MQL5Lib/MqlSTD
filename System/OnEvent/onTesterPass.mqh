#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTesterPass);

class STDOnTesterPass{
public:
   static EventOnTesterPass* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTesterPass s_event; 
};

EventOnTesterPass STDOnTesterPass::s_event;

#endif