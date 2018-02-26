#!/bin/bash

# Main script of ProjectAnalyze
INPUT=	# Blank input needed for looping execution
while [ "${INPUT,,}" != "exit" ] # Loop execution condition
do
	read -p "Enter command: "  INPUT	# Main user command input
	
	if [ "${INPUT,,}" = "state" ]; then	# state command: checks if local repo and master repo are the same
		git status
		
		read -p "Would you like to attempt an update? (Y/N): " INPUT2	# Attempt update, asks to see if the user wants to try an update after executing the repo check feature

		if [ "${INPUT2,,}" = "y" ]; then
		
			git pull

		fi
		
	elif [ "${INPUT,,}" = "changes" ]; then	# changes command: creates a file with all the uncommitted changes
		git diff > changes.log
		
		read -p "Would you like to view contents of changes.log? (Y/N): " INPUT2	# Viewing created file, asks if the user wants to view the created file
		if [ "${INPUT2,,}" = "y" ]; then
		
			cat changes.log
		
		fi

	elif [ "${INPUT,,}" = "todo" ]; then	# todo command: 
		grep -r -h --exclude=ProjectAnalyze.sh --exclude=todo.log "#TODO" ~/CS1XA3/ > todo.log

		read -p "Would you like to view contents of todo.log? (Y/N): " INPUT2	# Viewing created file, asks if the user wants to view the created file
		if [ "${INPUT2,,}" = "y" ]; then

			cat todo.log

		fi

	elif [ "${INPUT,,}" = "error" ];then	# error command: creates a file 'error.log' with all syntax errors found in all haskell files
		find . -type f -name *.hs -exec ghc -fno-code {} \; &> error.log
		
		if [[ -s error.log ]]; then	# Checks if there are any errors
			read -p "Would you like to view contents of error.log? (Y/N): " INPUT2	# Viewing created file, asks if the user wants to view the created file
			if [ "${INPUT2,,}" = "y" ]; then

				cat error.log

			fi
		else
			echo "No errors were found"

		fi

	# Additional feature executed as sub-scripts all stored at CS1XA3/Assign1/Features
	elif [ "${INPUT,,}" = "due" ]; then	
		./Assign1/Features/Due.sh	
	
	elif [ "${INPUT,,}" = "time" ]; then
		./Assign1/Features/Time.sh

	elif [ "${INPUT,,}" = "search" ]; then
		./Assign1//Features/Search.sh

	elif [ "${INPUT,,}" = "replace" ]; then
		./Assign1/Features/Replace.sh
	
	elif [ "${INPUT,,}" = "diff" ]; then
		./Assign1/Features/Diff.sh	

	elif [ "${INPUT,,}" = "exit" ]; then
		break	

	# Error output if the command user input is non-existent
	else
		echo "No such command exists" 
	fi
	
done
