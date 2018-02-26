#!/bin/bash

read -p "File you wish to modify (must be in current directory): " file
read -p "Word you wish to replace: " Old
read -p "Word you wish to replace with: " New

sed "s/${Old}/${New}/g" "$file" > "M.$file"
read -p "Would you like to view the contents of the modified file? (Y/N): " Ans
if [ "${Ans,,}" = "y" ]; then
	cat "M.$file"
fi
