#include "../../event.mqh"

_stdEvent4(OnChartEvent,int,const long&,const double&,const string&);

class STDOnChartEvent{
public:
   static EventOnChartEvent* Event() {return &s_event;}
   static void Invoke(int id,   
                      const long& lparam, 
                      const double& dparam, 
                      const string& sparam){ Invoke(id,lparam,dparam,sparam); }
private:
   static EventOnChartEvent s_event;
};

EventOnChartEvent STDOnChartEvent::s_event;
