#include "../../math.mqh"

class StdStopSnapshot{
public:
   StdStopSnapshot() {Reset(EMPTY_VALUE,INT_MAX);}
   StdStopSnapshot(double price, int digits) {Reset(price,digits);}
   StdStopSnapshot(const StdStopSnapshot& other) {Reset(other.m_price,other.m_digits);}   
   StdStopSnapshot* operator =(const StdStopSnapshot& other);
   void Reset() {Reset(EMPTY_VALUE,m_digits);}
   void Reset(double price, int digits);
   double Get() const {return m_price;}
   StdStopSnapshot* Set(double price) {m_price = price; return &this;}
   int Digits() const {return m_digits;}
   int Digits(int digits) {return m_digits = digits;}
   bool HasValue() const {return m_price!=EMPTY_VALUE;}
   bool operator !() const {return !HasValue();}
   bool TestEqualy(double price) const {return _Compare(price,m_price) == _eEqually;}
   bool TestEqualyAndReset(double price);
private:
   _stdCompare _Compare(double l, double r) const {return m_digits==INT_MAX?CompareEps(l,r):Compare(l,r,m_digits);}
private:
   double m_price;
   int m_digits;
};
//---------------------------------------------------
StdStopSnapshot* StdStopSnapshot::operator =(const StdStopSnapshot& other){
   Reset(other.m_price, other.m_digits);
   return &this;
}
//---------------------------------------------------
void StdStopSnapshot::Reset(double price,int digits){
   m_price = price;
   m_digits = digits;
}
//--------------------------------------------------
bool StdStopSnapshot::TestEqualyAndReset(double price){
   if (!TestEqualy(price))
      return false;
   Reset();
   return true;
}