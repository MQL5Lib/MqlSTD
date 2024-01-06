#include "../../event.mqh"
#include "../../Common/types.mqh"

_stdEvent1(OnTick,const MqlTick&);

class STDOnTick{
public:
   static EventOnTick* Event() {return &s_event;}
   static void Invoke();
   static void Invoke(const MqlTick& tick) {s_event.Invoke(tick);}
private:
   static EventOnTick s_event; 
};
//------------------------------------------------
void STDOnTick::Invoke(void){
   MqlTick tick;
   if (SymbolInfoTick(_Symbol,tick))
      Invoke(tick);
}

EventOnTick STDOnTick::s_event;