#include "../event.mqh"
#include "../memory.mqh"
#include "../Math/compare.mqh"

class STDSymbol;

#define _stdChartSymbol STDSingleton<STDSymbol>::Inst()

_stdEvent2(SymbolReset,const STDSymbol&,const string&);

class STDTick{
public:
   STDTick(const string& symbol) {SymbolInfoTick(symbol,m_tick);}
   STDTick(const MqlTick& tick) {m_tick=tick;}
   STDTick(const STDTick& o){this=o;}
   STDTick* operator = (const STDTick& o) {m_tick=o.m_tick; return &this;}
   datetime Time() const {return m_tick.time;}
   long TimeMS() const {return m_tick.time_msc;}
   double Ask() const {return m_tick.ask;}
   double Bid() const {return m_tick.bid;}
   double Las() const {return m_tick.last;}
   ulong Volume() const {return m_tick.volume;}
   uint Flags() const {return m_tick.flags;}
   double VolumeReal() const {return m_tick.volume_real;}
private:
   MqlTick m_tick;
};

class STDSymbol{
public:
   EventSymbolReset eventReset;
public:
   STDSymbol(){Init("");}
   STDSymbol(const string& symbol){Init(symbol);}
public:
   bool Reset() {return Reset("");}
   bool Reset(const string& symbol); 

   bool IsExist() const {return (bool)Get(SYMBOL_EXIST);}
   bool IsExist(bool& isCustom) const {return SymbolExist(m_symbol,isCustom);}
   bool IsMarginHedgedUseLeg() const {return (bool)Get(SYMBOL_MARGIN_HEDGED_USE_LEG);}
   bool IsSelect() const {return (bool)Get(SYMBOL_SELECT);}
   bool IsSpreadFloat() const {return (bool)Get(SYMBOL_SPREAD_FLOAT);}
   bool IsSubscriptionDelay() const {return (bool)Get(SYMBOL_SUBSCRIPTION_DELAY);}
   bool IsSymbolCustom() const {return (bool)Get(SYMBOL_CUSTOM);}
   bool IsSynchronized() const {return SymbolIsSynchronized(m_symbol);}
   bool IsVisible() const {return (bool)Get(SYMBOL_VISIBLE);}
   
   bool CheckStopLevel(int points) const {return MathAbs(points) >= StopLevel();}
   bool CheckStopLevel(double delta) const {return Compare(MathAbs(delta),StopLevel()*Point(),Digits())!=_eLess;}
   bool CheckStopLevel(double price1, double price2) const {return CheckStopLevel(price1-price2);}
   bool CheckFreezeLevel(int points) const {return MathAbs(points) >= FreezeLevel();}
   bool CheckFreezeLevel(double delta) const {return Compare(MathAbs(delta),FreezeLevel()*Point(),Digits())!=_eLess;}
   bool CheckFreezeLevel(double price1, double price2) const {return CheckFreezeLevel(price1-price2);}
   
   _stdCompare CheckPrice(double price, double checked) const {return Compare(price,checked,Digits());}
   
   color BackgroundColor() const {return (color)Get(SYMBOL_BACKGROUND_COLOR);}

   datetime ExpirationTime() const {return (datetime)Get(SYMBOL_EXPIRATION_TIME);}
   datetime StartTime() const {return (datetime)Get(SYMBOL_START_TIME);}
   datetime Time() const {return (datetime)Get(SYMBOL_TIME);}

