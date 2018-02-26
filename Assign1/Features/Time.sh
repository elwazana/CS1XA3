#!/bin/bash

# time command: outputs the time either to the nanosecond, millisecond, or regular seconds
read -p "Would you like to see the exact time to the nano/milliseconds? (nano/milli/N): " ANS

# Outputs time to the nanosecond
if [ ${ANS,,} = "nano" ]; then
	echo ""
	echo $(date +"%T.%N")
	echo ""

# Outputs time to the millisecond
elif [ ${ANS,,} = "milli" ]; then
	echo ""
	echo $(date +"%T.%3N")
	echo ""

# Outputs time to the regular seconds
elif [ ${ANS,,} = "n" ]; then
	echo ""
	echo $(date +"%T")	
	echo ""

else
	echo ""
	echo "No such command exists" 
	echo ""

fi 
