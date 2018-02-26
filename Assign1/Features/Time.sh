#!/bin/bash

read -p "Would you like to see the exact time to the nano/milliseconds? (nano/milli/N): " ANS

if [ ${ANS,,} = "nano" ]; then
	echo $(date +"%T.%N")

elif [ ${ANS,,} = "milli" ]; then
	echo $(date +"%T.%3N")

elif [ ${ANS,,} = "n" ]; then
	echo $(date +"%T")	

else
	echo "No such command exists" 

fi 
