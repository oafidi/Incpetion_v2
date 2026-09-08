FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y php-fpm \
    php-mysql \
    curl

RUN curl -fsSL \
        https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
        -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

RUN sed -i \
        's|^listen = .*|listen = 0.0.0.0:9000|' \
        /etc/php/8.2/fpm/pool.d/www.conf \
    && mkdir -p /run/php 

WORKDIR /var/www/html

COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

CMD ["/usr/local/bin/setup.sh"]