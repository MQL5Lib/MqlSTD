#include "stopSnapshot.mqh"
#include "../../Memory/pair.mqh"

class StdStopsSnapshot{
public:
   StdStopsSnapshot(){}
   int Digits(int digits);
   int Digits() const {return m_sl.Digits();}
   StdPair<double,double> Get() const {return StdPair<double,double>(m_sl.Get(), m_tp.Get());}
   StdStopsSnapshot* Set(double sl, double tp) {Reset(sl,tp); return &this;}
   void Reset() {Reset(EMPTY_VALUE,EMPTY_VALUE);}
   void Reset(double sl, double tp) {Reset(sl,tp,m_sl.Digits());}
   void Reset(double sl, double tp, int digits);
   double SL() const {return m_sl.Get();}
   double TP() const {return m_tp.Get();}
   bool HasSL() const {return m_sl.HasValue();}
   bool HasTP() const {return m_tp.HasValue();}
   bool HasValue() const {return HasSL() || HasTP();}
   bool operator !() const {return !HasValue();}
   bool TestEqualySL(double price) const {return m_sl.TestEqualy(price);}
   bool TestEqualySLAndReset(double price) {return m_sl.TestEqualyAndReset(price);}
   bool TestEqualyTP(double price) const {return m_tp.TestEqualy(price);}
   bool TestEqualyTPAndReset(double price) {return m_tp.TestEqualyAndReset(price);}
   bool TestEqualy(double sl, double tp) const {return m_sl.TestEqualy(sl) && m_tp.TestEqualy(tp);}
   bool TestEqualyAndReset(double sl, double tp);
private:
   StdStopSnapshot m_sl;
   StdStopSnapshot m_tp;
};
//----------------------------
int StdStopsSnapshot::Digits(int digits){
   m_sl.Digits(digits);
   return m_tp.Digits(digits);
}
//----------------------------
void StdStopsSnapshot::Reset(double sl, double tp, int digits){
   m_sl.Reset(sl,digits);
   m_tp.Reset(tp,digits);
}
//----------------------------
bool StdStopsSnapshot::TestEqualyAndReset(double sl,double tp){
   bool ret = m_sl.TestEqualyAndReset(sl);
   return m_tp.TestEqualyAndReset(tp) && ret;
}