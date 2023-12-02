#include "all.mqh"

_stdEvent0(E0);
_stdEvent1(E1,int&);
_stdEvent2(E2,int&,const string&);
_stdEvent3(E3,int&,const string&,double);
_stdEvent4(E4,int&,const string&,double,int);
_stdEvent5(E5,int&,const string&,double,int,string);

class TTESTEventCommon{
public:
   TTESTEventCommon():
      m_testBool(false){
      m_e0.Add(&this,FooTest0);
      m_e1.Add(&this,FooTest1);
      m_e2.Add(&this,FooTest2);
      m_e3.Add(&this,FooTest3);
      m_e4.Add(&this,FooTest4);
      m_e5.Add(&this,FooTest5);
   }

   bool Test(){
      PrintFormat("%s start",__FUNCTION__);
      
      m_e0.Invoke();
      
      m_e1.Invoke(m_out);
      m_testBool=m_testBool&&m_out==100500;
      
      string in = "100";
      m_e2.Invoke(m_out,in);   
      m_testBool=m_testBool&&m_out==200;
      
      m_e3.Invoke(m_out,in,-200.0);
      m_testBool=m_testBool&&m_out==0;
   
      m_e4.Invoke(m_out,in,-200.0,-1000);
      m_testBool=m_testBool&&m_out==-1000;
   
      m_e5.Invoke(m_out,in,-200.0,400,"400");
      m_testBool=m_testBool&&m_out==800;
      
      PrintFormat("%s test is %s",__FUNCTION__,m_testBool?"ok":"false");
      return m_testBool;   
   }
   
   static bool StaticTest(){
      PrintFormat("%s start",__FUNCTION__);
      
      int out;
      
      s_e0.Invoke();
      
      s_e1.Invoke(out);
      s_testBool=s_testBool&&out==100500;
      
      string in = "100";
      s_e2.Invoke(out,in);   
      s_testBool=s_testBool&&out==200;
      
      s_e3.Invoke(out,in,-200.0);
      s_testBool=s_testBool&&out==0;
   
      s_e4.Invoke(out,in,-200.0,-1000);
      s_testBool=s_testBool&&out==-1000;
   
      s_e5.Invoke(out,in,-200.0,400,"400");
      s_testBool=s_testBool&&out==800;
      
      PrintFormat("%s test is %s",__FUNCTION__,s_testBool?"ok":"false");
      return s_testBool;         
   }
   
   static void StaticTest0() {PrintFormat("%s ok",__FUNCTION__); s_testBool=true;}
private:
   static void FooTest0(void* it){dynamic_cast<TTESTEventCommon*>(it).Test0();}
   static void FooTest1(void* it,int& outInt){dynamic_cast<TTESTEventCommon*>(it).Test1(outInt);}
   static void FooTest2(void* it,int& outInt, const string& inString){dynamic_cast<TTESTEventCommon*>(it).Test2(outInt,inString);}
   static void FooTest3(void* it,int& outInt, const string& inString,double inDouble){dynamic_cast<TTESTEventCommon*>(it).Test3(outInt,inString,inDouble);}
   static void FooTest4(void* it,int& outInt, const string& inString,double inDouble, int inInt){dynamic_cast<TTESTEventCommon*>(it).Test4(outInt,inString,inDouble,inInt);}
   static void FooTest5(void* it,int& outInt, const string& inString,double inDouble, int inInt, string inString2){dynamic_cast<TTESTEventCommon*>(it).Test5(outInt,inString,inDouble,inInt,inString2);}
   
   void Test0(){PrintFormat("%s ok",__FUNCTION__); m_testBool = true;}
   void Test1(int& outInt){PrintFormat("%s ok",__FUNCTION__); outInt=100500;}
   void Test2(int& outInt, const string& inString){
      PrintFormat("%s ok",__FUNCTION__);
      outInt=100 + (int)StringToInteger(inString);
   }
   
   void Test3(int& outInt, const string& inString,double inDouble){
      PrintFormat("%s ok",__FUNCTION__);
      outInt=100 + (int)StringToInteger(inString) + (int)inDouble;
   }
   
