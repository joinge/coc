#!/bin/bash

cd /home/me/Apps/Genymotion/genymotion/tools

DUMPSYS_LOG=$(./adb -s 192.168.100.10:5555 shell dumpsys | grep mUnrestrictedScreen)
WIDTH="$(echo $DUMPSYS_LOG | sed 's/.*\s\([0-9]\{1,5\}\)x\([0-9]\{1,5\}\).*/\1/')"
HEIGHT="$(echo $DUMPSYS_LOG | sed 's/.*\s\([0-9]\{1,5\}\)x\([0-9]\{1,5\}\).*/\2/')"

echo "Android screen resolution: ${WIDTH}x${HEIGHT}"

while true=true                                                                                                                            
do
  SLEEP=$(($RANDOM * 25 / 32767 + 5))
  LOC=$(($RANDOM / 100))        
  XLOC=$((($RANDOM * 1000 / 32767 * 4/10 + 400) * ${WIDTH} / 1000))
  YLOC=$((($RANDOM * 1000 / 32767 * 6/10 + 100) * ${HEIGHT} / 1000))

  xprop -id $(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2) _NET_WM_NAME | grep Genymotion >/dev/null
  
  if [ $? -eq 0 ]; then
     echo "Emulator is in use. Waiting a bit..."
     sleep 15
  else
     echo "Touching at ${XLOC}x${YLOC}"                                                                                                                  
    ./adb -s 192.168.100.10:5555 shell input tap ${XLOC} ${YLOC}
     sleep $SLEEP
  fi

done
cd -
