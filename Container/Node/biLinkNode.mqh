#include "forwardLinkNode.mqh"

#define _stdBiLinkNode(type) _STDForwardLinkNode<STDBiLinkNode<type>,type>

template<typename Type>
class STDBiLinkNode:public _stdBiLinkNode(Type){
public:
   STDBiLinkNode():_stdBiLinkNode(Type)(),m_next(NULL){}
   STDBiLinkNode(const Type& obj, STDBiLinkNode<Type>* prev=NULL, STDBiLinkNode<Type>* next=NULL):
      _stdBiLinkNode(Type)(obj, prev),m_next(next){}
   
   STDBiLinkNode* Next() {return m_next;}
   const STDBiLinkNode* Next() const {return m_next;}
   void Next(STDBiLinkNode* next) {m_next=next;}
   
   void Insert(STDBiLinkNode<Type>* it){
      if (it){
         if (m_prev){
            m_prev.m_next = it;
         }
         it.m_next=&this;
         _Insert(it);
      }
   }
   
   void Erase(){
      _Remove();
      delete &this;
   }

   void Extract(){
      _Remove();
      m_prev=NULL;
      m_next=NULL;
   }

   void Replace (STDBiLinkNode<Type>* it){
      if (it){
         it.m_prev=m_prev;
         it.m_next=m_next;
         if (m_prev)
            m_prev.m_next=it;
         if (m_next)
            m_next.m_prev=it;
         m_prev=NULL;
         m_next=NULL;
      }
      else Extract();
   }
private:
   void _Remove(){
      if (m_prev)
         m_prev.m_next=m_next;
      if (m_next)
         m_next.m_prev=m_prev;
   } 
private:
   STDBiLinkNode* m_next;
};