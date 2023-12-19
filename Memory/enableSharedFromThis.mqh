#include "weakPtr.mqh"

template<typename Type>
class STDEnableSharedFromThis{
protected:
   STDEnableSharedFromThis() {}
public:
   static bool __IsIt(const STDEnableSharedFromThis*) {return true;}
   static bool __IsIt(const void*) {return false;}
   static void __InitEnableSharedFromThis(STDEnableSharedFromThis* obj,STDSharedPtr<Type>& ptr) {obj.__SetPtr(ptr);}
   static void __InitEnableSharedFromThis(void* obj,STDSharedPtr<Type>& ptr) {}
   static STDSharedPtr<Type> __CloneEnableSharedFromThis(STDEnableSharedFromThis* obj) {return obj.SharedFromThis();}
   static STDSharedPtr<Type> __CloneEnableSharedFromThis(void* obj) {return STDSharedPtr<Type>();}
   STDWeakPtr<Type> WeakFromThis() {return m_val;}
   STDSharedPtr<Type> SharedFromThis() {return m_val.Lock();}
   void __SetPtr(STDSharedPtr<Type>& ptr) {m_val=ptr;}
private:
   STDWeakPtr<Type> m_val;
};

template<typename Type>
bool __IsEnableSharedFromThis(const Type* ptr) {return STDEnableSharedFromThis<Type>::__IsIt(ptr);}

template<typename Type>
void __InitEnableSharedFromThis(Type* obj,STDSharedPtr<Type>& ptr) {
   STDEnableSharedFromThis<Type>::__InitEnableSharedFromThis(obj,ptr);
}

template<typename Type>
STDSharedPtr<Type> __CloneEnableSharedFromThis(Type* obj) {
   return STDEnableSharedFromThis<Type>::__CloneEnableSharedFromThis(obj);
}