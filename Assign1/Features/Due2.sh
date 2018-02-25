#!/bin/bash

year=$(($(date '+%Y')))
month=$(($(date '+%m')))
day=$(($(date '+%d')))
if [ $year -le 2018 ];then
        if [ $month -lt 03 ]; then
                day=1
                if [ $day -le 25 ]; then
                        echo "Assingment 2 (Elm) is due on: " + "2018 Mar 19-25" + "--Due"

                else
                        echo "Assingment 2 (Elm) was due on: " + "2018 Mar 19-25" + "--Past"

                fi

        elif [ $month -eq 03 ]; then
                if [ $day -le 25 ]; then
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
