#!/bin/bash

# author: joao reimao
#
# description: 
#
# use: ./model_shellscript.sh --help
#      ./model_shellscript.sh
#

clear

help () {
	echo "$(pwd)/"
	echo "$0 --help"
}

logs () {
	if [ ! -d ./logs/ ]
	then
		mkdir logs
		touch ./logs/logs.out
		sleep 2
		chmod +x ./logs/logs.out
	elif [ ! -f ./logs/logs.out ]
	then
		touch ./logs/logs.out
		sleep 2
		chmod +x ./logs/logs.out
	fi
	sleep 2
	echo $1 >> ./logs/logs.out
}

case $1 in
	"--help")
		help
		;;
	*)
		;;
esac

#echo
#logs "$(date) log"

