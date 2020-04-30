#!/usr/bin/env bash
APP_ENV=${APP_ENV:-prod}

usermod -d /var/www root
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
curl -sL https://deb.nodesource.com/setup_10.x | bash -
curl -sSk https://getcomposer.org/installer | php -- --disable-tls && mv composer.phar /usr/local/bin/composer
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install -y --no-install-recommends --no-install-suggests supervisor nodejs yarn

if [[ ! "dev" == "$APP_ENV" ]]; then
    if [[ -e /usr/local/etc/php/conf.d/xdebug.ini ]]; then
        rm -f /usr/local/etc/php/conf.d/xdebug.ini
    fi

    composer install --no-dev
    composer container-deploy-prod
else
    ln -s /xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
    composer install
    composer container-deploy-dev
fi

/usr/bin/supervisord