#!/usr/bin/env bash
APP_ENV=${APP_ENV:-prod}
rm ~/.bashrc
ln -s /var/www/.bashrc ~/.bashrc
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
touch /var/log/supervisor/supervisord.log
/usr/bin/supervisord