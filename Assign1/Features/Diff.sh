#!/bin/bash

# Obtained from Jessica de Leeuw (ie deleeuwj), modified with aid from [ cite: https://stackoverflow.com/questions/9964823/how-to-check-if-a-file-is-empty-in-bash ]

read -p "Would you like to see the differences between your Local and Remote Repos? (Y/N) " ans
if [ "${ans,,}" = "y" ]; then
	d=$"git diff origin/master master"
        $d &> diffs.log

	if  [[ -s diffs.log ]]; then #Modification checking if there are no differences
		cat diffs.log
	else
		echo "There are no differences between the local and master repositories"
	fi
fi
