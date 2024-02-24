#include "Node/forwardLinkNode.mqh"

template<typename Type>
class StdForwardLink{
public:
   StdForwardLink():m_top(NULL){}
   ~StdForwardLink() {Clear();}
   bool IsEmpty() const {return !m_top;}
   StdForwardLinkNode<Type>* Top() {return m_top;}
   const StdForwardLinkNode<Type>* Top() const {return m_top;}
   
   void Clear(){
      while(m_top){
         StdForwardLinkNode<Type>* it = m_top;
         m_top=m_top.Prev();
         delete it;      
      }
   }
   
   StdForwardLink*  Swap(StdForwardLink& other){
      StdForwardLinkNode<Type>* tmp = m_top;
      m_top = other.m_top;
      other.m_top = tmp;
      return &other;
   }
   
   void Push(StdForwardLinkNode<Type>* it){
      if (it){
         it.Prev(m_top);
         m_top=it;
      }
   }

   void Insert(StdForwardLinkNode<Type>* where, StdForwardLinkNode<Type>* it){
      if (where)
         where.Insert(it);
   }

   void Pop(){
      if (m_top){
         StdForwardLinkNode<Type>* it = m_top;
         m_top=m_top.Prev();
         delete it;
      }
   }

   StdForwardLinkNode<Type>* EraseBefore(StdForwardLinkNode<Type>* where){
      if (where)
         where.EraseBefore();
      return where;
   }

   StdForwardLinkNode<Type>* Extract(){
      if (IsEmpty())
         return NULL;
      StdForwardLinkNode<Type>* ret = m_top;
      m_top=m_top.Prev();
      ret.Prev(NULL);
      return ret;
   }

   StdForwardLinkNode<Type>* ExtractBefore(StdForwardLinkNode<Type>* where){
      return !where?NULL:where.ExtractBefore();
   }
   
   StdForwardLinkNode<Type>* ReplaceTop(StdForwardLinkNode<Type>* it){
      if (!it)
         return Extract();
      if (IsEmpty()){
         Push(it);
         return NULL;
      }
      StdForwardLinkNode<Type>* ret=m_top;
      m_top=it;
      m_top.Prev(ret.Prev());
      ret.Prev(NULL);
      return ret;
   }
   
   StdForwardLinkNode<Type>* ReplaceBefore (StdForwardLinkNode<Type>* where, StdForwardLinkNode<Type>* it){
      if (!it)
         return !where?NULL:where.ReplaceBefore(it);
      return !where?ReplaceTop(it):where.ReplaceBefore(it);
   }
         
private:
   StdForwardLinkNode<Type>* m_top;
};