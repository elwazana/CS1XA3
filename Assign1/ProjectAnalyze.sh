#!/bin/bash

Input=filler
while [ "${Input,,}" != "exit" ]
do
	read -p "Enter command: "  Input
	if [ "${Input,,}" = "state" ]; then
		git status
		
		read -p "Would you like to attempt an update? (Y/N): " Input2
		if [ "${Input2,,}" = "y" ]; then
		
			git pull

		fi
		
	elif [ "${Input,,}" = "changes" ]; then
		git diff > changes.log
		
		read -p "Would you like to view changes.log? (Y/N): " Input2
		if [ "${Input2,,}" = "y" ]; then
		
			vim changes.log
		
		fi

	elif [ "${Input,,}" = "todo" ]; then
		grep -r --exclude=todo.log "#TODO" ~/CS1XA3/Assign1 > todo.log

		read -p "Would you like to view todo.log? (Y/N): " Input2
		if [ "${Input2,,}" = "y" ]; then

			vim todo.log

		fi

	elif [ "${Input,,}" = "error" ];then
		ghc -fno-code *.hs &>> error.log

		read -p "Would you like to view error.log? (Y/N): " Input2
		if [ "${Input2,,}" = "y" ]; then

			vim error.log

		fi

	elif [ "${Input,,}" = "due1" ]; then
		./Due1.sh

	elif [ "${Input,,}" = "due2" ]; then
		./Due2.sh

	elif [ "${Input,,}" = "due3" ]; then
                ./Due3.sh
	
	elif [ "${Input,,}" = "exit" ]; then
		break
	
	else
		echo "No such command exists" 
	fi
	
done
