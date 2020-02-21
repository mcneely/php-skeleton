FROM php:7.4.2-cli

RUN apt-get update \
    && pecl install xdebug \
    && apt-get install -y --no-install-recommends vim curl debconf subversion git apt-transport-https apt-utils \
    build-essential locales acl mailutils wget nodejs libzip-dev libzip4 zip unzip\
    gnupg gnupg1 gnupg2 \
    libpq-dev zlib1g-dev \
    sudo

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN docker-php-ext-install pdo pdo_mysql zip

COPY php.ini /usr/local/etc/php/php.ini

RUN groupadd dev -g 999
RUN useradd dev -g dev -d /home/dev -m
RUN passwd -d dev

RUN rm -rf /var/lib/apt/lists/*
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN echo "dev ALL=(ALL) ALL" > /etc/sudoers

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

WORKDIR /var/www

RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests supervisor nodejs
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf

CMD ["/entrypoint.sh"]