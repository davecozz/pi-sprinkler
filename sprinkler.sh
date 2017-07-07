#!/bin/sh

# usage: $0 <sprinkler#> <minutes>

COILTIME=0.3

# verify inputs
if [ "$1" -eq "$1" ] && [ "$2" -eq "$2" ]; then
  echo "ok"
else
  echo "bad number"
  exit 1
fi

ONPIN=$1
OFFPIN=`expr $1 + 4`

# reset gpio pins
/usr/local/bin/gpio mode $ONPIN output
/usr/local/bin/gpio mode $OFFPIN output

# turn on sprinkler
echo "`date` - Turning sprinkler $ONPIN ON."
/usr/local/bin/gpio write $ONPIN 0
sleep $COILTIME
/usr/local/bin/gpio write $ONPIN 1

# wait for time to elapse
SEC=`expr $2 \* 60`
echo "`date` - Waiting $SEC sec."
sleep $SEC

# turn off sprinkler
echo "`date` - Turning sprinkler $ONPIN OFF."
/usr/local/bin/gpio write $OFFPIN 0
sleep $COILTIME
/usr/local/bin/gpio write $OFFPIN 1
