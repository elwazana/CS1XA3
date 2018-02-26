#!/bin/bash

# Obtained from Jessica de Leeuw (ie deleeuwj), modified with aid from [ cite: https://stackoverflow.com/questions/9964823/how-to-check-if-a-file-is-empty-in-bash ]

# diff command displays creates and possibly displays the differences between the local repo and the master repo
read -p "Would you like to see the differences between your Local and Remote Repos? (Y/N) " ANS
if [ "${ANS,,}" = "y" ]; then
	D=$"git diff origin/master master"	# Finds the differences then stores them in a file diffs.log
        $D &> diffs.log

	if  [[ -s diffs.log ]]; then # (Modification) Checking if there are differences between the repos
		cat diffs.log
	
	# If there are no differences then output error message
	else
		echo "There are no differences between the local and master repositories"
	fi
fi
