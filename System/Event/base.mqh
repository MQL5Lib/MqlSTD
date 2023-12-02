#include "../../Common/define.mqh"

template<typename FuncType>
class STD_EventStructBase{
public:
   STD_EventStructBase(FuncType _func):func(_func){}
public:
   FuncType func;
};

#define __BaseType STD_EventStructBase<FuncType>

template<typename FuncType>
class STD_EventStructGlobal:public __BaseType{
public:
   STD_EventStructGlobal(FuncType _func):__BaseType(_func){}
};

template<typename FuncType>
class STD_EventStructObj:public __BaseType{
public:
   STD_EventStructObj(void* _it,FuncType _func):__BaseType(_func),it(_it){}
public:
   void* it;
};

#undef __BaseType

template<typename FuncGlobalType,typename FuncObjType>
class STD_EventStructHolder{
public:
   STD_EventStructHolder(STD_EventStructGlobal<FuncGlobalType>* global,STD_EventStructHolder* prev):
      m_global(global),m_obj(NULL),m_next(NULL),m_prev(prev){}
   STD_EventStructHolder(STD_EventStructObj<FuncObjType>* obj,STD_EventStructHolder* prev):
      m_global(NULL),m_obj(obj),m_next(NULL),m_prev(prev){}   
   ~STD_EventStructHolder(){
      DEL(m_global);
      DEL(m_obj);
   }
   STD_EventStructHolder* Next() const {return m_next;}
   STD_EventStructHolder* Prev() const {return m_prev;}
   void Next(STD_EventStructHolder* it) {m_next=it;}
   void Prev(STD_EventStructHolder* it) {m_prev=it;}
   bool IsValid() const {return !m_obj || CheckPointer(m_obj.it)!=POINTER_INVALID;}
   bool IsGlobal() const {return !m_obj;}
   bool IsSame(FuncGlobalType func) {return !m_obj&&m_global.func==func;}
   bool IsSame(void* ptr,FuncObjType func) {return !m_global&&m_obj.it==ptr&&m_obj.func==func;}
public:
   STD_EventStructGlobal<FuncGlobalType>* m_global;
   STD_EventStructObj<FuncObjType>* m_obj;
private:
   STD_EventStructHolder* m_next;
   STD_EventStructHolder* m_prev;
};

template<typename FuncGlobalType,typename FuncObjType>
class STD_EventBase{
protected:
   STD_EventStructHolder<FuncGlobalType,FuncObjType>* m_front;
   STD_EventStructHolder<FuncGlobalType,FuncObjType>* m_back;
public:
   STD_EventBase():m_front(NULL),m_back(NULL){}
  ~STD_EventBase(){
      STD_EventStructHolder<FuncGlobalType,FuncObjType>* it=m_front;
      while (it!=NULL){
         void* forDelete=it;
         it=it.Next();
         delete forDelete;
      }
   }
   void Add(void* it,FuncObjType func){
      PushBack(new STD_EventStructObj<FuncObjType>(it,func));
   }
   void Add(FuncGlobalType func){
      PushBack(new STD_EventStructGlobal<FuncGlobalType>(func));
   }
   void Remove(STD_EventStructHolder<FuncGlobalType,FuncObjType>* it){
      STD_EventStructHolder<FuncGlobalType,FuncObjType>* prev = it.Prev();
      STD_EventStructHolder<FuncGlobalType,FuncObjType>* next = it.Next();
      if (!prev) m_front=next;
      else prev.Next(next);
      if(!next) m_back=prev;
      else next.Prev(prev);
      delete it;
   }
   void Remove(void* ptr,FuncObjType func){
      STD_EventStructHolder<FuncGlobalType,FuncObjType>* it=m_back;
      while (it!=NULL){
         if (it.IsSame(ptr,func)){
            Remove(it);            
            break;
         }
         it=it.Prev();
      }      
   }
   void Remove(FuncGlobalType func){
      STD_EventStructHolder<FuncGlobalType,FuncObjType>* it=m_back;
      while (it!=NULL){
         if (it.IsSame(func)){
            Remove(it);            
            break;
         }
         it=it.Prev();
      }         
   }
protected:  
   STD_EventStructHolder<FuncGlobalType,FuncObjType>* Next(STD_EventStructHolder<FuncGlobalType,FuncObjType>* it){
      it=!it?m_front:it.Next();
      if(!it)
         return NULL;
      STD_EventStructHolder<FuncGlobalType,FuncObjType>* prev=it.Prev();
      while(it!=NULL&&!it.IsValid()){
         STD_EventStructHolder<FuncGlobalType,FuncObjType>* next=it.Next();
         if (!prev) m_front=next;
         else prev.Next(next);
         if(!next) m_back=prev;
         else next.Prev(prev);
         delete it;
         it=next;
      }
      return it;
   }
private:
   template<typename Type>
   void PushBack(Type* foo){
      STD_EventStructHolder<FuncGlobalType,FuncObjType>* it=new STD_EventStructHolder<FuncGlobalType,FuncObjType>(foo,m_back);
      if (!m_front){
         m_front=m_back=it;
      }
      else{
         m_back.Next(it);
         it.Prev(m_back);
         m_back=it;
      }
   }
};