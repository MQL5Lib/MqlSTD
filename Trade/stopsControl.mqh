#include "stopsSnapshot.mqh"
#include "../memory.mqh"

class StdStopsControl{
   double SL() const {return SLSet();}
   double TP() const {return TPSet();}
   double SLReal() const {return m_stops.SL();}
   double TPReal() const {return m_stops.TP();}
   double SLSet() const {return !m_newStops?m_stops.SL():m_newStops.Get().SL();}
   double TPSet() const {return !m_newStops?m_stops.TP():m_newStops.Get().TP();}
   void SL(double sl);
   void TP(double tp);
   void SetStops(double sl,double tp);
private:
   STDUniquePtr<StdStopsSnapshot> m_newStops;
   StdStopsSnapshot m_stops;
};
//---------------------------------------------
void StdStopsControl::SetStops(double sl,double tp){
   if (!m_newStops)
      m_newStops.Reset(new StdStopsSnapshot(sl,tp));
   else
      m_newStops.Get().Set(sl,tp);
}