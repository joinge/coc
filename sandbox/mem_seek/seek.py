
# Before this, adb shell in and:
# gdbserver :5039 --attach <pid>


# Host:
# ./adb forward tcp:5039 tcp:5039
# target remote :5039


from subprocess import Popen, PIPE
import os
import re
import numpy as np
import time
import shutil

if not os.path.exists("data"):
   os.mkdir("data")

pid = Popen('/home/me/Apps/Genymotion/genymotion/tools/adb shell "pgrep com.supercell.clashofclans"', shell=True, stdout=PIPE).stdout.read()
pid = int(pid)
proc = Popen('/home/me/Apps/Genymotion/genymotion/tools/adb shell "sh /sdcard/macro/get_pid_memory_locations stack com.supercell.clashofclans "', shell=True, stdout=PIPE)

locs_string = proc.stdout.read()
locs = np.array(re.split("\s", locs_string)).reshape(-1,2)

proc = Popen('/home/me/Apps/Genymotion/genymotion/tools/adb shell "gdbserver :5039 --attach %d"'%pid, shell=True, stdout=PIPE)
time.sleep(3)


#Need only be done once
Popen('/home/me/Apps/Genymotion/genymotion/tools/adb forward tcp:5039 tcp:5039', shell=True, stdout=PIPE).wait()

address_string = ""
for i in range(locs.shape[0]-1):
   address_string += ' -ex "dump memory data/%s-%s.dump 0x%s 0x%s"'%(locs[i,0], locs[i,1], locs[i,0], locs[i,1])
   
   
print "Dump command: %s"%address_string
Popen('gdb --batch -ex "target remote :5039" %s -ex "detach"'%address_string, shell=True, stdout=PIPE).wait()
#    shutil.copy2("%s-%s.dump"%(locs[i,0], locs[i,1]), "./data")
#    os.remove("%s-%s.dump"%(locs[i,0], locs[i,1]))

#cat $LOCS |
#for loc in $LOCS;
   #echo $loc
##    echo "$start $stop"
##    echo "do gdb --batch --pid $2 -ex \"dump memory $2-$start-$stop.dump.$3 0x$start 0x$stop\""
#done