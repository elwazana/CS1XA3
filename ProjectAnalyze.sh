#!/bin/bash

# Main script of ProjectAnalyze
Input=	# Blank input needed for looping execution
while [ "${Input,,}" != "exit" ] # Loop execution condition
do
	read -p "Enter command: "  Input	# Main user command input
	
	if [ "${Input,,}" = "state" ]; then	# state command: checks if local repo and master repo are the same
		git status
		
		read -p "Would you like to attempt an update? (Y/N): " Input2	# Attempt update, asks to see if the user wants to try an update after executing the repo check feature

		if [ "${Input2,,}" = "y" ]; then
		
			git pull

		fi
		
	elif [ "${Input,,}" = "changes" ]; then	# changes command: creates a file with all the uncommitted changes
		git diff > changes.log
		
		read -p "Would you like to view changes.log? (Y/N): " Input2	# Viewing created file, asks if the user wants to view the created file
		if [ "${Input2,,}" = "y" ]; then
		
			vim changes.log
		
		fi

	elif [ "${Input,,}" = "todo" ]; then	# todo command: 
		grep -r -h --exclude=ProjectAnalyze.sh --exclude=*.log --exclude-dir=Assign1/Features "#TODO" ~/CS1XA3/ > todo.log

		read -p "Would you like to view todo.log? (Y/N): " Input2	# Viewing created file, asks if the user wants to view the created file
		if [ "${Input2,,}" = "y" ]; then

			vim todo.log

		fi

	elif [ "${Input,,}" = "error" ];then	# error command: creates a file 'error.log' with all syntax errors found in all haskell files
		find . -name *.hs -exec ghc -fno-code {} \; &> error.log
		
		if [[ -s error.log ]]; then	# Checks if there are any errors
			read -p "Would you like to view error.log? (Y/N): " Input2	# Viewing created file, asks if the user wants to view the created file
			if [ "${Input2,,}" = "y" ]; then

				vim error.log

			fi
		else
			echo "No errors were found"

		fi

	# Additional feature executed as sub-scripts all stored at CS1XA3/Assign1/Features
	elif [ "${Input,,}" = "due1" ]; then
		./Assign1/Features/Due1.sh

	elif [ "${Input,,}" = "due2" ]; then
		./Assign1/Features/Due2.sh

	elif [ "${Input,,}" = "due3" ]; then
                ./Assign1/Features/Due3.sh
	
	elif [ "${Input,,}" = "time" ]; then
		./Assign1/Features/Time.sh

	elif [ "${Input,,}" = "search" ]; then
		./Assign1//Features/Search.sh

	elif [ "${Input,,}" = "replace" ]; then
		./Assign1/Features/Replace.sh
	
	elif [ "${Input,,}" = "diff" ]; then
		./Assign1/Features/Diff.sh	

	elif [ "${Input,,}" = "exit" ]; then
		break	

	# Error output if the command user input is non-existent
	else
		echo "No such command exists" 
	fi
	
done
