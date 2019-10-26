# php-fpm 
FROM php:7.3.10-fpm

RUN apt-get update

# development packages
RUN apt-get install -y \
    git \
    zip \
    curl \
    sudo \
    unzip \
    openssl \
    libpq-dev\
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libzip-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libreadline-dev \
    libfreetype6-dev \
    g++
#
# start with base php config, then add extensions
RUN docker-php-ext-install \
    pdo \
    bz2 \
    intl \
    iconv \
    bcmath \
    opcache \
    calendar \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    zip

# composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filen
# we need a user with the same UID/GID with host user
# so when we execute CLI commands, all the host file's ownership remains intact
# otherwise command from inside container will create root-owned files and directories
ARG uid=1000
RUN useradd -G www-data,root -u $uid -d /home/devuser devuser
RUN mkdir -p /home/devuser/.composer && \
    chown -R devuser:devuser /home/devuser

CMD ["php-fpm"]  
EXPOSE 9000