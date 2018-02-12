#!/bin/bash

read Input
if [ "$Input" = state ]
then
	git status

elif [ "$Input" = changes ]
	git diff > changes.log

else
	echo "No such command is avaliable"

fi

