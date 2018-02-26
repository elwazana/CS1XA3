#!/bin/bash

# A modified way of execution of gibsoj12's search feature (https://github.com/gibsoj12/CS1XA3/blob/master/ProjectAnalyze.sh)

read -p "Would you like to view file names, or lines containing your search parameter? (file/line):" WANTEDTYPE
read -p "Enter the pattern you would like to search for." PATTERN
		
if [ "${WANTEDTYPE,,}" = "file" ]; then
	FINDINGS=$(find -iname "*${PATTERN}*") # Modified aspect: Use "find" instead of "grep" to search for file pattern.
	echo "$FINDINGS"
		
elif [ "${WANTEDTYPE,,}" = "line" ]; then
	FINDINGS=$(grep -i -r --exclude=ProjectAnalyze.sh --exclude=Search.sh "$PATTERN") 
	echo "$FINDINGS"

else

	echo "Unrecognized arguments, expected one of the following: file, line"
fi	
