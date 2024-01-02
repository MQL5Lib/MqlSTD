#define _stdCompare ECompare
#define _eMore e_compareMore
#define _eEqually e_compareEqually
#define _eLess e_compareLess

enum ECompare{
   e_compareLess=-1,
   e_compareEqually=0,
   e_compareMore=1
};

template<typename Type1,typename Type2>
bool Less(Type1 l,Type2 r){
   return l<r;
}

template<typename Type1,typename Type2>
bool Greater(Type1 l,Type2 r){
   return r<l;
}

template<typename Type1,typename Type2>
bool Equally(Type1 l,Type2 r){
   return l==r;
}

template<typename Type1,typename Type2>
_stdCompare Compare(Type1 l,Type2 r){
   return l==r?_eEqually:l<r?_eLess:_eMore;
}

_stdCompare Compare(double l,double r,int digits){
   double res=NormalizeDouble(l-r,digits);
   return res==0.0?_eEqually:res<0.0?_eLess:_eMore;
}

_stdCompare Compare(double l,double r,double epsilon){
   double res=l-r;
   return MathAbs(res)<=epsilon?_eEqually:l<r?_eLess:_eMore;
}

_stdCompare Compare(float l,float r,int digits){
   double res=NormalizeDouble(l-r,digits);
   return res==0.0?_eEqually:res<0.0?_eLess:_eMore;
}

_stdCompare Compare(float l,float r,float epsilon){
   float res=l-r;
   return MathAbs(res)<=epsilon?_eEqually:l<r?_eLess:_eMore;
}

_stdCompare CompareEps(double l, double r) {return Compare(l,r,DBL_EPSILON);}

_stdCompare CompareEps(float l, double r) {return Compare(l,r,DBL_EPSILON);}

_stdCompare CompareEps(double l, float r) {return Compare(l,r,DBL_EPSILON);}

template<typename Type>
_stdCompare CompareEps(Type l, double r){return Compare(l,r,DBL_EPSILON);}

template<typename Type>
_stdCompare CompareEps(double l, Type r){return Compare(l,r,DBL_EPSILON);}

template<typename Type>
_stdCompare CompareEps(Type l, float r){return Compare(l,r,FLT_EPSILON);}

template<typename Type>
_stdCompare CompareEps(float l, Type r){return Compare(l,r,FLT_EPSILON);}