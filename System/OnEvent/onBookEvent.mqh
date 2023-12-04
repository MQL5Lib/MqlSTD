#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent1(OnBookEvent,const string&);

class TOnBookEvent{
public:
   static EventOnBookEvent* Event() {return &s_event;}
   static void Invoke(const string& symbol) {s_event.Invoke(symbol);}
private:
   static EventOnBookEvent s_event; 
};

EventOnBookEvent TOnBookEvent::s_event;

#endif