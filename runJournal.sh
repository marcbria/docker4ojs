#!/bin/bash
# export $OJS_BRANCH="ojs-stable-3_0_2"
cd ${1:-journal}

echo "You are going to deploy a container with this configuration:"
cat .env
read -n1 -r -p "Press "Y" if you want to continue..." key

if [ "$key" = 'Y' ]; then
    echo ""
    cd ../db
    docker-compose up -d
    cd ../$1
    docker-compose up -d
else
    echo ""
    echo ""
    echo "Modify $1/.env file to fit your needs and play run.sh again."
fi
