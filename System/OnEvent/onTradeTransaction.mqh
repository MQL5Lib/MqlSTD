#ifdef __MQL5__

#include "../../event.mqh"

_stdEvent3(OnTradeTransaction,const MqlTradeTransaction&,const MqlTradeRequest&,const MqlTradeResult&);

class TOnTradeTransaction{
public:
   static EventOnTradeTransaction* Event() {return &s_event;}
   static void Invoke(const MqlTradeTransaction& trans,const MqlTradeRequest& request,const MqlTradeResult& result) {s_event.Invoke(trans,request,result);}
private:
   static EventOnTradeTransaction s_event; 
};

EventOnTradeTransaction TOnTradeTransaction::s_event;

#endif