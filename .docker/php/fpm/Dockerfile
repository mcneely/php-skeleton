FROM php:7.4.5-fpm

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh && \
    apt-get update && \
    pecl install xdebug && \
    apt-get install -y --no-install-recommends \
    acl apt-transport-https apt-utils \
    build-essential curl debconf \
    git gnupg gnupg1 gnupg2 \
    libjpeg-dev libldb-dev libldap2-dev libonig-dev libpq-dev libpng-dev libssl-dev libxml2 libxml2-dev libxpm-dev libzip-dev libzip4 locales\
    mailutils openssl sudo unzip wget zip zlib1g-dev && \
    apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \locale-gen

RUN docker-php-ext-install bcmath exif gd intl ldap opcache pdo_mysql pdo_pgsql sockets zip
RUN groupadd dev -g 999 && useradd dev -g dev -d /home/dev -m && passwd -d dev && echo "dev ALL=(ALL) ALL" > /etc/sudoers

WORKDIR /var/www/public

COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /xdebug.ini
COPY php-fpm-pool.conf 	/usr/local/etc/php/pool.d/www.conf

EXPOSE 9000
CMD ["/entrypoint.sh"]
