#!/bin/bash

# time command: outputs the time either to the nanosecond, millisecond, or regular seconds
read -p "Would you like to see the exact time to the nano/milliseconds? (nano/milli/N): " ANS

# Outputs time to the nanosecond
if [ ${ANS,,} = "nano" ]; then
	echo $(date +"%T.%N")

# Outputs time to the millisecond
elif [ ${ANS,,} = "milli" ]; then
	echo $(date +"%T.%3N")

# Outputs time to the regular seconds
elif [ ${ANS,,} = "n" ]; then
	echo $(date +"%T")	

else
	echo "No such command exists" 

fi 
