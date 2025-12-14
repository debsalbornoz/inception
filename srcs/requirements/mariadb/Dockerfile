FROM debian:oldstable

ARG DATABASE_NAME
ARG DATABASE_ADMIN
ARG DATABASE_ADMIN_PASS

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server

COPY tools/script.sh /tmp/script.sh
COPY conf/my.cnf /etc/mysql/my.cnf

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod -R 755 /var/run/mysqld
RUN chmod +x /tmp/script.sh 
RUN bash /tmp/script.sh

CMD ["mysqld_safe"]
