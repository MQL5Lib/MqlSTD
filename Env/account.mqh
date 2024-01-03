#include "../memory.mqh"
#include "../pattern.mqh"

#define _stdAccount STDSingleton<STDAccount>::Inst()

class STDAccount{
public:
   static bool IsFifoClose() {return (bool)Get(ACCOUNT_FIFO_CLOSE);}
   static bool IsHedgeAlloed() {return (bool)Get(ACCOUNT_HEDGE_ALLOWED);}

   static long Login() {return Get(ACCOUNT_LOGIN);}
   static long Leverage() {return Get(ACCOUNT_LEVERAGE);}
   
   static double Ballance() {return Get(ACCOUNT_BALANCE);}
   static double Credit() {return Get(ACCOUNT_CREDIT);}
   static double Profit() {return Get(ACCOUNT_PROFIT);}
   static double Equity() {return Get(ACCOUNT_EQUITY);}
   static double Margin() {return Get(ACCOUNT_MARGIN);}
   static double MarginFree() {return Get(ACCOUNT_MARGIN_FREE);}
   static double MarginLevel() {return Get(ACCOUNT_MARGIN_LEVEL);}
   static double MarginCall() {return Get(ACCOUNT_MARGIN_SO_CALL);}
   static double MarginStopOut() {return Get(ACCOUNT_MARGIN_SO_SO);}
   static double MarginInitial() {return Get(ACCOUNT_MARGIN_INITIAL);}
   static double MarginMaintenance() {return Get(ACCOUNT_MARGIN_MAINTENANCE);}
   static double Assets() {return Get(ACCOUNT_ASSETS);}
   static double Liabikities() {return Get(ACCOUNT_LIABILITIES);}
   static double ComissionBlocked() {return Get(ACCOUNT_COMMISSION_BLOCKED);}
   
   static int LimitOrders()  {return (int)Get(ACCOUNT_LIMIT_ORDERS);}
   static int CurrencyDigits()  {return (int)Get(ACCOUNT_CURRENCY_DIGITS);}
   
   static ENUM_ACCOUNT_TRADE_MODE TradeMode() {return (ENUM_ACCOUNT_TRADE_MODE)Get(ACCOUNT_TRADE_MODE);}
   static ENUM_ACCOUNT_STOPOUT_MODE StopOutMode() {return (ENUM_ACCOUNT_STOPOUT_MODE)Get(ACCOUNT_MARGIN_SO_MODE);}
   
   static string Name() {return Get(ACCOUNT_NAME);}
   static string Server() {return Get(ACCOUNT_SERVER);}
   static string Currency() {return Get(ACCOUNT_CURRENCY);}
   static string Company() {return Get(ACCOUNT_COMPANY);}
   
   static long Get(ENUM_ACCOUNT_INFO_INTEGER propId) {return AccountInfoInteger(propId);}
   static double Get(ENUM_ACCOUNT_INFO_DOUBLE propId) {return AccountInfoDouble(propId);}
   static string Get(ENUM_ACCOUNT_INFO_STRING propId) {return AccountInfoString(propId);}
};