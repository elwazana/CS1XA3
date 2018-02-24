#!/bin/bash

# A modified way of execution of gibsoj12's search feature (https://github.com/gibsoj12/CS1XA3/blob/master/ProjectAnalyze.sh)

read -p "Would you like to view file names, or lines containing your search parameter? (file/line):" wantedType
read -p "Enter the pattern you would like to search for." pattern
		
if [ "$wantedType" = "file" ]; then
	findings=$(find -iname "*${pattern}*") # Modified aspect: Use "find" instead of "grep" to search for file pattern.
	echo "$findings"
		
elif [ "$wantedType" = "line" ]; then
	findings=$(grep -i -r --exclude=ProjectAnalyze.sh --exclude=Search.sh "$pattern") 
	echo "$findings"

else

	echo "Unrecognized arguments, expected one of the following: file, line"
fi	
