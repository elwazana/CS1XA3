#!/bin/bash

# due command: Checks if Assignments in the course CS1XA3 are still due

# Checks for Assignment 1 (Bash)
# Variables representing the current date (date at time of execution
YEAR=$(($(date '+%Y')))
MONTH=$(($(date '+%m')))
DAY=$(($(date '+%d')))
if [ $YEAR -le 2018 ];then              # Checks the current YEAR to the YEAR the assignmentis due
        if [ $MONTH -lt 02 ]; then      # Checks to see if the current MONTH is a MONTH before the MONTH of the assignment, if so assingmne is still due
                echo "Assingment 1 (Bash) is due on: " + "2018 Feb 26" + "--Due"

        elif [ $MONTH -eq 02 ]; then    # Checks if the current MONTH is the same as the assignment MONTH
                if [ $DAY -le 26 ]; then	# Checks the current DAY of the MONTH to the DAY of the MONTH of the assignment
                        echo "Assingment 1 (Bash) is due on: " + "2018 Feb 26" + "--Due"

                else
                        echo "Assingment 1 (Bash) was due on: " + "2018 Feb 26" + "--Past"

                fi

        else
                echo "Assingment 1 (Bash) was due on: " + "2018 Feb 26" + "--Past"

        fi
else
        echo "Assingment 1 (Bash) was due on: " + "2018 Feb 26" + "--Past"

fi

# Checks for Assingment 2 (Elm)
DAY=$(($(date '+%d')))
if [ $YEAR -le 2018 ];then              
        if [ $MONTH -lt 03 ]; then
                DAY=1
                if [ $DAY -le 25 ]; then
                        echo "Assingment 2 (Elm) is due on: " + "2018 Mar 19-25" + "--Due"

                else
                        echo "Assingment 2 (Elm) was due on: " + "2018 Mar 19-25" + "--Past"

                fi

        elif [ $MONTH -eq 03 ]; then
                if [ $DAY -le 25 ]; then
                        echo "Assingment 2 (Elm) is due on: " + "2018 Mar 19-25" + "--Due"

                else
                        echo "Assingment 2 (Elm) was due on: " + "2018 Mar 19-25" + "--Past"

                fi

        else
                echo "Assingment 2 (Elm) was due on: " + "2018 Mar 19-25" + "--Past"

        fi
else
        echo "Assingment 2 (Elm) was due on: " + "2018 Mar 19-25" + "--Past"

fi

# Checks for Assignment 3 (Haskell)
DAY=$(($(date '+%d')))
if [ $YEAR -le 2018 ];then
        if [ $MONTH -lt 04 ]; then
                DAY=1
                if [ $DAY -le 15 ]; then
                        echo "Assingment 3 (Haskell) is due on: " + "2018 Apr 9-15" + "--Due"

                else
                        echo "Assingment 3 (Haskell) was due on: " + "2018 Apr 9-15" + "--Past"

                fi

        elif [ $MONTH -eq 04 ]; then
                if [ $DAY -le 15 ]; then
                        echo "Assingment 3 (Haskell) is due on: " + "2018 Apr 9-15" + "--Due"

                else
                        echo "Assingment 3 (Haskell) was due on: " + "2018 Apr 9-15" + "--Past"

                fi

        else
                echo "Assingment 3 (Haskell) was due on: " + "2018 Apr 9-15" + "--Past"

        fi
else
        echo "Assingment 3 (Haskell) was due on: " + "2018 Apr 9-15" + "--Past"

fi