   double AccruedInterest() const {return Get(SYMBOL_TRADE_ACCRUED_INTEREST);}
   double Ask() const {return Get(SYMBOL_ASK);}
   double AskHigh() const {return Get(SYMBOL_ASKHIGH);}
   double AskLow() const {return Get(SYMBOL_ASKLOW);}   
   double Bid() const {return Get(SYMBOL_BID);}
   double BidHigh() const {return Get(SYMBOL_BIDHIGH);}
   double BidLow() const {return Get(SYMBOL_BIDLOW);}
   double ContractSize() const {return Get(SYMBOL_TRADE_CONTRACT_SIZE);} 
   double FaceValue() const {return Get(SYMBOL_TRADE_FACE_VALUE);}
   double Last() const {return Get(SYMBOL_LAST);}
   double LastHigh() const {return Get(SYMBOL_LASTHIGH);}
   double LastLow() const {return Get(SYMBOL_LASTLOW);}
   double LiquidityRate() const {return Get(SYMBOL_TRADE_LIQUIDITY_RATE);}
   double MarginHedged() const {return Get(SYMBOL_MARGIN_HEDGED);}
   double MarginInitial() const {return Get(SYMBOL_MARGIN_INITIAL);}
   double MarginMaintenance() const {return Get(SYMBOL_MARGIN_MAINTENANCE);}
   double OptionStrike() const {return Get(SYMBOL_OPTION_STRIKE);}
   double Point() const {return m_point;}
   double PriceChange() const {return Get(SYMBOL_PRICE_CHANGE);}
   double PriceDelta() const {return Get(SYMBOL_PRICE_DELTA);}
   double PriceGamma() const {return Get(SYMBOL_PRICE_GAMMA);}
   double PriceOmega() const {return Get(SYMBOL_PRICE_OMEGA);}   
   double PriceSensitivity() const {return Get(SYMBOL_PRICE_SENSITIVITY);}
   double PriceTheoretical() const {return Get(SYMBOL_PRICE_THEORETICAL);}
   double PriceTheta() const {return Get(SYMBOL_PRICE_THETA);}
   double PriceVega() const {return Get(SYMBOL_PRICE_VEGA);}
   double PriceVolatility() const {return Get(SYMBOL_PRICE_VOLATILITY);}
   double PriceRho() const {return Get(SYMBOL_PRICE_RHO);}
   double SessionAw() const {return Get(SYMBOL_SESSION_AW);}
   double SessionBuyOrdersVolume() const {return Get(SYMBOL_SESSION_BUY_ORDERS_VOLUME);}
   double SessionClose() const {return Get(SYMBOL_SESSION_CLOSE);}
   double SessionInterest() const {return Get(SYMBOL_SESSION_INTEREST);}
   double SessionOpen() const {return Get(SYMBOL_SESSION_OPEN);}
   double SessionVolume() const {return Get(SYMBOL_SESSION_VOLUME);}
   double SessionPriceLimitMax() const {return Get(SYMBOL_SESSION_PRICE_LIMIT_MAX);}
   double SessionPriceLimitMin() const {return Get(SYMBOL_SESSION_PRICE_LIMIT_MIN);}
   double SessionSellOrdersVolume() const {return Get(SYMBOL_SESSION_SELL_ORDERS_VOLUME);}
   double SessionPriceSettlement() const {return Get(SYMBOL_SESSION_PRICE_SETTLEMENT);}
   double SessionTurnover() const {return Get(SYMBOL_SESSION_TURNOVER);}
   double Swap(ENUM_DAY_OF_WEEK day) const;
   double SwapSunday() const {return Get(SYMBOL_SWAP_SUNDAY);}
   double SwapMonday() const {return Get(SYMBOL_SWAP_MONDAY);}
   double SwapTuesday() const {return Get(SYMBOL_SWAP_TUESDAY);}
   double SwapWednesday() const {return Get(SYMBOL_SWAP_WEDNESDAY);}
   double SwapThursday() const {return Get(SYMBOL_SWAP_THURSDAY);}
   double SwapFriday() const {return Get(SYMBOL_SWAP_FRIDAY);}
   double SwapSaturday() const {return Get(SYMBOL_SWAP_SATURDAY);}
   double TickSize() const {return Get(SYMBOL_TRADE_TICK_SIZE);}
   double TickValue() const {return Get(SYMBOL_TRADE_TICK_VALUE);}
   double TickValueProfit() const {return Get(SYMBOL_TRADE_TICK_VALUE_PROFIT);}
   double TickValueLoss() const {return Get(SYMBOL_TRADE_TICK_VALUE_LOSS);}
   double VolumeLimit() const {return Get(SYMBOL_VOLUME_LIMIT);}   
   double VolumeMax() const {return Get(SYMBOL_VOLUME_MAX);}
   double VolumeMin() const {return Get(SYMBOL_VOLUME_MIN);}
   double VolumeReal() const {return Get(SYMBOL_VOLUME_REAL);}
   double VolumeRealHigh() const {return Get(SYMBOL_VOLUMEHIGH_REAL);}
   double VolumeRealLow() const {return Get(SYMBOL_VOLUMELOW_REAL);}
   double VolumeStep() const {return m_volumeStep;}   
   
