//read inputs
\d .log
currentProc:first (.Q.opt .z.X)`proc;

if[not `currentProc in key `.u;.u.currentProc:"NA PROC"];
if[0=count .u.currentProc;.u.currentProc:"NA PROC"];

if[not `logfile in key `.u;.u.logfile:`:logfile.log;logh:hopen .u.logfile];

out:{[logmsg]
	if[not 10=type logmsg;logmsg:string logmsg];
	if[`logh in key `.;
		[	
		neg[logh]((string .z.p)," ",.u.currentProc," LOG: ",logmsg);
		neg[logh]((string .z.P)," ",.u.currentProc," Current memory usage: ",(string .Q.w[]`used))
		]
	];
 };

err:{[logmsg]
	if[not 10=type logmsg;logmsg:string logmsg];
	if[`logh in key `.;
		neg[logh]((string .z.p)," ",.u.currentProc," ERROR: ",logmsg)
	];
 };
