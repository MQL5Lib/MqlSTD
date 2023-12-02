#include "System/test.mqh"

bool Test(){
   bool ret = SystemTest();
   PrintFormat("MqlStd test is %s",ret?"ok":"false");
   return ret;
}