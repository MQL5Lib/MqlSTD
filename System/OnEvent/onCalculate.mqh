#include "../../event.mqh"

typedef void(*__OnCalculateFull_funcGlobal)(int,int,const datetime&[],const double&[],const double&[],const double&[],const double&[],const long&[],const long&[],const int&[]);
typedef void(*__OnCalculateFull_funcObj)(void*,int,int,const datetime&[],const double&[],const double&[],const double&[],const double&[],const long&[],const long&[],const int&[]);
class EventOnCalculateFull:public STD_EventBase<__OnCalculateFull_funcGlobal,__OnCalculateFull_funcObj>{
public:
   void Invoke(int rates_total,
               int prev_calculated,
               const datetime& time[],
               const double& open[],
               const double& high[],
               const double& low[],
               const double& close[],
               const long& tick_volume[],
               const long& volume[],
               const int& spread[]){
      STD_EventStructHolder<__OnCalculateFull_funcGlobal,__OnCalculateFull_funcObj>* it=NULL;
      while((it=Next(it))!=NULL)
         if (it.IsGlobal()) it.m_global.func(rates_total,prev_calculated,time,open,high,low,close,tick_volume,volume,spread);
         else it.m_obj.func(it.m_obj.it,rates_total,prev_calculated,time,open,high,low,close,tick_volume,volume,spread);
      }
};

typedef void(*__OnCalculateShort_funcGlobal)(int,int,int,const double&[]);
typedef void(*__OnCalculateShort_funcObj)(void*,int,int,int,const double&[]);
class EventOnCalculateShort:public STD_EventBase<__OnCalculateShort_funcGlobal,__OnCalculateShort_funcObj>{
public:
   void Invoke(int rates_total, 
               int prev_calculated, 
               int begin,
               const double& price[]){
      STD_EventStructHolder<__OnCalculateShort_funcGlobal,__OnCalculateShort_funcObj>* it=NULL;
      while((it=Next(it))!=NULL)
         if (it.IsGlobal()) it.m_global.func(rates_total,prev_calculated,begin,price);
         else it.m_obj.func(it.m_obj.it,rates_total,prev_calculated,begin,price);
      }
};

class TOnCalculate{
public:
   static EventOnCalculateFull* EventFull() {return &s_eventFull;}
   static EventOnCalculateShort* EventShort() {return &s_eventShort;}
   static void Invoke(int rates_total,
                      int prev_calculated,
                      const datetime& time[],
                      const double& open[],
                      const double& high[],
                      const double& low[],
                      const double& close[],
                      const long& tick_volume[],
                      const long& volume[],
                      const int& spread[]) {s_eventFull.Invoke(rates_total,prev_calculated,time,open,high,low,close,tick_volume,volume,spread);}
   static void Invoke(int rates_total,
                      int prev_calculated,
                      int begin,
                      const double& price[]) {s_eventShort.Invoke(rates_total,prev_calculated,begin,price);}               
private:
   static EventOnCalculateFull s_eventFull; 
   static EventOnCalculateShort s_eventShort; 
};

EventOnCalculateFull TOnCalculate::s_eventFull;
EventOnCalculateShort TOnCalculate::s_eventShort;