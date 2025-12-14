FROM debian:oldstable
#name = {wordpress}

# EXEC SCRIPT PARA CARREGAR ENV DO SECRET
# LER CADA UM DOS ARQUIVOS DA PASTA SECRETS
# EXPORTAR PARA ENV DO TERMINAL 'export $NAME=$VALUE';

# Variáveis de build
ARG DATABASE_NAME
ARG DATABASE_ADMIN
ARG DATABASE_ADMIN_PASS
ARG URL
ARG TITLE
ARG WORDPRESS_ADMIN_EMAIL
ARG WORDPRESS_USER_PASS

# Instalar dependências
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y php8.2-fpm php8.2-mysql php8.2-gd wget unzip curl mariadb-client less \
    && apt-get clean

# Copiar configuração e script
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# Entrypoint garante que o WordPress será instalado e PHP-FPM rodará
ENTRYPOINT ["/tmp/script.sh"]


#The Docker images must have the same name as their corresponding service. Otherwise, the evaluation process ends now.