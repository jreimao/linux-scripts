#!/bin/bash

# author: joao reimao
#
# description: 
#
# use: ./user-list.sh --help
#

clear

help () {
	echo "$(pwd)/"
	echo "$0 --help"
}

# creation logs 
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

# query and list users
list_users () {
	#
	MIN_UID=$(grep "^UID_MIN" /etc/login.defs | tr -s "\t" | cut -f2)
	MAX_UID=$(grep "^UID_MAX" /etc/login.defs | tr -s "\t" | cut -f2)

	# 
	OLDIFS=$IFS
	IFS=$'\n'

	echo "-----------"
	echo "Users list:"
	echo "-----------"
	echo
	echo -e "User\t\tUID\t\tHome Directory\t\tName or Description"
	echo -e "---------------------------------------------------------------------------"
	
	# 
	for i in $(cat /etc/passwd)
	do
		USERID=$(echo $i | cut -d":" -f3)
		if [ $USERID -ge $MIN_UID -a $USERID -le $MAX_UID ]
		then
			USER=$(echo $i | cut -d":" -f3)
			USERDESC=$(echo $i | cut -d":" -f5 | tr -d ',')
			USERHOME=$(echo $i | cut -d":" -f6)

			echo -e "$USER\t\t$USERID\t\t$USERHOME\t\t$USERDESC"
			echo
			echo
		fi	
	done

	# 
	IFS=$OLDIFS
}

case $1 in
	"--help")
		help
		;;
	*)
		;;
esac


list_users
logs "$(date): new users query"
