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
protected:
   void _Insert(NodeType* it){
      it.Prev(m_prev);
      m_prev=it;
   }
protected:
   NodeType* m_prev;
};

template<typename Type>
class STDForwardLinkNode:public _stdForwardLinkNode(Type){
public:
   STDForwardLinkNode():_stdForwardLinkNode(Type)(){}
   STDForwardLinkNode(const Type& obj, STDForwardLinkNode<Type>* prev=NULL):_stdForwardLinkNode(Type)(obj, prev){}
   void Insert(STDForwardLinkNode<Type>* it){ _Insert(it);}
   
   STDForwardLinkNode<Type>* ReplaceBefore (STDForwardLinkNode<Type>* it){
      STDForwardLinkNode<Type>* ret = m_prev;
      m_prev = it;
      if (ret){
         m_prev.Prev(ret.Prev());
         ret.Prev(NULL);
      }
      else
         m_prev.Prev(NULL);
      return ret;         
   }
   
   void EraseBefore(){
      if (m_prev){
         STDForwardLinkNode* it = m_prev;
         m_prev=m_prev.m_prev;
         delete it;
      }
   }
   
   STDForwardLinkNode<Type>* ExtractBefore(){
      STDForwardLinkNode<Type>* it = m_prev;
      if (it){
         m_prev=it.Prev();
         it.Prev(NULL);
      }
      return it;
   }
};
 