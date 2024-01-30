class StdStopsSnapshot{
public:
   StdStopsSnapshot();
   StdStopsSnapshot(const StdStopsSnapshot& other);
   StdStopsSnapshot(double sl, double tp);
   double SL() const {return m_sl;}
   double TP() const {return m_tp;}
   double CheckSL(double sl) const {return sl==m_sl?EMPTY_VALUE:m_sl;}
   double CheckTP(double tp) const {return tp==m_tp?EMPTY_VALUE:m_tp;}
   bool Check(double sl, double tp, double& slOut, double& tpOut);
   void SL(double sl) {m_sl = sl;}
   void TP(double tp) {m_tp = tp;}
   void Set(double sl, double tp);
private:
   double m_sl;
   double m_tp;
};
//--------------------------------------------
StdStopsSnapshot::StdStopsSnapshot():
   m_sl(EMPTY_VALUE),
   m_tp(EMPTY_VALUE){}
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
//--------------------------------------------
bool StdStopsSnapshot::Check(double sl,double tp,double &slOut,double &tpOut){
   slOut = CheckSL(sl);
   tpOut = CheckTP(tp);
   return slOut!=EMPTY_VALUE || tpOut!=EMPTY_VALUE;
}