#!/bin/bash
ROOT_PATH=$(pwd)

cd laravel || exit
if [ -f ".env" ]
then
	echo ".env found laravel."
else
	echo ".env not found laravel. is being created"
    cp .env.example .env
fi

cd "$ROOT_PATH" || exit
cd dokcer || exit
if [ -f ".env" ]
then
	echo ".env found in docker."
else
	echo ".env not found in docker. is being created"
    cp .env.example .env
fi

docker-compose up --build -d
docker-compose exec --user devuser php-fpm composer install
docker-compose exec --user devuser php-fpm php artisan key:generate
docker-compose exec --user devuser php-fpm php artisan clear-compiled
docker-compose exec --user devuser php-fpm php artisan optimize
docker-compose exec --user devuser php-fpm php artisan config:cache
docker-compose exec --user devuser php-fpm php artisan route:clear
docker-compose exec --user devuser php-fpm php artisan migrate
docker-compose exec --user devuser php-fpm php artisan passport:install

# docker-compose exec --user devuser php-fpm php artisan config:cache // Production

echo "http://127.0.0.1"