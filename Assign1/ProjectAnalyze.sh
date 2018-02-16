#!/bin/bash

Input=hi
while [ "$Input" != "exit" ]
do
	read -p "Enter command: "  Input
	if [ "$Input" = "state" ]; then
		git status

	elif [ "$Input" = "changes" ]; then
		git diff >> changes.log

	elif [ "$Input" = "todo" ]; then
		grep -r --exclude=todo.log "#TODO" ~/CS1XA3/Assign1 >> todo.log

	elif [ "$Input" = "due" ]; then
		echo $(date "+%Y %b %d This is a placeholder") 

	fi

done