   int Digits() const {return m_digits;}
   int LotDigits() const {return m_lotDigits;}
   int FreezeLevel() const {return (int)Get(SYMBOL_TRADE_FREEZE_LEVEL);}
   int Spread() const {return (int)Get(SYMBOL_SPREAD);}
   int StopLevel() const {return (int)Get(SYMBOL_TRADE_STOPS_LEVEL);}
   int TicksBookDepth() const {return (int)Get(SYMBOL_TICKS_BOOKDEPTH);}
   
   long SessionDeals() const {return Get(SYMBOL_SESSION_DEALS);}
   long SessionBuyOrders() const {return Get(SYMBOL_SESSION_BUY_ORDERS);}
   long SessionSellOrders() const {return Get(SYMBOL_SESSION_SELL_ORDERS);}
   long Volume() const {return Get(SYMBOL_VOLUME);}
   long VolumeHigh() const {return Get(SYMBOL_VOLUMEHIGH);}
   long VolumeLow() const {return Get(SYMBOL_VOLUMELOW);}
   long TimeMsc() const {return Get(SYMBOL_TIME_MSC);}   
   
   string Symbol() const {return m_symbol;}
   string Basis() const {return Get(SYMBOL_BASIS);}
   string Category() const {return Get(SYMBOL_CATEGORY);}
   string Country() const {return Get(SYMBOL_COUNTRY);}
   string SectorName() const {return Get(SYMBOL_SECTOR_NAME);}
   string IndustryName() const {return Get(SYMBOL_INDUSTRY_NAME);}
   string CurrencyBase() const {return Get(SYMBOL_CURRENCY_BASE);}
   string CurrencyProfit() const {return Get(SYMBOL_CURRENCY_PROFIT);}
   string CurrencyMargine() const {return Get(SYMBOL_CURRENCY_MARGIN);}
   string Bank() const {return Get(SYMBOL_BANK);}
   string Description() const {return Get(SYMBOL_DESCRIPTION);}
   string Exchange() const {return Get(SYMBOL_EXCHANGE);}
   string Formula() const {return Get(SYMBOL_FORMULA);}
   string Isin() const {return Get(SYMBOL_ISIN);}
   string Page() const {return Get(SYMBOL_PAGE);}
   string Path() const {return Get(SYMBOL_PATH);}
   
   uint ExpirationMode() const {return (uint)Get(SYMBOL_EXPIRATION_MODE);}
   uint FillingMode() const {return (uint)Get(SYMBOL_FILLING_MODE);}
   uint OrderMode() const {return (uint)Get(SYMBOL_ORDER_MODE);}
   
   ENUM_DAY_OF_WEEK SwapRollover3Days() const {return (ENUM_DAY_OF_WEEK)Get(SYMBOL_SWAP_ROLLOVER3DAYS);}
   ENUM_SYMBOL_CALC_MODE TradeCalcMode() const {return (ENUM_SYMBOL_CALC_MODE)Get(SYMBOL_TRADE_CALC_MODE);}
   ENUM_SYMBOL_CHART_MODE ChartMode() const {return (ENUM_SYMBOL_CHART_MODE)Get(SYMBOL_CHART_MODE);}
   ENUM_SYMBOL_INDUSTRY Industry() const {return (ENUM_SYMBOL_INDUSTRY)Get(SYMBOL_INDUSTRY);}
   ENUM_SYMBOL_OPTION_MODE OptionMode() const {return (ENUM_SYMBOL_OPTION_MODE)Get(SYMBOL_OPTION_MODE);}
   ENUM_SYMBOL_OPTION_RIGHT OptionRight() const {return (ENUM_SYMBOL_OPTION_RIGHT)Get(SYMBOL_OPTION_RIGHT);}
   ENUM_SYMBOL_ORDER_GTC_MODE OrderGtcMode() const {return (ENUM_SYMBOL_ORDER_GTC_MODE)Get(SYMBOL_ORDER_GTC_MODE);}
   ENUM_SYMBOL_SECTOR Sector() const {return (ENUM_SYMBOL_SECTOR)Get(SYMBOL_SECTOR);}
   ENUM_SYMBOL_SWAP_MODE TradeSwapMode() const {return (ENUM_SYMBOL_SWAP_MODE)Get(SYMBOL_SWAP_MODE);}
   ENUM_SYMBOL_TRADE_EXECUTION TredeExecutionMode() const {return (ENUM_SYMBOL_TRADE_EXECUTION)Get(SYMBOL_TRADE_EXEMODE);}
   ENUM_SYMBOL_TRADE_MODE TradeMode() const {return (ENUM_SYMBOL_TRADE_MODE)Get(SYMBOL_TRADE_MODE);}  
   
