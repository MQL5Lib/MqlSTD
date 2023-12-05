#include "linkNode.mqh"

#define _stdForwardLinkNode(type) _STDForwardLinkNode<STDForwardLinkNode<type>,type>

template<typename NodeType, typename Type>
class _STDForwardLinkNode:public STDLinkNode<Type>{
public:
   _STDForwardLinkNode():STDLinkNode(),m_prev(NULL){}
   _STDForwardLinkNode(const Type& obj, NodeType* prev):STDLinkNode(obj),m_prev(prev){}
   NodeType* Prev() {return m_prev;}
   const NodeType* Prev() const {return m_prev;}
   void Prev(NodeType* prev) {m_prev=prev;}
private:
   NodeType* m_prev;
};

template<typename Type>
class STDForwardLinkNode:public _stdForwardLinkNode(Type){
public:
   STDForwardLinkNode():_stdForwardLinkNode(Type)(){}
   STDForwardLinkNode(const Type& obj, STDForwardLinkNode<Type>* prev):_stdForwardLinkNode(Type)(obj, prev){}
};
 