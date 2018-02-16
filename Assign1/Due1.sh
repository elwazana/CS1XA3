#!/bin/bash

month=$(($(date '+%m')))
day=$(($(date '+%d')))
if [ $month -le 02 ]; then
	
	if [ $day -le 26 ]; then
		echo "Assignment 1 (Bash) is due on: " + "2018 02 26" + "--Due"
	
	else
		echo "Assignment 1 (Bash) was due on: " + "2018 02 26" + "--Past"
	
	fi

else
	echo "Assingment 1 (Bash) was due on: " + "2018 02 26" + "--Past"

fi
