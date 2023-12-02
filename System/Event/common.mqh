#include "base.mqh"

#define _stdEventDecl(name) Event##name

#define _stdEvent0(name) \
typedef void(*__##name##_funcGlobal)(void);\
typedef void(*__##name##_funcObj)(void*);\
class Event##name:public STD_EventBase<__##name##_funcGlobal,__##name##_funcObj>{\
public:\
   void Invoke(){\
      STD_EventStructHolder<__##name##_funcGlobal,__##name##_funcObj>* it=NULL;\
      while((it=Next(it))!=NULL)\
         if (it.IsGlobal()) it.m_global.func();\
         else it.m_obj.func(it.m_obj.it);\
      }\
}

#define _stdEvent1(name,Type1) \
typedef void(*__##name##_funcGlobal)(Type1);\
typedef void(*__##name##_funcObj)(void*,Type1);\
class Event##name:public STD_EventBase<__##name##_funcGlobal,__##name##_funcObj>{\
public:\
   void Invoke(Type1 p1){\
      STD_EventStructHolder<__##name##_funcGlobal,__##name##_funcObj>* it=NULL;\
      while((it=Next(it))!=NULL)\
         if (it.IsGlobal()) it.m_global.func(p1);\
         else it.m_obj.func(it.m_obj.it,p1);\
      }\
}

#define _stdEvent2(name,Type1,Type2) \
typedef void(*__##name##_funcGlobal)(Type1,Type2);\
typedef void(*__##name##_funcObj)(void*,Type1,Type2);\
class Event##name:public STD_EventBase<__##name##_funcGlobal,__##name##_funcObj>{\
public:\
   void Invoke(Type1 p1,Type2 p2){\
      STD_EventStructHolder<__##name##_funcGlobal,__##name##_funcObj>* it=NULL;\
      while((it=Next(it))!=NULL)\
         if (it.IsGlobal()) it.m_global.func(p1,p2);\
         else it.m_obj.func(it.m_obj.it,p1,p2);\
      }\
}

#define _stdEvent3(name,Type1,Type2,Type3) \
typedef void(*__##name##_funcGlobal)(Type1,Type2,Type3);\
typedef void(*__##name##_funcObj)(void*,Type1,Type2,Type3);\
class Event##name:public STD_EventBase<__##name##_funcGlobal,__##name##_funcObj>{\
public:\
   void Invoke(Type1 p1,Type2 p2,Type3 p3){\
      STD_EventStructHolder<__##name##_funcGlobal,__##name##_funcObj>* it=NULL;\
      while((it=Next(it))!=NULL)\
         if (it.IsGlobal()) it.m_global.func(p1,p2,p3);\
         else it.m_obj.func(it.m_obj.it,p1,p2,p3);\
      }\
}

#define _stdEvent4(name,Type1,Type2,Type3,Type4) \
typedef void(*__##name##_funcGlobal)(Type1,Type2,Type3,Type4);\
typedef void(*__##name##_funcObj)(void*,Type1,Type2,Type3,Type4);\
class Event##name:public STD_EventBase<__##name##_funcGlobal,__##name##_funcObj>{\
public:\
   void Invoke(Type1 p1,Type2 p2,Type3 p3,Type4 p4){\
      STD_EventStructHolder<__##name##_funcGlobal,__##name##_funcObj>* it=NULL;\
      while((it=Next(it))!=NULL)\
         if (it.IsGlobal()) it.m_global.func(p1,p2,p3,p4);\
         else it.m_obj.func(it.m_obj.it,p1,p2,p3,p4);\
      }\
}

#define _stdEvent5(name,Type1,Type2,Type3,Type4,Type5) \
typedef void(*__##name##_funcGlobal)(Type1,Type2,Type3,Type4,Type5);\
typedef void(*__##name##_funcObj)(void*,Type1,Type2,Type3,Type4,Type5);\
class Event##name:public STD_EventBase<__##name##_funcGlobal,__##name##_funcObj>{\
public:\
   void Invoke(Type1 p1,Type2 p2,Type3 p3,Type4 p4,Type5 p5){\
      STD_EventStructHolder<__##name##_funcGlobal,__##name##_funcObj>* it=NULL;\
      while((it=Next(it))!=NULL)\
         if (it.IsGlobal()) it.m_global.func(p1,p2,p3,p4,p5);\
         else it.m_obj.func(it.m_obj.it,p1,p2,p3,p4,p5);\
      }\
}