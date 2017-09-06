#!/bin/bash
# Syntax: ./runJournal help

# export $OJS_BRANCH="ojs-stable-3_0_2"

myJournal="${1:-journal}"
action="${2:-up}"
params=$3

if [ $# -eq 0 ]; then
	echo "No arguments supplied..."
	echo "Syntax:  ./runJournal <journalName> <compose-action> <compose-params>"
        echo "More info with ./runJournal help"
	exit 1
fi

case "$action" in
	help)
		echo "Syntax:  ./runJournal <journalName> <compose-action> <compose-params>"
		echo "Example: ./runJournal journal up -d"
	        echo "Copy and modify journal folder to fit your journal needs."
		;;
	*)
		if [ $# -lt 2 ]; then
		        echo "Some arguments are missing..."
		        echo "Syntax: ./runJournal journal action compose-params"
		        echo "More info with ./runJournal help"
		        exit 1
		fi

		if [ ! -f ./$myJournal/.env ]; then
		        echo "Config file not found..."
		        echo "You have a runable example at ./journal folder."
			echo "Create your $myJournal/.env and docker-compose.yml files to fit your needs."
		        exit 1
		fi

		cd $myJournal

		echo "You are going to run or create [$myJournal] as an ojs service stack with this configuration:"
		cat .env
		read -n1 -r -p "Press "Y" if you want to continue... " key

		if [ "$key" = 'Y' ]; then
			echo ""
			docker-compose ${action} ${params}
			exit 1
		else
		    echo ""
		    echo ""
		    echo "Create or modify your $myJournal/.env file to fit your needs and play run.sh again."
		fi
		;;
esac

