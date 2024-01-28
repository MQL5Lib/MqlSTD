template<typename Type>
class STDSingleton:public Type{
private:
   STDSingleton(){}
public:
   static Type* Inst();
   STDSingleton(const STDSingleton& o)=delete;
   Type* operator=(const STDSingleton&)=delete;
};
//-------------------------------------------
template<typename Type>
Type* STDSingleton::Inst(){
   static Type inst;
   return &inst;
}
