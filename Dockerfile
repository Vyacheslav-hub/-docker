FROM nginx:alpine

# настройка веб-сервера
RUN apk add php82 php82-fpm php82-soap php82-openssl php82-gmp php82-pdo_odbc php82-json php82-dom php82-pdo php82-zip php82-mysqli php82-sqlite3 php82-apcu php82-pdo_pgsql php82-bcmath php82-gd php82-odbc php82-pdo_mysql php82-pdo_sqlite php82-gettext php82-xmlreader php82-bz2 php82-iconv php82-pdo_dblib php82-curl php82-ctype
COPY ./nginx/conf.d /etc/nginx/conf.d

# настройка среды
COPY ./html /var/www/html/
RUN mkdir /var/www/moodledata
RUN chown -R nobody /var/www/moodledata/

# запуск
COPY ./entrypoint.sh /usr/bin/entrypoint.sh
CMD /usr/bin/entrypoint.sh

EXPOSE 80