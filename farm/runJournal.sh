#!/bin/bash
# export $OJS_BRANCH="ojs-stable-3_0_2"
myJournal="${1:-journal}"

cd $myJournal

echo "You are going to run or create [$myJournal] as an ojs service stack with this configuration:"
cat .env
read -n1 -r -p "Press "Y" if you want to continue... " key

if [ "$key" = 'Y' ]; then
    echo ""
    docker-compose up -d
else
    echo ""
    echo ""
    echo "Create or modify your $myJournal/.env file to fit your needs and play run.sh again."
fi
