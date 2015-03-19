#!/bin/bash

grep $1 /proc/$2/maps |
sed -n 's/^\([0-9a-f]*\)-\([0-9a-f]*\) .*$/\1 \2/p' |
while read start stop;
   do gdb --batch --pid $2 -ex "dump memory $2-$start-$stop.dump.$3 0x$start 0x$stop";
done