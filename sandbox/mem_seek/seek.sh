#!/bin/bash

# mkdir data
# rm data/*

pid=$(pgrep small_proc)
grep stack /proc/${pid}/maps | sed -n 's/^\([0-9a-f]*\)-\([0-9a-f]*\) .*$/\1 \2/p' |
while read start stop; do
    echo "| $start $stop |"
#     gdb --batch --pid ${pid} -ex "dump memory $start-$stop.dump$1 0x$start 0x$stop"
#    gdb --batch --pid ${pid} -ex "find dump memory $start-$stop.dump$1 0x$start 0x$stop"
done

# hexdump myfile1.bin > myfile1.hex
# hexdump myfile2.bin > myfile2.hex