#!/bin/bash
ROOT_PATH=$(pwd)

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
docker-compose exec --user devuser php-fpm composer install
docker-compose exec --user devuser php-fpm php artisan key:generate
docker-compose exec php-fpm php artisan clear-compiled
docker-compose exec php-fpm php artisan optimize
docker-compose exec --user devuser php-fpm php artisan config:cache

