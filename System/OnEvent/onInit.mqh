#include "onDeinit.mqh"

#include "../../Container/biLink.mqh"

template<typename FuncGlobal, typename FuncObject>
class STDOnInitResultHolder{
public:
   STDOnInitResultHolder():m_global(NULL),m_obj(NULL),m_it(NULL){}
   STDOnInitResultHolder(FuncGlobal global):m_global(global),m_obj(NULL),m_it(NULL){}
   STDOnInitResultHolder(void* it, FuncObject obj):m_global(NULL),m_obj(obj),m_it(it){}   
   bool IsValid() const {return (bool)m_global || ((bool)m_obj && CheckPointer(m_it)!=POINTER_INVALID); }
   bool IsGlobal() const {return !m_obj;}
   bool IsSame(FuncGlobal func) {return !m_obj&&m_global==func;}   
   bool IsSame(void* it,FuncObject func) {return !m_global&&m_it==it&&m_obj==func;}
public:
   FuncGlobal m_global;
   FuncObject m_obj;
   void* m_it;
};

template<typename FuncGlobal, typename FuncObject>
class STDOnInitResultBase{
public:
   void Add(FuncGlobal foo) {m_list.PushBack(STDOnInitResultHolder<FuncGlobal,FuncObject>(foo));}
   void Add(void* it,FuncObject foo) {m_list.PushBack(STDOnInitResultHolder<FuncGlobal,FuncObject>(it,foo));}
   void Remove(FuncGlobal foo);
   void Remove(void* it,FuncObject foo);
protected:
   STDBiLink<STDOnInitResultHolder<FuncGlobal,FuncObject>> m_list;
};
//----------------------------------------------
template<typename FuncGlobal, typename FuncObject>
void STDOnInitResultBase::Remove(FuncGlobal foo){
   STDBiLinkNode<STDOnInitResultHolder<FuncGlobal,FuncObject>>* it=m_list.Front();
   while(it){
      if(it.Get().value.IsSame(foo)){
         m_list.Erase(it);
         return;
      }
   }
}
//----------------------------------------------
template<typename FuncGlobal, typename FuncObject>
void STDOnInitResultBase::Remove(void* ptr,FuncObject foo){
   STDBiLinkNode<STDOnInitResultHolder<FuncGlobal,FuncObject>>* it=m_list.Front();
   while(it){
      if(it.Get().value.IsSame(ptr,foo)){
         m_list.Erase(it);
         return;
      }
   }
}
//----------------------------------------------

typedef ENUM_INIT_RETCODE(*STDInitFunctionGlobalVoid)();
typedef ENUM_INIT_RETCODE(*STDInitFunctionObjVoid)(void*);

class STDOnInitResultVoid:public STDOnInitResultBase<STDInitFunctionGlobalVoid,STDInitFunctionObjVoid>{
public:
   ENUM_INIT_RETCODE Invoke(){
      STDBiLinkNode<STDOnInitResultHolder<STDInitFunctionGlobalVoid,STDInitFunctionObjVoid>>* it=m_list.Front();
      while(it){
         if (!it.Get().value.IsValid()){
            it=m_list.Erase(it);
            continue;
         }
         ENUM_INIT_RETCODE rv=it.Get().value.IsGlobal()?it.Get().value.m_global():it.Get().value.m_obj(it.Get().value.m_it);
         if (rv!=INIT_SUCCEEDED)
            return rv;
         it=it.Next();
      }
      return INIT_SUCCEEDED;
   }
};

typedef ENUM_INIT_RETCODE(*STDInitFunctionGlobalSymbol)(const string&);
typedef ENUM_INIT_RETCODE(*STDInitFunctionObjSymbol)(void*,const string&);

class STDOnInitResultSymbol:public STDOnInitResultBase<STDInitFunctionGlobalSymbol,STDInitFunctionObjSymbol>{
public:
   ENUM_INIT_RETCODE Invoke(const string& symbol){
      STDBiLinkNode<STDOnInitResultHolder<STDInitFunctionGlobalSymbol,STDInitFunctionObjSymbol>>* it=m_list.Front();
      while(it){
         if (!it.Get().value.IsValid()){
            it=m_list.Erase(it);
            continue;
         }
         ENUM_INIT_RETCODE rv=it.Get().value.IsGlobal()?it.Get().value.m_global(symbol):it.Get().value.m_obj(it.Get().value.m_it,symbol);
         if (rv!=INIT_SUCCEEDED)
            return rv;
         it=it.Next();
      }
      return INIT_SUCCEEDED;
   }
};

