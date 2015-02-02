#!/bin/bash

cd /home/me/.local/share/genymotion/tools
while true=true
do
  XLOC=$((($RANDOM * 1000 / 32767 * 6/10 + 200) * 2560 / 1000))
  YLOC=$((($RANDOM * 1000 / 32767 * 6/10 + 100) * 1600 / 1000))
  echo "Touching at ${XLOC}x${YLOC}"
  ./adb -s 192.168.56.101:5555 shell input tap ${XLOC} ${YLOC}
  sleep 2
done
cd -