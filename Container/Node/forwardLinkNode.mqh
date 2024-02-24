#include "linkNode.mqh"

#define _stdForwardLinkNode(type) _StdForwardLinkNode<StdForwardLinkNode<type>,type>

template<typename NodeType, typename Type>
class _StdForwardLinkNode:public STDLinkNode<Type>{
public:
   _StdForwardLinkNode():STDLinkNode(),m_prev(NULL){}
   _StdForwardLinkNode(const Type& obj, NodeType* prev):STDLinkNode(obj),m_prev(prev){}
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
class StdForwardLinkNode:public _stdForwardLinkNode(Type){
public:
   StdForwardLinkNode():_stdForwardLinkNode(Type)(){}
   StdForwardLinkNode(const Type& obj, StdForwardLinkNode<Type>* prev=NULL):_stdForwardLinkNode(Type)(obj, prev){}
   
   void Insert(StdForwardLinkNode<Type>* it){
      if (it)
         _Insert(it);
   }
   
   void EraseBefore(){
      if (m_prev){
         StdForwardLinkNode* it = m_prev;
         m_prev=m_prev.m_prev;
         delete it;
      }
   }

   StdForwardLinkNode<Type>* ExtractBefore(){
      StdForwardLinkNode<Type>* it = m_prev;
      if (it){
         m_prev=it.Prev();
         it.Prev(NULL);
      }
      return it;
   }

   StdForwardLinkNode<Type>* ReplaceBefore (StdForwardLinkNode<Type>* it){
      StdForwardLinkNode<Type>* ret = m_prev;
      m_prev = it;
      if (ret){
         m_prev.Prev(ret.Prev());
         ret.Prev(NULL);
      }
      else
         m_prev.Prev(NULL);
      return ret;         
   }
};
 