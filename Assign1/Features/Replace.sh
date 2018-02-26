#!/bin/bash

read -p "File you wish to modify (must be in current directory): " FILE
read -p "Word you wish to replace: " OLD
read -p "Word you wish to replace with: " NEW

sed "s/${OLD}/${NEW}/g" "$FILE" > "M.$FILE"
read -p "Would you like to view the contents of the modified file? (Y/N): " ANS
if [ "${ANS,,}" = "y" ]; then
	cat "M.$FILE"
fi
