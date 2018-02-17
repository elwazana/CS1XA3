#!/bin/bash

year=$(($(date '+%Y')))
month=$(($(date '+%m')))
day=$(($(date '+%d')))
if [ $year -le 2018 ];then
        if [ $month -lt 04 ]; then
		day=1
                if [ $day -le 15 ]; then
                        echo "Assingment 3 (Haskell) is due on: " + "2018 Apr 9-15" + "--Due"

                else
                        echo "Assingment 3 (Haskell) was due on: " + "2018 Apr 9-15" + "--Past"

                fi

        elif [ $month -eq 04 ]; then
		if [ $day -le 15 ]; then
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
