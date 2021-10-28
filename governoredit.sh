#!/bin/bash

function question {
echo "Welcome!"
echo "--"
echo "1. Display the current cpu governor
2. Change the current cpu governor"
read -p "What would you like to do? (1/2): " answer
if [ $answer = "1" ]
then declaration
testing
elif [ $answer = "2" ]
then clear 
setup
else
echo "you shouldn't be trying to outsmart me like this :("
sleep 1
clear
question
fi;
}

function decision {
echo "Here are the options: "
echo ---
echo "1. performance
2. schedutil
3. powersave
4. conservative"
echo --- 
read -p "Enter the number of the desired cpu governor: " governor
if [ $governor = 1 ]
then sudo cpupower -c all frequency-set -g performance
echo "The PERFORMANCE governor has been selected." && sleep 1
elif [ $governor = 2 ]
then sudo cpupower -c all frequency-set -g schedutil
echo "The SCHEDUTIL governor has been selected." && sleep 1
elif [ $governor = 3 ]
then sudo cpupower -c all frequency-set -g powersave
echo "The POWERSAVE governor has been selected." && sleep 1
elif [ $governor = 4 ]
then sudo cpupower -c all frequency-set -g conservative
echo "The CONSERVATIVE governor has been selected." && sleep 1
else echo "pls don't try to fool me :("
sleep 1 && unset $governor
decision
fi;
} 

function testing {
read -p "Is this what you wanted? (y/n) " choice
if [ $choice = "y" ]
then echo "ok then" 
     sleep 1 && unset $choice
     kill -9 $PPID
elif [ $choice = "n" ]
then echo "time to edit it then" 
     sleep 1 && unset $choice
     clear
     setup
else echo "quit trying to confuse me :("
     sleep 1 && testing
fi;
}

function declaration {
clear
printf "The current governor is: "
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo --;

}

function setup {
decision
declaration
testing;
}

question

setup


