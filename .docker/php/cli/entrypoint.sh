#!/usr/bin/env bash
APP_ENV=${APP_ENV:-prod}

curl -sSk https://getcomposer.org/installer | php -- --disable-tls
mv composer.phar /usr/local/bin/composer
apt-get update && apt-get install -y --no-install-recommends --no-install-suggests yarn

if [[ ! "dev" == "$APP_ENV" ]]; then
    if [[ -e /usr/local/etc/php/conf.d/xdebug.ini ]]; then
        rm -f /usr/local/etc/php/conf.d/xdebug.ini
    fi

    composer install --no-dev
    yarn install
    yarn run build
    yarn install --production
else
    ln -s /xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
    composer install
    yarn install
    yarn run build
    yarn run watch &
fi

/usr/bin/supervisord