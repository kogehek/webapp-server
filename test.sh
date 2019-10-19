#!/bin/bash
if [ -e .env ]; then
	echo "File kek already exists!"
else
	touch .env
fi

RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
BLUE='\033[0;34m'

MAIN_SETINGS=(
	'(APP_NAME Laravel)'
	'(APP_ENV local)'
	'(APP_KEY "" "Automatically generated after")'
	'(APP_DEBUG true)'
	'(APP_URL http://localhost)'

	'(LOG_CHANNEL stack)'

	'(DB_CONNECTION pgsql)'
	'(DB_HOST 127.0.0.1)'
	'(DB_PORT 5432 "update Dockerfile docker/database")'
	'(DB_DATABASE mydb)'
	'(DB_USERNAME myuser)'
	'(DB_PASSWORD secret)'

	'(BROADCAST_DRIVER log)'
	'(CACHE_DRIVER file)'
	'(QUEUE_CONNECTION sync)'
	'(SESSION_DRIVER file)'
	'(SESSION_LIFETIME 120)'

	'(REDIS_HOST 127.0.0.1)'
	'(REDIS_PASSWORD null)'
	'(REDIS_PORT 6379)'

	'(MAIL_DRIVER smtp)'
	'(MAIL_HOST smtp.mailtrap.io)'
	'(MAIL_PORT 2525)'
	'(MAIL_USERNAME null)'
	'(MAIL_PASSWORD null)'
	'(MAIL_ENCRYPTION null)'
)

function custom()
{
	COUNT=${#MAIN_SETINGS[@]}
	for ((i=0; i<$COUNT; i++))
	do
		declare -a arr=${MAIN_SETINGS[i]}
		printf "${GREEN}${arr[0]}=${arr[1]}${NC}\n"
		# save
		echo "${arr[0]}=${arr[1]}" >> .env
	done
}

function default()
{
	COUNT=${#MAIN_SETINGS[@]}
	for ((i=0; i<$COUNT; i++))
	do
		input=''
		description=''

		declare -a arr=${MAIN_SETINGS[i]}

		if [ ! -z "${arr[2]}" ]; then
			description="${BLUE}Description: ${arr[2]}${NC}\n"
		fi

		printf  "${description}Enter ${RED}${arr[0]}${NC} default ${RED}${arr[1]}${NC}\n"

		read input
		if [ -z "$input" ]; then
			printf "${GREEN}${arr[0]}=${arr[1]}${NC}\n"
		else
			printf "${GREEN}${arr[0]}=$input${NC}\n"
		fi
	done
}


echo 'Use default settings (Y/n)?'
read answer
if [ "$answer" != "${answer#[Nn]}" ] ;then
	default
else
	custom
fi