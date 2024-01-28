template<typename OutType, typename Func>
class STDLazyEnvGetBase{
public:
   bool IsInit() const {return m_func!=NULL;}

   void Reset(Func func=NULL) {
      m_hasValue=false;
      m_func=func;
   }
protected:
   STDLazyEnvGetBase():m_func(NULL),m_hasValue(false){}
   STDLazyEnvGetBase(Func func):m_func(func),m_hasValue(false){}
   
   OutType _Get(OutType val) const{
      ((STDLazyEnvGetBase*)&this).m_val=val;
      ((STDLazyEnvGetBase*)&this).m_hasValue = true;
      return m_val;
   }
protected:
   Func m_func;
   OutType m_val;
   bool m_hasValue; 
};

template<typename OutType, typename Func>
class STDLazyEnvGet0: public STDLazyEnvGetBase<OutType,Func>{
public:
   STDLazyEnvGet0():STDLazyEnvGetBase<OutType,Func>(){}
   STDLazyEnvGet0(Func func):STDLazyEnvGetBase<OutType,Func>(func){}
   
   OutType Get() const{
      if (m_hasValue)
         return m_val;
      else return _Get(m_func());
   }
private:
};

template<typename OutType, typename Func>
class STDLazyEnvGet1: public STDLazyEnvGetBase<OutType,Func>{
public:
   STDLazyEnvGet1():STDLazyEnvGetBase<OutType,Func>(){}
   STDLazyEnvGet1(Func func):STDLazyEnvGetBase<OutType,Func>(func){}
   
   template<typename ParamType>
   OutType Get(const ParamType& param) const{
      if (m_hasValue)
         return m_val;
      else return _Get(m_func(param));
   }
private:
};

template<typename OutType, typename Func>
class STDLazyEnvGet2: public STDLazyEnvGetBase<OutType,Func>{
public:
   STDLazyEnvGet2():STDLazyEnvGetBase<OutType,Func>(){}
   STDLazyEnvGet2(Func func):STDLazyEnvGetBase<OutType,Func>(func){}
   
   template<typename PT1, typename PT2>
   OutType Get(const PT1& p1,const PT2& p2) const{
      if (m_hasValue)
         return m_val;
      else return _Get(m_func(p1,p2));
   }
private:
};