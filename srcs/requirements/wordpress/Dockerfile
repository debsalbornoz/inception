FROM debian:oldstable

ARG DATABASE_NAME
ARG DATABASE_ADMIN
ARG DATABASE_ADMIN_PASS
ARG URL
ARG TITLE
ARG WORDPRESS_ADMIN_EMAIL
ARG WORDPRESS_USER_PASS

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y php8.2-fpm php8.2-mysql php8.2-gd wget unzip curl mariadb-client less \
    && apt-get clean

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

ENTRYPOINT ["/tmp/script.sh"]
