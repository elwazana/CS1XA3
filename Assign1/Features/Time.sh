#!/bin/bash

read -p "Would you like to see the exact time to the nano/milliseconds? (nano/milli/N): " Ans

if [ ${Ans,,} = "nano" ]; then
	echo $(date +"%T.%N")

elif [ ${Ans,,} = "milli" ]; then
	echo $(date +"%T.%3N")

elif [ ${Ans,,} = "n" ]; then
	echo $(date +"%T")	

else
	echo "No such command exists" 

fi 
