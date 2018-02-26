#!/bin/bash

# replace command: takes a file_name, a word you wish to replace, and the word you want to replace it with
read -p "File you wish to modify (must be in current directory): " FILE
read -p "Word you wish to replace: " OLD
read -p "Word you wish to replace with: " NEW

# Replacing the words and storing the new file contents into M.file_name (M. for modified)
sed "s/${OLD}/${NEW}/g" "$FILE" > "M.$FILE"
read -p "Would you like to view the contents of the modified file? (Y/N): " ANS	# Viewing the modified file content
if [ "${ANS,,}" = "y" ]; then
	echo ""
	cat "M.$FILE"
	echo ""
fi