   bool LastTick(MqlTick& tick) const {return SymbolInfoTick(m_symbol,tick);}
   STDSharedPtr<STDTick> LastTick() const;
   bool InfoMarginRate(ENUM_ORDER_TYPE orderType,double& initialRate,double& maintenanceRate) const {return SymbolInfoMarginRate(m_symbol,orderType,initialRate,maintenanceRate);}
   bool InfoSessionQuote(ENUM_DAY_OF_WEEK day,uint index, datetime& from, datetime& to) const {return SymbolInfoSessionQuote(m_symbol,day,index,from,to);}
   bool InfoSessionTrade(ENUM_DAY_OF_WEEK day,uint index, datetime& from, datetime& to) const {return SymbolInfoSessionTrade(m_symbol,day,index,from,to);}
   
   long Get(ENUM_SYMBOL_INFO_INTEGER propId) const {return SymbolInfoInteger(m_symbol,propId);}
   double Get(ENUM_SYMBOL_INFO_DOUBLE propId) const {return SymbolInfoDouble(m_symbol,propId);}
   string Get(ENUM_SYMBOL_INFO_STRING propId) const {return SymbolInfoString(m_symbol,propId);}
   
   bool Select(bool isSelect) {return SymbolSelect(m_symbol,isSelect);}
private:
   static string _StringFoo(const STDSymbol& it,ENUM_SYMBOL_INFO_STRING propId) {return it.Get(propId);}
   static ENUM_INIT_RETCODE ChartSymbolChangeFunc(void* self,const string&){return dynamic_cast<STDSymbol*>(self).ChartSymbolChange();}
   void Init(const string& symbol);
   ENUM_INIT_RETCODE ChartSymbolChange();
private:
   string m_symbol;
   double m_point;
   double m_volumeStep;
   int m_digits;
   int m_lotDigits;
   bool m_isValid;
   bool m_isCastom;
   bool m_isChartSymbol;
};
//------------------------------------------------
void STDSymbol::Init(const string& symbol){
   m_isChartSymbol=false;
   m_symbol=NULL;
   Reset(symbol);
   STDOnInit::Symbol().Add(&this,ChartSymbolChangeFunc);
}
//-------------------------------------------------
bool STDSymbol::Reset(const string &symbol){
   if (symbol==m_symbol && symbol!=NULL)
      return true;
   string oldSymbol = m_symbol;
   bool isChartSymbol = symbol==NULL || symbol=="";
   m_symbol = isChartSymbol?_Symbol:symbol;
   m_isCastom=false;
   m_isValid = isChartSymbol || SymbolExist(m_symbol,m_isCastom);
   if (isChartSymbol!=m_isChartSymbol){
      if (isChartSymbol)
         STDOnInit::Symbol().Add(&this,ChartSymbolChangeFunc);
      else
         STDOnInit::Symbol().Remove(&this,ChartSymbolChangeFunc);      
   }
   m_digits = (int)Get(SYMBOL_DIGITS);
   m_point = Get(SYMBOL_POINT);
   m_volumeStep = Get(SYMBOL_VOLUME_STEP);
   m_lotDigits=MathMax(-(int)MathFloor(MathLog10(m_volumeStep)),0);
   eventReset.Invoke(this,oldSymbol);
   return m_isValid;
}
//-------------------------------------------------
ENUM_INIT_RETCODE STDSymbol::ChartSymbolChange(void){
   Reset("");
   return INIT_SUCCEEDED;
}
//-------------------------------------------------
STDSharedPtr<STDTick> STDSymbol::LastTick(void) const{
   MqlTick tick;
   if (!SymbolInfoTick(m_symbol,tick))
      return NULL;
   else return new STDTick(tick);
}
//---------------------------------------------------
double STDSymbol::Swap(ENUM_DAY_OF_WEEK day) const{
   switch(day){
      case SUNDAY: return SwapSunday();
      case MONDAY: return SwapMonday();
      case TUESDAY: return SwapTuesday();
      case WEDNESDAY: return SwapWednesday();
      case THURSDAY: return SwapThursday();
      case FRIDAY: return SwapFriday();
      case SATURDAY: return SwapSaturday();      
   }
   return 0.0;
}