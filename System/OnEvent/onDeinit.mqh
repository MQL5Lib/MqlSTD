#include "../../event.mqh"

_stdEvent1(OnDeinit,int);

class TOnDeinit{
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

EventOnDeinit TOnDeinit::s_event;
int TOnDeinit::s_last=-1;