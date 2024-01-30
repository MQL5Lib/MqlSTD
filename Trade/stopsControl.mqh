#include "stopsSnapshot.mqh"
#include "../memory.mqh"

class StdStopsControl{
   double SL() const {return SLSet();}
   double TP() const {return TPSet();}
   double SLReal() const {return m_stops.SL();}
   double TPReal() const {return m_stops.TP();}
   double SLSet() const {return !m_newStops?m_stops.SL():m_newStops.Get().SL();}
   double TPSet() const {return !m_newStops?m_stops.TP():m_newStops.Get().TP();}
   bool CheckNewStops(double& sl, double& tp) {return !m_newStops?false:m_newStops.Get().Check(m_stops.SL(),m_stops.TP(),sl,tp);}
   double CheckNewSL() {return !m_newStops?EMPTY_VALUE:m_newStops.Get().CheckSL(m_stops.SL());}
   double CheckNewTP() {return !m_newStops?EMPTY_VALUE:m_newStops.Get().CheckTP(m_stops.TP());}
   void SL(double sl) {SetStops(sl,m_stops.TP());}
   void TP(double tp) {SetStops(m_stops.SL(),tp);}
   void SetStops(double sl,double tp);
   void TPSet();
   void SLSet();
   void StopsSet();
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