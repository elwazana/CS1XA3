#!/bin/bash

# A modified way of execution of gibsoj12's search feature (https://github.com/gibsoj12/CS1XA3/blob/master/ProjectAnalyze.sh)

# search command: finds a file/line with an inputed pattern
read -p "Would you like to view file names, or lines containing your search parameter? (file/line): " WANTEDTYPE
read -p "Enter the pattern you would like to search for: " PATTERN
		
if [ "${WANTEDTYPE,,}" = "file" ]; then
	FINDINGS=$(find -iname "*${PATTERN}*") # (Modification) Use "find" instead of "grep" to search for file pattern.
	echo ""
	echo "$FINDINGS"
	echo ""
	
elif [ "${WANTEDTYPE,,}" = "line" ]; then
	FINDINGS=$(grep -i -h -r --exclude-dir='.*' --exclude='.*' --exclude=ProjectAnalyze.sh --exclude=Search.sh "$PATTERN") 
	echo ""
	echo "$FINDINGS"
	echo ""

else

	echo "Unrecognized arguments, expected one of the following: file, line"
fi	
