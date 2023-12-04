#include "../../event.mqh"

_stdEvent1(OnDeinit,int);

class STDOnDeinit{
public:
   static EventOnDeinit* Event() {return &s_event;}
   static void Invoke(){
      Invoke(UninitializeReason());
   }
   static void Invoke(int reason){
      s_event.Invoke(reason);
      s_last = reason;
   }
   static int LastReason() {return s_last;}
private:
   static EventOnDeinit s_event;
   static int s_last;
};

EventOnDeinit STDOnDeinit::s_event;
int STDOnDeinit::s_last=-1;