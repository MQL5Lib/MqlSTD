#include "Event/test.mqh"

bool SystemTest(){
   bool ret = EventTest();
   PrintFormat("System test is %s",ret?"ok":"false");
   return ret;
}