FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install -y php7.4 \
php-fpm \
php-mysql \
php-intl \
mariadb-client

RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz -P /var/www
RUN cd /var/www && tar -xvf wordpress-6.4.3.tar.gz && rm wordpress-6.4.3.tar.gz
RUN mv /var/www/wordpress /var/www/html

RUN chown -R root:root /var/www/html

COPY conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN chmod 755 /usr/local/bin/wp

RUN wp cli update

RUN mkdir /run/php/
RUN chmod 755 /run/php

EXPOSE 9000

COPY tools/config.sh /tmp/config.sh
RUN chmod +x /tmp/config.sh
ENTRYPOINT ["bash", "/tmp/config.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
