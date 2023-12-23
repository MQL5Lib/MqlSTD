template<typename OutType, typename Func>
class STDLazyEnvGet1{
public:
   STDLazyEnvGet1(Func func):m_func(func),m_isInit(false){}
   
   STDLazyEnvGet1(const STDLazyEnvGet1& o){this=o;}
   
   STDLazyEnvGet1* operator=(const STDLazyEnvGet1& o){
      m_func=o.m_func;
      m_val=o.m_val;
      m_isInit=o.m_isInit;
      return &this;
   }
   
   void Reset() {m_isInit=false;}
   
   template<typename ParamType>
   OutType Get(ParamType param) const{
      if (m_isInit)
         return m_val;
      ((STDLazyEnvGet1*)&this).m_val=m_func(param);
      ((STDLazyEnvGet1*)&this).m_isInit = true;
      return m_val;
   }
private:
   Func m_func;
   OutType m_val;
   bool m_isInit;
};