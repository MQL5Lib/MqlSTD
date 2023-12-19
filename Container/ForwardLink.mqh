#include "Node/forwardLinkNode.mqh"

template<typename Type>
class STDForwardLink{
public:
   STDForwardLink():m_top(NULL){}
   ~STDForwardLink() {Clear();}
   bool IsEmpty() const {return !m_top;}
   STDForwardLinkNode<Type>* Top() {return m_top;}
   const STDForwardLinkNode<Type>* Top() const {return m_top;}
   
   void Clear(){
      while(m_top){
         STDForwardLinkNode<Type>* it = m_top;
         m_top=m_top.Prev();
         delete it;      
      }
   }
   
   STDForwardLink*  Swap(STDForwardLink& other){
      STDForwardLinkNode<Type>* tmp = m_top;
      m_top = other.m_top;
      other.m_top = tmp;
      return &other;
   }
   
   void Push(STDForwardLinkNode<Type>* it){
      if (it){
         it.Prev(m_top);
         m_top=it;
      }
   }

   void Insert(STDForwardLinkNode<Type>* where, STDForwardLinkNode<Type>* it){
      if (where)
         where.Insert(it);
   }

   void Pop(){
      if (m_top){
         STDForwardLinkNode<Type>* it = m_top;
         m_top=m_top.Prev();
         delete it;
      }
   }

   STDForwardLinkNode<Type>* EraseBefore(STDForwardLinkNode<Type>* where){
      if (where)
         where.EraceBefore();
      return where;
   }

   STDForwardLinkNode<Type>* Extract(){
      if (IsEmpty())
         return NULL;
      STDForwardLinkNode<Type>* ret = m_top;
      m_top=m_top.Prev();
      ret.Prev(NULL);
      return ret;
   }

   STDForwardLinkNode<Type>* ExtractBefore(STDForwardLinkNode<Type>* where){
      return !where?NULL:where.ExtractBefore();
   }
   
   STDForwardLinkNode<Type>* ReplaceTop(STDForwardLinkNode<Type>* it){
      if (!it)
         return Extract();
      if (IsEmpty()){
         Push(it);
         return NULL;
      }
      STDForwardLinkNode<Type>* ret=m_top;
      m_top=it;
      m_top.Prev(ret.Prev());
      ret.Prev(NULL);
      return ret;
   }
   
   STDForwardLinkNode<Type>* ReplaceBefore (STDForwardLinkNode<Type>* where, STDForwardLinkNode<Type>* it){
      if (!it)
         return !where?NULL:where.ReplaceBefore(it);
      return !where?ReplaceTop(it):where.ReplaceBefore(it);
   }
         
private:
   STDForwardLinkNode<Type>* m_top;
};