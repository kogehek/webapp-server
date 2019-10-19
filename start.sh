#!/bin/bash
ROOT_PATH=$(pwd)

WIN_PREF=""
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    WIN_PREF="winpty"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    WIN_PREF="winpty"
fi

echo 'Use default settings (Y/n)?'
read answer
if [ "$answer" != "${answer#[Nn]}" ] ;then
	cd laravel
    cp .env.example .env
    nano .env
    cd $ROOT_PATH
    cd dokcer
    cp .env.example .env
    nano .env
else
	cd laravel
    cp .env.example .env

    cd $ROOT_PATH
    cd dokcer
    cp .env.example .env
fi



docker-compose up --build -d
$WIN_PREF docker-compose exec php-fpm php artisan key:generate
$WIN_PREF docker-compose exec php-fpm php artisan clear-compiled
$WIN_PREF docker-compose exec php-fpm php artisan optimize

