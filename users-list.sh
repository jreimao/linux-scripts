#!/bin/bash

# author: joao reimao
#
# description:script for searching and listing users
#
# use: ./users-list.sh --help
#      ./users-list.sh
#

help () {
	echo
	echo "script for searching and listing users"
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

# query and list users
users-list () {
	# range of users ids
	MIN_UID=$(grep "^UID_MIN" /etc/login.defs | tr -s "\t" | cut -f2)
	MAX_UID=$(grep "^UID_MAX" /etc/login.defs | tr -s "\t" | cut -f2)

	# ifs - input field separators
	OLDIFS=$IFS
	IFS=$'\n'

	echo
	echo "-----------"
	echo "Users list:"
	echo "-----------"
	echo
	echo -e "User\t\tUID\t\tHome Directory\t\tName or Description"
	echo -e "---------------------------------------------------------------------------"
	
	# loop for searching, validating e listing users
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

	# reset of initial settings
	IFS=$OLDIFS
}

# start of the script
case $1 in
	"--help")
		help
		;;
	*)
		
		users-list
		logs "$(date): new users query"
		;;
esac
