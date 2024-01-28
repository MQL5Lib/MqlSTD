class StdStopsSnapshot{
public:
   StdStopsSnapshot();
   StdStopsSnapshot(const StdStopsSnapshot& other);
   StdStopsSnapshot(double sl, double tp);
   double SL() const {return m_sl;}
   double TP() const {return m_tp;}
   void SL(double sl) {m_sl = sl;}
   void TP(double tp) {m_tp = tp;}
   void Set(double sl, double tp);
private:
   double m_sl;
   double m_tp;
};
//--------------------------------------------
StdStopsSnapshot::StdStopsSnapshot():
   m_sl(0.0),
   m_tp(0.0){}
//--------------------------------------------
StdStopsSnapshot::StdStopsSnapshot(const StdStopsSnapshot& other):
   m_sl(other.m_sl),
   m_tp(other.m_tp){}
//--------------------------------------------
StdStopsSnapshot::StdStopsSnapshot(double sl, double tp):
   m_sl(sl),
   m_tp(tp){}
//--------------------------------------------
void StdStopsSnapshot::Set(double sl,double tp){
   m_sl = sl;
   m_tp = tp;
}