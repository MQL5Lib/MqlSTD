template<typename Type>
class STDWraper{
public:
   STDWraper(){}
   STDWraper(const Type& _val){value=_val;}
   STDWraper* operator =(const STDWraper& o){
      if (&this != &o)
         value = o.value;
      return &this;
   }
public:
   Type value;
};

template<typename Type>
Type STDWrapeInit(const Type& x){
   return x;
}

#define _rv(v) STDWrapeInit(v)