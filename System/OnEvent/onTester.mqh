#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent0(OnTester);

class TOnTester{
public:
   static EventOnTester* Event() {return &s_event;}
   static void Invoke() {s_event.Invoke();}
private:
   static EventOnTester s_event; 
};

EventOnTester TOnTester::s_event;

#endif