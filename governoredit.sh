#!/bin/bash

function decision {
read -p "Specify the desired cpu governor: " governor
if [ $governor = 1 ]
then sudo cpupower -c all frequency-set -g performance
echo "The PERFORMANCE governor has been selected." && sleep 1
elif [ $governor = 2 ]
then sudo cpupower -c all frequency-set -g schedutil
echo "The SCHEDUTIL governor has been selected." && sleep 1
else echo "pls don't try to fool me :("
sleep 1 && unset $governor
decision
fi; 
} 

function testing {
read -p "Is this correct? (y/n) " choice
if [ $choice = "y" ]
then echo "ok then" 
     sleep 1 && kill -9 $PPID
elif [ $choice = "n" ]
then echo "rip" 
     sleep 1 && kill -9 $PPID
else echo "lmao what"
     sleep 1 && testing
fi;
}

echo "Here are the options: "
echo ---
echo "1. performance
2. schedutil"
echo --- 

decision

sleep 1
clear
echo "All done!" 
sleep 1
printf "The current governor is: "
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

testing
