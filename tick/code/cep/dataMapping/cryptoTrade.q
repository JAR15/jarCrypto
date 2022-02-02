//Mapping cryptoFeed trade data from python FH into clean data

utilDir:getenv `UTILDIR;
schemaDir:getenv `SCHEMADIR;
system "l ",utilDir,"/log.q";
system "l ",utilDir,"/utils.q";
system "l ",utilDir,"/callbacks.q";
/system "l  /home/ec2-user/gitRepo/jarCrypto/tick/code/cep/dataMapping/cepConnectAndReplay.q";
system "l ",schemaDir,"/schema.q";

.map.applyTradeMapping:{[t;x]
	x:.map.venue[x];
	x:.map.sym[x];
	:x
 };

.map.venue:{[x]
 };

.map.sym:{[x]
 };	

registerCallback[`trade;`.map.applyTradeMapping];

