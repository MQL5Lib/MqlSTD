#include "../../Memory/wraper.mqh"

template<typename Type>
class STDLinkNode{
public:
   STDLinkNode(){}
   STDLinkNode(const Type& obj):m_value(obj){}
   void Reset(const Type& value) {m_value.value = value;}
   const STDWraper<Type>* Get() const {return &m_value;}
   STDWraper<Type>* Get() {return &m_value;}   
private:
   STDWraper<Type> m_value;
};
