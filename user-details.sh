#!/bin/bash

# author: joao reimao
#
# description: 
#
# use: ./user-details.sh --help
#      ./user-details.sh
#

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

# 
user_details () {
	# 

}

# start of the script
case $1 in
	"--help")
		help
		;;
	*)
		
		user-details
		logs "$(date): new user query"
		;;
esac