   void Test4(int& outInt, const string& inString,double inDouble, int inInt){
      PrintFormat("%s ok",__FUNCTION__);
      outInt=100 + (int)StringToInteger(inString) + (int)inDouble+inInt;
   }
   
   void Test5(int& outInt, const string& inString,double inDouble, int inInt, string inString2){
      PrintFormat("%s ok",__FUNCTION__);
      outInt=100 + (int)StringToInteger(inString) + (int)inDouble + inInt + (int)StringToInteger(inString2);
   }

public:
   static EventE0 s_e0;
   static EventE1 s_e1;
   static EventE2 s_e2;
   static EventE3 s_e3;
   static EventE4 s_e4;
   static EventE5 s_e5;
   static bool s_testBool;
private:
   EventE0 m_e0;
   EventE1 m_e1;
   EventE2 m_e2;
   EventE3 m_e3;
   EventE4 m_e4;
   EventE5 m_e5;
   int m_out;
   bool m_testBool;
};

EventE0 TTESTEventCommon::s_e0;
EventE1 TTESTEventCommon::s_e1;
EventE2 TTESTEventCommon::s_e2;
EventE3 TTESTEventCommon::s_e3;
EventE4 TTESTEventCommon::s_e4;
EventE5 TTESTEventCommon::s_e5;
bool TTESTEventCommon::s_testBool=false;

bool test_eventTestBool = false;

void Test0(){PrintFormat("%s ok",__FUNCTION__); test_eventTestBool = true;}
void Test1(int& outInt){PrintFormat("%s ok",__FUNCTION__); outInt=100500;}
void Test2(int& outInt, const string& inString){
   PrintFormat("%s ok",__FUNCTION__);
   outInt=100 + (int)StringToInteger(inString);
}

void Test3(int& outInt, const string& inString,double inDouble){
   PrintFormat("%s ok",__FUNCTION__);
   outInt=100 + (int)StringToInteger(inString) + (int)inDouble;
}

void Test4(int& outInt, const string& inString,double inDouble, int inInt){
   PrintFormat("%s ok",__FUNCTION__);
   outInt=100 + (int)StringToInteger(inString) + (int)inDouble+inInt;
}

void Test5(int& outInt, const string& inString,double inDouble, int inInt, string inString2){
   PrintFormat("%s ok",__FUNCTION__);
   outInt=100 + (int)StringToInteger(inString) + (int)inDouble + inInt + (int)StringToInteger(inString2);
}

bool EventTest(){
   PrintFormat("%s start",__FUNCTION__);
   bool ret = EventCommon();
   PrintFormat("SystemEvent test is %s",ret?"ok":"false");
   return ret;
}

bool EventCommon(){
   PrintFormat("%s start",__FUNCTION__);
   EventE0 e0;
   EventE1 e1;
   EventE2 e2;
   EventE3 e3;
   EventE4 e4;
   EventE5 e5;
   bool ret = true;
   int out=0;
   e0.Add(Test0);
   e1.Add(Test1);
   e2.Add(Test2);
   e3.Add(Test3);
   e4.Add(Test4);
   e5.Add(Test5);
   
   e0.Invoke();
   ret=ret&&test_eventTestBool;
   
   e1.Invoke(out);
   ret=ret&&out==100500;
   
   string in = "100";
   e2.Invoke(out,in);   
   ret=ret&&out==200;
   
   e3.Invoke(out,in,-200.0);
   ret=ret&&out==0;

   e4.Invoke(out,in,-200.0,-1000);
   ret=ret&&out==-1000;

   e5.Invoke(out,in,-200.0,400,"400");
   ret=ret&&out==800;
   
   TTESTEventCommon test;
   
   ret=ret&&test.Test();
   
   TTESTEventCommon::s_e0.Add(TTESTEventCommon::StaticTest0);
   TTESTEventCommon::s_e1.Add(Test1);
   TTESTEventCommon::s_e2.Add(Test2);
   TTESTEventCommon::s_e3.Add(Test3);
   TTESTEventCommon::s_e4.Add(Test4);
   TTESTEventCommon::s_e5.Add(Test5);

   ret=ret&&TTESTEventCommon::StaticTest();
   
   PrintFormat("SystemEventCommon test is %s",ret?"ok":"false");
   return ret;   
}