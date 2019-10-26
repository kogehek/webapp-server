#!/bin/bash
ROOT_PATH=$(pwd)

cd laravel
cp .env.example .env

cd $ROOT_PATH
cd dokcer
cp .env.example .env

docker-compose up --build -d
docker-compose exec --user devuser php-fpm composer install
docker-compose exec --user devuser php-fpm php artisan key:generate
docker-compose exec php-fpm php artisan clear-compiled
docker-compose exec php-fpm php artisan optimize
docker-compose exec --user devuser php-fpm php artisan config:cache
docker-compose exec --user devuser php-fpm php artisan route:clear
docker-compose exec --user devuser php-fpm php artisan migrate

echo "http://127.0.0.1"