#!/bin/bash
# export $OJS_BRANCH="ojs-stable-3_0_2"

runMe="dojo.sh"
action="${1}"
myJournal="${2}"
params="${3}"

if [ $# -eq 0 ]; then
	echo "No arguments supplied..."
	echo "Syntax:  ./${runMe} <compose-action> <journalName> <compose-params>"
        echo "More info with ./${runMe} help"
	exit 1
fi

if [ $action == "help" ]; then
        echo "Syntax:  ./${runMe} <compose-action> <journalName> <compose-params>"
        echo "Example 1: ./${runMe} up journal -d"
        echo "Example 2: ./${runMe} backup journal db"
        echo "Copy and modify journal folder to fit your journal needs."
else
        if [ $# -lt 2 ]; then
        	echo "Some arguments are missing..."
        	echo "More info with ./${runMe} help"
        	exit 1
	fi

        if [ ! -f ./$myJournal/.env ]; then
                echo "Config file not found..."
                echo "You have a runnable example at ./journal folder."
                echo "Create your $myJournal/.env and docker-compose.yml files to fit your needs."
                exit 1
        fi

	cd $myJournal

	source .env

	case "$action" in
		env)
			echo "Compose config variables for journal [$myJournal]:"
			cat .env
			;;

		backup)
			NOW="$(date +"%Y%m%d-%M%S")"
			mkdir -p backup

			case "$params" in
				db)
					docker exec ${myJournal}_db /usr/bin/mysqldump -u root --password=$MYSQL_ROOT_PASSWORD \
						--all-databases --add-drop-database --events --routines --triggers \
						ojs_${COMPOSE_PROJECT_NAME} > ./backup/db-${myJournal}-${NOW}.sql
					tar cvzf ./backup/db-${myJournal}-${NOW}.tgz ./backup/db-${myJournal}-${NOW}.sql
					rm -f db-${myJournal}-${NOW}.sql
					ln -s -f ./db-${myJournal}-${NOW}.tgz ./backup/lastBackupDb
				;;
				files)
					tar cvzf ./backup/files-${myJournal}-${NOW}.tgz ./files
					ln -s -f ./files-${myJournal}-${NOW}.tgz ./backup/lastBackupFiles
				;;
				all)
					# Database:
					docker exec ${myJournal}_db /usr/bin/mysqldump -u root --password=$MYSQL_ROOT_PASSWORD \
						ojs_${COMPOSE_PROJECT_NAME} > ./backup/db-${myJournal}-${NOW}.sql
					tar cvzf ./backup/db-${myJournal}-${NOW}.tgz ./backup/db-${myJournal}-${NOW}.sql
					rm -f db-${myJournal}-${NOW}.sql
					ln -s -f ./db-${myJournal}-${NOW}.tgz ./backup/lastBackupDb

					# Files:
					tar cvzf ./backup/files-${myJournal}-${NOW}.tgz ./files
					ln -s -f ./files-${myJournal}-${NOW}.tgz ./backup/lastBackupFiles

			esac
			;;

		restore)
					echo "DROP DATABASE IF EXISTS ojs_${COMPOSE_PROJECT_NAME};
						CREATE DATABASE ojs_${COMPOSE_PROJECT_NAME};
						USE ojs_${COMPOSE_PROJECT_NAME};" \
						| docker exec -i ${COMPOSE_PROJECT_NAME}_db /usr/bin/mysql \
						-u root --password=$MYSQL_ROOT_PASSWORD ojs_${COMPOSE_PROJECT_NAME}

					echo "DB ojs_${COMPOSE_PROJECT_NAME} was created"

					tar -xzf ./backup/lastBackupDb --to-stdout \
						| docker exec -i ${COMPOSE_PROJECT_NAME}_db /usr/bin/mysql --binary-mode \
						-u root --password=$MYSQL_ROOT_PASSWORD ojs_${COMPOSE_PROJECT_NAME}

					echo "---> DATA RESTORED in ojs_${COMPOSE_PROJECT_NAME} from backup/lastBackupDb."
			;;

                mojo)
                                                docker exec -i ${COMPOSE_PROJECT_NAME}_db bash -c "/usr/bin/mojo ${@:3}"
			;;

                stop)
			../${runMe} backup ${Journal} all
			# docker cp ${myJournal}_ojs:/var/www/html/config.inc.php config.inc.php
			docker-compose stop
			;;

		*)
			echo "You are going to run docker-compose on [$myJournal] with [$params] params"
			read -n1 -r -p "Press "Y" if you want to continue... " key

			if [ "$key" = 'Y' ]; then
				echo ""
				docker-compose ${action} ${params}
				# docker cp config.inc.php ${myJournal}_ojs:/var/www/html/config.inc.php
			else
			    echo ""
			    echo "You must press Y (case sensitive) to apply changes."
			    echo "Create or modify your $myJournal/.env file to fit your needs and play ${runMe} again."
			    exit 1
			fi
		;;
	esac
fi
