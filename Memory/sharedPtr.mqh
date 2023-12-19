#include "../Common/define.mqh"
#include "../Common/types.mqh"

class __STDSharedLinkCounter{
public:
   _stdSizeT shared;
   _stdSizeT weak;
   __STDSharedLinkCounter():shared(0),weak(0){}
};

template<typename Type>
struct STDSharedPtr{
private:
   __STDSharedLinkCounter* m_counter;
   Type* m_ptr;
public:
   STDSharedPtr():m_ptr(NULL),m_counter(NULL){}
   STDSharedPtr(Type* ptr);
   STDSharedPtr(STDSharedPtr<Type> &other);
   STDSharedPtr(Type* ptr,__STDSharedLinkCounter* _count):m_ptr(ptr),m_counter(!ptr?NULL:_count){if (m_counter!=NULL) ++m_counter.shared;}
  ~STDSharedPtr();
   template<typename T1>
   STDSharedPtr<T1> StaticCast() {STDSharedPtr<T1> ret((T1*)m_ptr,m_counter); return ret;}
   template<typename T1>
   STDSharedPtr<T1> DynamicCast() {STDSharedPtr<T1> ret(dynamic_cast<T1*>(m_ptr),m_conter); return ret;}
   Type* Get() const {return m_ptr;}
   __STDSharedLinkCounter* Counter() const {return m_counter;} 
   void Reset(Type* ptr=NULL);
   void Swap(STDSharedPtr<Type>& other);
   void operator =(STDSharedPtr<Type> &other);
   void operator =(Type* ptr) {Reset(ptr);}
   _stdSizeT Count() {return !m_counter?0:m_counter.shared;}
   bool operator !() const {return !m_ptr;}
   bool IsInit() const {return m_ptr!=NULL;}
   bool operator ==(const STDSharedPtr<Type>& other) const {return m_ptr==other.m_ptr;}
   bool operator !=(const STDSharedPtr<Type>& other) const {return m_ptr!=other.m_ptr;}
private:
   void Decrease();
};
//--------------------------------------------------------------------------
template<typename Type>
STDSharedPtr::STDSharedPtr(STDSharedPtr<Type> &other){
   m_ptr=other.m_ptr;
   m_counter=other.m_counter;
   if (m_counter!=NULL) ++m_counter.shared;
}
//--------------------------------------------------------------------------
template<typename Type>
STDSharedPtr::STDSharedPtr(Type* ptr):
   m_ptr(ptr),
   m_counter(!ptr?NULL:new __STDSharedLinkCounter()){
   if (m_ptr){
      ++m_counter.shared;
      if (__IsEnableSharedFromThis(m_ptr)){
         __InitEnableSharedFromThis(ptr,this);
      }
   }
}
//---------------------------------------------------------------------------
template<typename Type>
STDSharedPtr::~STDSharedPtr(){
   if (!m_counter) return;
   Decrease();
}
//--------------------------------------------------------------------------
template<typename Type>
void STDSharedPtr::Reset(Type* ptr=NULL){
   if (ptr==m_ptr) return;
   if (ptr && __IsEnableSharedFromThis(ptr)){
      this=__CloneEnableSharedFromThis(ptr);
      return;
   }
   Decrease();
   m_ptr=ptr;
   if (m_ptr){
      m_counter=new __STDSharedLinkCounter();
      ++m_counter.shared;
   }
}
//------------------------------------------------------------------------------
template<typename Type>
void STDSharedPtr::Swap(STDSharedPtr<Type>& other){
   if (this!=other){
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
void STDSharedPtr::operator =(STDSharedPtr<Type> &other){
   if (m_ptr==other.m_ptr) return;
   Decrease();
   m_ptr=other.m_ptr;
   m_counter=other.m_counter;
   if (m_counter!=NULL) ++m_counter.shared;
}

template<typename Type>
void STDSharedPtr::Decrease(){
   if (!m_counter)
      return;
   if (!--m_counter.shared){
      DEL(m_ptr);
      // Can destroy in TEnableSharedFromThis<Type> in TWeakPtr<Type>
      if (CheckPointer(m_counter)!=POINTER_INVALID && !m_counter.weak)
         DEL(m_counter);
   }
}

template<typename Type>
void Swap(STDSharedPtr<Type>& l,STDSharedPtr<Type>& r) {l.Swap(r);}