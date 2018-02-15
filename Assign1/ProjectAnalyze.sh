#!/bin/bash

read Input
if [ "$Input" = "state" ]; then
	git status

elif [ "$Input" = "changes" ]; then
	git diff >> changes.log

elif [ "$Input" = "todo" ]; then
	grep -r --exclude=todo.log "#TODO" ~/CS1XA3/Assign1 >> todo.log

elif [ "$Input" = "due" ]; then
	echo $(date "+%Y %b %d This is a placeholder")  

else
	echo "No such command is avaliable"

fi

