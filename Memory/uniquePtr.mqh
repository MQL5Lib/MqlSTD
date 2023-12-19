#include "../Common/define.mqh"

template<typename Type>
struct STDUniquePtr{
private:
   Type* m_ptr;
public:
   STDUniquePtr():m_ptr(NULL){}
   STDUniquePtr(Type* ptr):m_ptr(ptr){}
  ~STDUniquePtr() {DEL(m_ptr);}
   const Type* Get() const {return m_ptr;}
   Type* Get() {return m_ptr;}
   void Reset(Type* ptr=NULL);
   Type* Release();
   void Swap(STDUniquePtr<Type>& other);
   void operator =(Type* ptr) {Reset(ptr);}
   bool operator !() const {return !m_ptr;}
   bool IsInit() const {return m_ptr!=NULL;}
   bool operator ==(const STDUniquePtr<Type>& other) const {return m_ptr==other.m_ptr;}
   bool operator !=(const STDUniquePtr<Type>& other) const {return m_ptr!=other.m_ptr;}
};
//--------------------------------------------------------------------------
template<typename Type>
void STDUniquePtr::Reset(Type* ptr=NULL){
   if (ptr==m_ptr) return;
   DEL(m_ptr);
   m_ptr=ptr;
}
//---------------------------------------------------------------------------
template<typename Type>
Type* STDUniquePtr::Release(){
   Type* ret=m_ptr;
   m_ptr=NULL;
   return ret;
}
//------------------------------------------------------------------------------
template<typename Type>
void STDUniquePtr::Swap(STDUniquePtr<Type>& other){
   if (this!=other){
      Type* tmp=m_ptr;
      m_ptr=other.m_ptr;
      other.m_ptr=tmp;
   }
}

template<typename Type>
void Swap(STDUniquePtr<Type>& l,STDUniquePtr<Type>& r) {l.Swap(r);}