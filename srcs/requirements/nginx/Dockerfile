FROM debian:oldstable

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y nginx \
	&& apt-get install -y ssl-cert

COPY conf/default /etc/nginx/sites-enabled/default
COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
