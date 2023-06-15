#!/bin/bash

# author: joao reimao
#
# description: script to search and display machine details
#
# use: ./machine-details.sh --help
#      ./machine-details.sh
#

# help with short description and script execution syntax
help () {
	echo
        echo "script to search and display machine details"
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

	KERNEL=$(uname -r)
	HOSTNAME=$(hostname)
	CPUNO=$(cat /proc/cpuinfo | grep 'model name' | wc -l)
	CPUMODEL=$(cat /proc/cpuinfo | grep 'model name' | head -n1 | cut -c14-)
	MEMTOTAL=$(expr $(cat /proc/meminfo | grep 'MemTotal' | tr -d ' ' | cut -d":" -f2 | tr -d 'kB') / 1024) # Em MB
	FILESYS=$(df -h | egrep -v '(tmpfs|udev)')
	UPTIME=$(uptime -s)

	clear
	echo
	echo "report"
	echo "date|time:  $(date)"
	echo
	echo "------------------------------------------------------------------"
	echo
	echo "computer: $HOSTNAME"
	echo "machine active since: $UPTIME"
	echo
	echo "kernel version: $KERNEL"
	echo
	echo "cpu"
	echo -e "\tcpu model: \t $CPUMODEL"
	echo -e "\tcpu|core number: $CPUNO"
	echo
	echo "memory: $MEMTOTAL MB"
	echo
	echo "partitions:"
	echo "$FILESYS"
	echo
	echo "------------------------------------------------------------------"
	echo
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
