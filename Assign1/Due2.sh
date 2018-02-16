#!/bin/bash

month=$(($(date '+%m')))
day=$(($(date '+%d')))
if [ $month -le 03 ]; then
	
	if [ $day -le 25 ]; then
		echo "Assignment 2 (Elm) is due on: " + "2018 03 19-25" + "--Due"
	
	else
		echo "Assignment 2 (Elm) was due on: " + "2018 03 19-25" + "--Past"
	
	fi

else
	echo "Assingment 2 (Elm) was due on: " + "2018 03 19-25" + "--Past"

fi