typedef ENUM_INIT_RETCODE(*STDInitFunctionGlobalPeriod)(ENUM_TIMEFRAMES);
typedef ENUM_INIT_RETCODE(*STDInitFunctionObjPeriod)(void*,ENUM_TIMEFRAMES);

class STDOnInitResultPeriod:public STDOnInitResultBase<STDInitFunctionGlobalPeriod,STDInitFunctionObjPeriod>{
public:
   ENUM_INIT_RETCODE Invoke(ENUM_TIMEFRAMES tf){
      STDBiLinkNode<STDOnInitResultHolder<STDInitFunctionGlobalPeriod,STDInitFunctionObjPeriod>>* it=m_list.Front();
      while(it){
         if (!it.Get().value.IsValid()){
            it=m_list.Erase(it);
            continue;
         }
         ENUM_INIT_RETCODE rv=it.Get().value.IsGlobal()?it.Get().value.m_global(tf):it.Get().value.m_obj(it.Get().value.m_it,tf);
         if (rv!=INIT_SUCCEEDED)
            return rv;
         it=it.Next();
      }
      return INIT_SUCCEEDED;
   }
};

class STDOnInit{
public:
   static ENUM_INIT_RETCODE Invoke();
   static STDOnInitResultVoid* Start() {return &s_start;}
   static STDOnInitResultVoid* Restart() {return &s_restart;}
   static STDOnInitResultVoid* Param() {return &s_param;}
   static STDOnInitResultSymbol* Symbol() {return &s_symbolEvent;}
   static STDOnInitResultPeriod* Period() {return &s_periodEvent;}
private:
   static ENUM_INIT_RETCODE InvokeStart();
   static ENUM_INIT_RETCODE InvokeRestart();
   static ENUM_INIT_RETCODE InvokeSymbol();
   static ENUM_INIT_RETCODE InvokePeriod();   
   static ENUM_INIT_RETCODE InvokeParam();
   static void OnDeinitFunc(int reason);
private:
   static STDOnInitResultVoid s_start;
   static STDOnInitResultVoid s_restart;
   static STDOnInitResultVoid s_param;
   static STDOnInitResultSymbol s_symbolEvent;
   static STDOnInitResultPeriod s_periodEvent;
   static string s_symbol;
   static ENUM_TIMEFRAMES s_period;
   static bool s_isStart;
   static bool s_isRestart;
   static bool s_isParam;
};

STDOnInitResultVoid STDOnInit::s_start;
STDOnInitResultVoid STDOnInit::s_restart;
STDOnInitResultVoid STDOnInit::s_param;
STDOnInitResultSymbol STDOnInit::s_symbolEvent;
STDOnInitResultPeriod STDOnInit::s_periodEvent;
string STDOnInit::s_symbol=NULL;
ENUM_TIMEFRAMES STDOnInit::s_period=PERIOD_CURRENT;
bool STDOnInit::s_isStart=false;
bool STDOnInit::s_isRestart=false;
bool STDOnInit::s_isParam=false;

ENUM_INIT_RETCODE STDOnInit::Invoke(){
   if (!s_isStart)
      return InvokeStart();
   if (s_isRestart)
      return InvokeRestart();
   if (s_isParam)
      return InvokeParam();
   ENUM_INIT_RETCODE ret=INIT_SUCCEEDED;
   if (s_symbol!=_Symbol){
      ret = InvokeSymbol();
      if (ret!=INIT_SUCCEEDED)
         return ret;
   }
   if (s_period!=_Period)
      ret=InvokePeriod();
   return ret;
}

ENUM_INIT_RETCODE STDOnInit::InvokeStart(){
   STDOnDeinit::Event().Add(STDOnInit::OnDeinitFunc);
   s_isStart=true;
   s_symbol=_Symbol;
   s_period=_Period;
   return s_start.Invoke();
}

ENUM_INIT_RETCODE STDOnInit::InvokeRestart(){
   s_isRestart=false;
   s_symbol=_Symbol;
   s_period=_Period;
   return s_restart.Invoke();
}

ENUM_INIT_RETCODE STDOnInit::InvokeSymbol(){
   ENUM_INIT_RETCODE ret = s_symbolEvent.Invoke(s_symbol);
   s_symbol=_Symbol;
   return ret;
}

ENUM_INIT_RETCODE STDOnInit::InvokePeriod(){
   ENUM_INIT_RETCODE ret = s_periodEvent.Invoke(s_period);
   s_period=_Period;
   return ret;
}

ENUM_INIT_RETCODE STDOnInit::InvokeParam(){
   s_isParam = false;
   return s_param.Invoke();
}

void STDOnInit::OnDeinitFunc(int reason){
   s_isParam = reason == REASON_PARAMETERS;
}