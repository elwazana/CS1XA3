#!/bin/bash

year=$(($(date '+%Y')))
month=$(($(date '+%m')))
day=$(($(date '+%d')))
if [ $year -le 2018 ];then
        if [ $month -lt 02 ]; then
                day=1
                if [ $day -le 26 ]; then
                        echo "Assingment 1 (Bash) is due on: " + "2018 Feb 26" + "--Due"

                else
                        echo "Assingment 1 (Bash) was due on: " + "2018 Feb 26" + "--Past"

                fi

        elif [ $month -eq 02 ]; then
                if [ $day -le 26 ]; then
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
