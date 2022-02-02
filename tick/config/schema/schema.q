///Trade and Quote Exchanges
//Coinbase
/trade_Coinbase:([] time:"p"$();date:`date$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());
/quote_Coinbase:([] time:"p"$();date:`$();sym:`$();exch:`$();askPrice:"f"$();bidPrice:"f"$());

//Kraken
/trade_Kraken:([] time:"p"$();date:`$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());
/quote_Kraken:([] time:"p"$();date:`$();sym:`$();exch:`$();askPrice:"f"$();bidPrice:"f"$());

//Bitfinex
/trade_Bitfinex:([] time:"p"$();date:`$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());
/quote_Bitfinex:([] time:"p"$();date:`$();sym:`$();exch:`$();askPrice:"f"$();bidPrice:"f"$());

//HitBTC
/trade_HitBTC:([] time:"p"$();date:`$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());
/quote_HitBTC:([] time:"p"$();date:`$();sym:`$();exch:`$();askPrice:"f"$();bidPrice:"f"$());

///Trade only Exchanges
//Bitmex
/trade_Bitmex:([] time:"p"$();date:`$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());

//Bitstamp
/trade_Bitstamp:([] time:"p"$();date:`$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());

//Gemini
/trade_Gemini:([] time:"p"$();date:`$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());

//Huobi
/trade_Huobi:([] time:"p"$();date:`$();sym:`$();exch:`$();side:`$();size:"f"$();price:"f"$());

//distionaries to be used by .u.upd func in tickerpant
/tradeDict:`COINBASE`KRAKEN`HITBTC`BITFINEX!`quote_Coinbase`quote_Kraken`quote_HitBTC`quote_Bitfinex;
/quoteDict:`COINBASE`KRAKEN`HITBTC`BITFINEX`BITMEX`BITSTAMP`GEMINI`HUOBI!`trade_Coinbase`trade_Kraken`trade_Bitfinex`trade_HitBTC`trade_Bitmex`trade_Bitstamp`trade_Gemini`trade_Huobi;


//sample .u.upd

/.u.upd:{$[x=`trade;tradeDict[y[3]] insert y; quoteDict[y[3]] insert y]}

trade:([] time:"p"$();sym:`$();date:`date$();exch:`$();side:`$();size:"f"$();price:"f"$());
quote:([] time:"p"$();sym:`$();date:`date$();sym:`$();exch:`$();askPrice:"f"$();bidPrice:"f"$());
