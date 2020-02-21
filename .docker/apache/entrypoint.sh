#!/usr/bin/env bash
certbot --apache
apachectl  -DFOREGROUND -e info