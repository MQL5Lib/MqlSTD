#include "SharedPtr.mqh"

template<typename Type>
struct STDWeakPtr{
private:
   __STDSharedLinkCounter* m_counter;
   Type* m_ptr;
public:
   STDWeakPtr():m_ptr(NULL),m_counter(NULL){}
   STDWeakPtr(STDSharedPtr<Type> &other);
   STDWeakPtr(STDWeakPtr<Type> &other);
  ~STDWeakPtr();
   void Reset();
   void Swap(STDWeakPtr<Type>& other);
   void operator =(STDSharedPtr<Type> &other);
   void operator =(STDWeakPtr<Type> &other);
   _stdSizeT Count() const {return !m_counter?0:m_counter.shared;}
   bool Expired() const {return !Count();}
   STDSharedPtr<Type> Lock();
};
//--------------------------------------------------------------------------
template<typename Type>
STDWeakPtr::STDWeakPtr(STDSharedPtr<Type> &other){
   m_ptr=other.Get();
   m_counter=other.Counter();
   if (m_counter!=NULL) ++m_counter.weak;
}
//--------------------------------------------------------------------------
template<typename Type>
STDWeakPtr::STDWeakPtr(STDWeakPtr<Type> &other){
   m_ptr=other.m_ptr;
   m_counter=other.m_counter;
   if (m_counter!=NULL) ++m_counter.weak;
}
//--------------------------------------------------------------------------
template<typename Type>
STDWeakPtr::~STDWeakPtr(){
   if (!m_counter)
      return;
   if(!--m_counter.weak)
      if (!m_counter.shared)
         delete m_counter;
}
//--------------------------------------------------------------------------
template<typename Type>
void STDWeakPtr::Reset(){
   if (!m_counter)
      return;
   if(!--m_counter.weak)
      if (!m_counter.shared)
         delete m_counter;
   m_counter=NULL;
}
//------------------------------------------------------------------------------
template<typename Type>
void STDWeakPtr::Swap(STDWeakPtr<Type>& other){
   if (m_ptr!=other.m_ptr){
      Type* tmpPtr=m_ptr;
      __STDSharedLinkCounter* tmpCounter=m_counter;
      m_ptr=other.m_ptr;
      m_counter=other.m_counter;
      other.m_ptr=tmpPtr;
      other.m_counter=tmpCounter;
   }
}
//--------------------------------------------------------------------------
template<typename Type>
void STDWeakPtr::operator =(STDSharedPtr<Type> &other){
   if (m_ptr==other.Get()) return;
   if (m_counter!=NULL){
      if(!--m_counter.weak)
         if (!m_counter.shared)
            delete m_counter;
   }
   m_ptr=other.Get();
   m_counter=other.Counter();
   if (m_counter)
      ++m_counter.weak;
}
//--------------------------------------------------------------------------
template<typename Type>
void STDWeakPtr::operator =(STDWeakPtr<Type> &other){
   if (m_ptr==other.m_ptr) return;
   if (m_counter!=NULL){
      if(!--m_counter.weak)
         if (!m_counter.shared)
            delete m_counter;
   }
   m_ptr=other.m_ptr;
   m_counter=other.m_counter;
   if (m_counter)
      ++m_counter.weak;
}
//---------------------------------------------------------------------------
template<typename Type>
STDSharedPtr<Type> STDWeakPtr::Lock(){
   if (!m_counter||!m_counter.shared)
      return STDSharedPtr<Type>();
   return STDSharedPtr<Type>(m_ptr,m_counter);
}

template<typename Type>
void Swap(STDWeakPtr<Type>& l,STDWeakPtr<Type>& r) {l.Swap(r);}