#!/bin/bash

# author: joao reimao
#
# description: script to search and display user details 
#
# use: ./user-details.sh --help
#      ./user-details.sh username
#

# help with short description and script execution syntax
help () {
	echo "script to search and display user details" 
	echo
	echo "$0 --help"
	echo "$0 unsername"
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

# query and list user details
user-details () {
	# 

	echo
	echo "User search: $1"
	echo

	# ifs - input field separators
	OLDIFS=$IFS
	IFS=$'\n'

	# range of users ids
	MIN_UID=$(grep "^UID_MIN" /etc/login.defs | tr -s "\t" | cut -f2)
        MAX_UID=$(grep "^UID_MAX" /etc/login.defs | tr -s "\t" | cut -f2)
	#MIN_UID=0
	#MAX_UID=999

        # loop for searching, validating e listing users
        for i in $(cat /etc/passwd | grep $1)
        do
		USERID=$(echo $i | cut -d":" -f3)
                if [ $USERID -ge $MIN_UID -a $USERID -le $MAX_UID ]
                then
			USERNAME=$(echo $i | cut -d":" -f1)
			USER=$(echo $i | cut -d":" -f3)
                        USERDESC=$(echo $i | cut -d":" -f5 | tr -d ',')
                        USERHOME=$(echo $i | cut -d":" -f6)
			USEHOME=$(du -sh /home/$USERNAME | cut -f1)
			LASTLOG=$(lastlog -u $USERNAME | sed '1d')

			echo
			echo "--------------------------------------------------------------------------"
			echo
			echo "user report: $USERNAME"
			echo
			echo "user id: $USERID"
			echo "user directory: $USERHOME with $USEHOME"
			echo "description: $USERDESC"
                        echo
			echo

			echo "last login: "
			echo -e "user\t\tport\t\tip\t\tlast log"
			echo "$LASTLOG"

			echo
			echo "--------------------------------------------------------------------------"
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
		if [ -z $1 ]
		then
			help
		else
			user-details $1
			logs "$(date): new user query"
		fi
		;;
esac
