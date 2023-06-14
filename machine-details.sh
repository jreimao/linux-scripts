#!/bin/bash

# author: joao reimao
#
# description: 
#
# use: ./machine-details.sh --help
#      ./machine-details.sh
#

# help with short description and script execution syntax
help () {
        echo ""
        echo
        echo "$0 --help"
        echo "$0"
        echo
}

# creation logs
logs () {
        if [ ! -d ./logs/ ]
        then
                mkdir logs
                touch ./logs/logs.out
                sleep 2
                chmod +x ./logs/logs.out
                sleep 2
        elif [ ! -f ./logs/logs.out ]
        then
                touch ./logs/logs.out
                sleep 2
                chmod +x ./logs/logs.out
                sleep 2
        fi
        echo $1 >> ./logs/logs.out
}

# machine details
machine-details () {
        #

}


# start of the script
case $1 in
        "--help")
                help
                ;;
        *)
                machine-details
                logs "$(date): new user query"
                ;;
esac
