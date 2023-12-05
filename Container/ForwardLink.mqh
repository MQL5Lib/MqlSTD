#include "Node/forwardLinkNode.mqh"

template<typename Type>
class STDForwardLink{
public:
   STDForwardLink():m_top(NULL){}
   ~STDForwardLink() {Clear();}
   bool IsEmpty() const {return !m_top;}
   STDForwardLinkNode<Type>* Top() {return m_top;}
   const STDForwardLinkNode<Type>* Top() const {return m_top;}
      
   STDForwardLink*  Swap(STDForwardLink& other){
      STDForwardLinkNode<Type>* tmp = m_top;
      m_top = other.m_top;
      other.m_top = tmp;
      return &other;
   }
   
   STDForwardLinkNode<Type>* Extract(){
      if (IsEmpty())
         return NULL;
      STDForwardLinkNode<Type>* ret = m_top;
      m_top=m_top.Prev();
      ret.Prev(NULL);
      return ret;
   }
   
   void Pop(){
      if (m_top){
         STDForwardLinkNode<Type>* it = m_top;
         m_top=m_top.Prev();
         delete it;
      }
   }
   
   void Push(STDForwardLinkNode<Type>* it){
      if (!it)
         return;
      it.Prev(m_top);
      m_top=it;
   }
   
   void Insert(STDForwardLinkNode<Type>* where, STDForwardLinkNode<Type>* it){
      if (!where){
         Push(it);
         return;
      }
      where.Insert(it);
   }
   
   STDForwardLinkNode<Type>* ReplaceTop(STDForwardLinkNode<Type>* it){
      STDForwardLinkNode<Type>* ret=m_top;
      m_top=it;
      if (ret){
         m_top.Prev(ret.Prev());
         ret.Prev(NULL);
      }
      else
         m_top.Prev(NULL);
      return ret;
   }
   
   STDForwardLinkNode<Type>* ReplaceBefore (STDForwardLinkNode<Type>* where, STDForwardLinkNode<Type>* it){
      return !where?ReplaceTop(it):where.ReplaceBefore(it);
   }
   
   void EraseBefore(STDForwardLinkNode<Type>* where){
      if (where)
         where.EraseBefore();
   }
   
   STDForwardLinkNode<Type>* ExtractBefore(STDForwardLinkNode<Type>* where){
      return !where?NULL:where.ExtractBefore();
   }
   
   void Clear(){
      while(m_top){
         STDForwardLinkNode<Type>* it = m_top;
         m_top=m_top.Prev();
         delete it;      
      }
   }
private:
   STDForwardLinkNode<Type>* m_top;
};