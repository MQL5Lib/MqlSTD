#include "../forwardLink.mqh"

struct __TForwardListStruct{
   static __TForwardListStruct Make(int _a){
      __TForwardListStruct ret{_a};
      return ret;
   }
   int a;
};

class __TForwardListClass{
public:
   __TForwardListClass():a(0){}
   __TForwardListClass(int _a):a(_a){}
   __TForwardListClass(const __TForwardListClass& o):a(o.a){}
   int a;
};

struct __TForwardListTest{
   StdForwardLink<int> t1;
   StdForwardLink<string> t2;
   StdForwardLink<__TForwardListStruct> t3;
   StdForwardLink<__TForwardListClass> t4;
} g_forwardListTest;

bool ForwardLinkPushTest(){
   int a = 65;
   string b = "qwerty";
   __TForwardListStruct c{23};
   g_forwardListTest.t1.Push(new StdForwardLinkNode<int>(123));
   g_forwardListTest.t1.Push(new StdForwardLinkNode<int>(a));
   g_forwardListTest.t2.Push(new StdForwardLinkNode<string>("asdfg"));
   g_forwardListTest.t2.Push(new StdForwardLinkNode<string>(b));
   g_forwardListTest.t3.Push(new StdForwardLinkNode<__TForwardListStruct>(__TForwardListStruct::Make(23)));
   g_forwardListTest.t3.Push(new StdForwardLinkNode<__TForwardListStruct>(c));
   return true;
}

bool ForwardLinkTest(){
   bool ret = ForwardLinkPushTest();
   PrintFormat("ForwardLink test is %s",ret?"ok":"false");
   return true;
}