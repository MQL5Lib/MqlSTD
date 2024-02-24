#include "forwardlink.mqh"

bool ContainerTest(){
   bool ret = ForwardLinkTest();
   PrintFormat("Container test is %s",ret?"ok":"false");
   return ret;
}