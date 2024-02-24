#include "Container/Test/test.mqh"
//#include "System/test.mqh"

bool TestScript(){
   bool ret = ContainerTest();
   //bool ret = SystemTest();
   PrintFormat("MqlStd test is %s",ret?"ok":"false");
   return ret;
}