#!/bin/bash

# Obtained from Jessica de Leeuw (ie deleeuwj), modified with aid from [ cite: https://stackoverflow.com/questions/9964823/how-to-check-if-a-file-is-empty-in-bash ]

# diff command: displays creates and possibly displays the differences between the local repo and the master repo
D=$"git diff origin/master master"	# Finds the differences then stores them in a file diffs.log
$D &> diffs.log

if  [[ -s diffs.log ]]; then # (Modification) Checking if there are differences between the repos
	read -p "Would you like to view the content of diff.log? (Y/N): " ANS
	if [ "${ANS,,}" = "y" ]; then
		echo ""
		cat diffs.log
		echo ""
	fi

# If there are no differences then output error message
else
	echo "There are no differences between the local and master repositories"
fi
