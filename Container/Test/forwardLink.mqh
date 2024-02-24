#include "../forwardLink.mqh"

struct __TForwardListStruct{
   int a;
};

class __TForwardListClass{
public:
   __TForwardListClass():a(0){}
   __TForwardListClass(int _a):a(_a){}
   __TForwardListClass(const __TForwardListClass& o):a(o.a){}
   int a;
};

bool ForwardLinkPushTest(){
   StdForwardLink<int> t1;
   StdForwardLink<string> t2;
   StdForwardLink<__TForwardListStruct> t3;
   StdForwardLink<__TForwardListClass> t4;
   int a = 65;
   string b = "qwerty";
   t1.Push(new StdForwardLinkNode<int>(123));
   t1.Push(new StdForwardLinkNode<int>(a));
   return true;
}

bool ForwardLinkTest(){
   bool ret = ForwardLinkPushTest();
   PrintFormat("ForwardLink test is %s",ret?"ok":"false");
   return true;
}