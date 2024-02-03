template<typename Type1,typename Type2>
class StdPair{
public:
   StdPair(){}
   StdPair(Type1 first, Type2 second) {_Init(first,second);}
   StdPair(const Type1& first, Type2 second) {_Init(first,second);}
   StdPair(Type1 first, const Type2& second) {_Init(first,second);}
   StdPair(const Type1& first, const Type2& second) {_Init(first,second);}
   StdPair(const StdPair& other);
   StdPair* operator =(const StdPair& other);
   StdPair* Set(const Type1& first, const Type2& second);
   StdPair* First(const Type1& first);
   StdPair* Second(const Type2& second);
   Type1 First() const {return m_first;}
   Type2 Second() const {return m_second;}
private:
   void _Init(const Type1& first, const Type2& second);
private:
   Type1 m_first;
   Type2 m_second;
};
//-------------------------------------
template<typename Type1,typename Type2>
StdPair::StdPair(const StdPair& other):
   m_first(other.m_first),
   m_second(other.m_second){}
//-------------------------------------
template<typename Type1,typename Type2>
StdPair* StdPair::operator =(const StdPair& other){
   m_first = other.m_first;
   m_second = other.m_second;
   return &this;
}
//-------------------------------------
template<typename Type1,typename Type2>
void StdPair::_Init(const Type1& first, const Type2& second){
   m_first=first;
   m_second=second;
}
//-------------------------------------
template<typename Type1,typename Type2>
StdPair* StdPair::Set(const Type1& first, const Type2& second){
   m_first = first;
   m_second = second;
   return &this;
}
//-------------------------------------
template<typename Type1,typename Type2>
StdPair* StdPair::First(const Type1& first){
   m_first = first;
   return &this;
}
//-------------------------------------
template<typename Type1,typename Type2>
StdPair* StdPair::Second(const Type2& second){
   m_second = second;
   return &this;
}
