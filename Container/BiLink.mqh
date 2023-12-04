#include "Node/BiLinkNode.mqh"

template<typename Type>
class STDBiLink{
public:
   STDBiLink():m_front(NULL),m_back(NULL){}
   ~STDBiLink() {Clear();}
   bool IsEmpty() const {return !m_front;}
   STDBiLinkNode<Type>* Front() {return m_front;}
   const STDBiLinkNode<Type>* Front() const {return m_front;}
   STDBiLinkNode<Type>* Back() {return m_back;}
   const STDBiLinkNode<Type>* Back() const {return m_back;}
   
   void Clear(){
      while(m_front){
         STDBiLinkNode<Type>* it = m_front;
         m_front=m_front.Next();
         delete it;      
      }
   }
   
   STDBiLink*  Swap(STDBiLink& other){
      STDBiLinkNode<Type>* tmp = m_front;
      m_front = other.m_front;
      other.m_front = tmp;
      tmp=m_back;
      m_back = other.m_back;
      other.m_back = tmp;
      return &other;
   }
   
   void PushBack(const Type& val) {PushBack(new STDBiLinkNode<Type>(val));}
   
   void PushBack(STDBiLinkNode<Type>* it){
      if (it){
         it.Prev(m_back);
         if (m_back)
            m_back.Next(it);
         m_back=it;
         if (!m_front)
            m_front = it;
      }
   }

   void PushFront(STDBiLinkNode<Type>* it){
      if (it){
         it.Next(m_front);
         if (m_front)
            m_front.Prev(it);
         m_front=it;
         if(!m_back)
            m_back=it;
      }
   }

   void Insert(STDBiLinkNode<Type>* where, STDBiLinkNode<Type>* it){
      if (!where){
         PushBack(it);
      }
      else where.Insert(it);
   }

   void PopBack(){
      if (m_back){
         STDBiLinkNode<Type>* it = m_back;
         m_back=m_back.Prev();
         if (m_back)
            m_back.Next(NULL);
         else
            m_front=NULL;
         delete it;
      }
   }

   void PopFront(){
      if (m_front){
         STDBiLinkNode<Type>* it = m_front;
         m_front=m_front.Next();
         if (m_front)
            m_front.Prev(NULL);
         else
            m_back=NULL;
         delete it;
      }
   }

   STDBiLinkNode<Type>* Erase(STDBiLinkNode<Type>* it){
      if (!it)
         return NULL;
      STDBiLinkNode<Type>* ret=it.Next();
      if (it==m_front)
         m_front=m_front.Next();
      if (it==m_back)
         m_back=m_back.Prev();
      it.Erase();
      return ret;
   }

   STDBiLinkNode<Type>* ExtractFront(){
      if (IsEmpty())
         return NULL;
      STDBiLinkNode<Type>* ret = m_front;
      m_front=m_front.Next();
      if(!m_front)
         m_back=NULL;
      ret.Extract();
      return ret;
   }

   STDBiLinkNode<Type>* ExtractBack(){
      if (IsEmpty())
         return NULL;
      STDBiLinkNode<Type>* ret = m_back;
      m_back=m_back.Prev();
      if (!m_back)
         m_front=NULL;
      ret.Extract();
      return ret;
   }

   STDBiLinkNode<Type>* Extract(STDBiLinkNode<Type>* it){
      if (!it)
         return NULL;
      if (it==m_front)
         return ExtractFront();
      if (it==m_back)
         return ExtractBack();
      it.Extract();
      return it;
   }
   
   STDBiLinkNode<Type>* ReplaceBack(STDBiLinkNode<Type>* it){
      STDBiLinkNode<Type>* ret=ExtractBack();
      PushBack(it);
      return ret;
   }
   
   STDBiLinkNode<Type>* ReplaceFront(STDBiLinkNode<Type>* it){
      STDBiLinkNode<Type>* ret=ExtractFront();
      PushFront(it);
      return ret;
   }

   STDBiLinkNode<Type>* Replace (STDBiLinkNode<Type>* where, STDBiLinkNode<Type>* it){
      if (!where || where == m_back)
         return ReplaceBack(it);
      if (where == m_front)
         return ReplaceFront(it);
      STDBiLinkNode<Type>* ret=where;
      where = where.Next();
      ret.Extract();
      Insert(where,it);
      return ret;
   }
         
private:
   STDBiLinkNode<Type>* m_front;
   STDBiLinkNode<Type>* m_back;
};

template<typename Type>
STDBiLinkNode<Type>* Find(STDBiLink<Type>& l, const Type& val){
   STDBiLinkNode<Type>* it=l.Front();
   while(it){
      if (it.Get().value == val))
         return it;
      it=it.Next();
   }
   return NULL;
}

template<typename Type>
const STDBiLinkNode<Type>* Find(const STDBiLink<Type>& l, const Type& val){
   STDBiLinkNode<Type>* it=l.Front();
   while(it){
      if (it.Get().value == val))
         return it;
      it=it.Next();
   }
   return NULL;
}

template<typename Type>
bool Erase(STDBiLink<Type>& l, const Type& val){
   STDBiLinkNode<Type>* it=l.Front();
   while(it){
      if (it.Get().value == val){
         l.Erase(it);
         return true;
      }
      it=it.Next();
   }
   return false;
}