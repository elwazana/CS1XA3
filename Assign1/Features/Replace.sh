#!/bin/bash

read -p "File you wish to modify (must be in current directory): " file
read -p "Word you wish to replace: " Old
read -p "Word you wish to replace with: " New

sed "s/${Old}/${New}/g" "$file" > "M.$file"
