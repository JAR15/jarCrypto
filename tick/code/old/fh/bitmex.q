/load log script
utilDir:getenv `UTILDIR;
system "l ", utilDir,"/log.q";

/load schema script
system "l ",utilDir,"/loadSchema.q";

\d .bitmex

api:{[host;apiKey;apiSecret] 
	:(`$":wss://",host) "GET /realtime HTTP/1.1\r\nHost: ",host,"","\r\n\r\n"
 };

api_cmd:{[wshandle;command]
	neg[wshandle] .j.j command
 };

api_sub:{[wshandle;sub_args]
	api_cmd[wshandle;`op`args!(`subscribe;sub_args)]
 };

api_unsub:{[wshandle;unsub_args]
	api_cmd[wshandle;`op`args!(`unsubscribe;unsub_args)]
 };

api_ping:{[wshandle]neg[wshandle]"ping"};

h:hopen`::5001;

.z.ws:{
	xx::.j.k[x];
	if[key[xx]~`table`action`data;
		if[xx[`action]~"insert";
			h(`.u.upd;`trade;) each [select time:ltime`timestamp$"Z"$timestamp,sym:`BTCUSD,EXCH:`BMX,side:`,`float$size,`float$price from xx[`data] 
		]
	];
 };


settings:`apiHost`apiKey`apiSecret!("www.bitmex.com";"";"");
wsh:api[settings`apiHost; settings`apiKey; settings`apiSecret];  
api_sub[first[wsh];"trade:XBTUSD"];



/settings:`apiHost`apiKey`apiSecret!("testnet.bitmex.com";"";"")   //testnet
