FROM php:7.4.2-fpm

RUN apt-get update \
    && pecl install xdebug \
    && apt-get install -y --no-install-recommends vim curl debconf subversion git apt-transport-https apt-utils \
    build-essential locales acl mailutils wget nodejs libzip-dev libzip4 zip unzip\
    gnupg gnupg1 gnupg2 \
    libpq-dev zlib1g-dev \
    sudo

RUN docker-php-ext-install pdo pdo_mysql zip

COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /xdebug.ini
COPY php-fpm-pool.conf 	/usr/local/etc/php/pool.d/www.conf

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
	mv composer.phar /usr/local/bin/composer

RUN groupadd dev -g 999
RUN useradd dev -g dev -d /home/dev -m
RUN passwd -d dev

RUN rm -rf /var/lib/apt/lists/*
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN echo "dev ALL=(ALL) ALL" > /etc/sudoers

WORKDIR /var/www/public

EXPOSE 9000
CMD ["php-fpm"]
