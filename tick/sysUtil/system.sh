#!/bin/bash
#basic input validations
if [ "$#" -ne 2 ]; then
	echo "Number of input parameters expected: 2"
	exit 1
fi

#read inputs
mode="$1"
proc="$2"

#read env var
source /home/ec2-user/gitRepo/jarCrypto/tick/config/envvar/env.profile

#validate user has selected correct mode
if [[ "$mode" == START || "$mode" == STOP || "$mode" == TEST ]]; then
	echo "Input $mode accepted"
else
	echo "Input $mode not accepted. Script can only be started in START, STOP and TEST modes"
	exit 1
fi

#validate user has selected correct process or ALL processes
if [[ "$proc" == FH || "$proc" == RDB ||  "$proc" == TP || "$proc" == CEP || "$proc" == ALL ]]; then
	echo "Input $proc accepted"
else
	echo "Input $proc not accepted. Script can only start FH, RDB, TP, CEP or ALL processes"
	exit 1
fi

#START
if [[ "$mode" == START ]]; then
	if [[ "$proc" == TP || "$proc" == ALL ]]; then
   		echo "Starting TP..."
   		nohup ~/q/l32/q $CODEDIR/tp/tick.q $SCHEMADIR/schema $ENVDIR/logs/tp -p 5001 -proc TP -q > $LOGDIR/tp/tp.log 2>&1 &
  	fi
	##TODO hardcoded
	if [[ "$proc" == FH || "$proc" == ALL ]]; then
		echo "Starting FH..."
		nohup /usr/bin/python3.9 /home/ec2-user/gitRepo/jarCrypto/cryptofeed/cryptoFinal/crypto.py > $LOGDIR/fh/fh.log 2>&1 &
	fi
	if [[ "$proc" == RDB || "$proc" == ALL ]]; then
		echo "Starting RDB..."
		nohup ~/q/l32/q $CODEDIR/rdb/r.q :5001 :5006 -p 5002 -proc RDB  -q > $LOGDIR/rdb/rdb1.log 2>&1 &
	fi
	if [[ "$proc" == CEP || "$proc" == ALL ]]; then
		echo "starting CEP..."
		nohup ~/q/l32/q $CODEDIR/cep/cryptoTrade.q -p 5004 -proc CEP -q > $LOGDIR/cep/cep.log 2>&1 &
	fi
fi

#STOP
if [[ "$mode" == STOP ]]; then
	if [[ "$proc" == FH || "$proc" == ALL ]]; then
  		echo "Stopping FH..."
 		ps -ef | grep crypto.py | grep -v grep | awk '{print $2}' | xargs kill
	fi
	if [[ "$proc" == RDB || "$proc" == ALL ]]; then
  		echo "Stopping RDB..."
  		ps -ef | grep RDB | grep -v grep | awk '{print $2}' | xargs kill 
	fi
	if [[ "$proc" == TP || "$proc" == ALL ]]; then
  		echo "Stopping TP..."
  		ps -ef | grep TP | grep -v grep | awk '{print $2}' | xargs kill
	fi
	if [[ "$proc" == CEP || "$proc" == ALL ]]; then
  		echo "stopping CEP..."
  		ps -ef | grep CEP | grep -v grep | awk '{print $2}' | xargs kill
	fi
fi

#TEST
if [[ "$mode" == TEST ]]; then
	if [[ "$proc" == FH || "$proc" == ALL ]]; then
  		echo "Checking FH"
  		if [[ "$(ps -ef | grep fh.q | wc -l)" > 1 ]]; then
      			echo "FH is running"
    		else
      			echo "FH is not running"
		fi
	fi
	if [[ "$proc" == RDB || "$proc" == ALL ]]; then
  		echo "Checking RDB..."
  		if [[ "$(ps -ef | grep RDB | wc -l)" > 1 ]]; then
      			echo "RDB is running"
    		else
      			echo "RDB is not running"
    		fi
	fi
	if [[ "$proc" == TP || "$proc" == ALL ]]; then
  	echo "Checking TP..."
		if [[ "$(ps -ef | grep tick.q | wc -l)" > 1 ]]; then
			echo "TP is running"
		else
			echo "TP is not running"
		fi
	fi
	if [[ "$proc" == CEP || "$proc" == ALL ]]; then
  	echo "Checking CEP..."
		if [[ "$(ps -ef | grep agg.q | wc -l)" > 1 ]]; then
      			echo "CEP is running"
    		else
      			echo "CEP is not running"
    		fi
	fi
fi
