FROM debian:buster

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common apache2 curl openssl && \
rm -r /var/lib/apt/lists/* &&\
a2enmod proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http proxy_ajp deflate mime setenvif headers http2 && \
sed -i '/Global configuration/a \
ServerName localhost/a \
' /etc/apache2/apache2.conf && \
echo "Listen 44380" >> /etc/apache2/ports.conf && \
rm -f /var/run/apache2/apache2.pid && \
chmod 755 /entrypoint.sh

EXPOSE 80 443 44380
CMD ["/entrypoint.sh"]