FROM nginx:alpine

WORKDIR /var/www/html

# настройка веб-сервера
RUN apk add php82 php82-fpm php82-soap php82-openssl php82-gmp php82-pdo_odbc php82-json php82-dom php82-pdo php82-zip php82-mysqli \
 php82-sqlite3 php82-apcu php82-pdo_pgsql php82-bcmath php82-gd php82-odbc php82-pdo_mysql php82-pdo_sqlite php82-gettext php82-xmlreader \
  php82-bz2 php82-iconv php82-pdo_dblib php82-curl php82-ctype php82-xml php82-mbstring php82-phar php82-tokenizer php82-simplexml \
  php82-intl php82-fileinfo php82-sodium php82-xmlwriter php82-common php82-session
COPY ./nginx/conf.d /etc/nginx/conf.d

# настройка среды
COPY ./html /var/www/html/
RUN mkdir /var/www/moodledata
RUN chown -R nobody /var/www/moodledata/
RUN chown nobody /var/www/html/

RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN php82 /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN ln -s /usr/bin/php82 /usr/bin/php
RUN composer install
COPY ./php.ini /etc/php82/php.ini

# запуск
COPY ./entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod 777 /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh

EXPOSE 80