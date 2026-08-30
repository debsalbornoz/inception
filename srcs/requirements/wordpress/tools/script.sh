#!/bin/bash
set -e

# Log
exec > /tmp/wp_log 2>&1

# Wait MariaDb run
until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

#  Download WP-CLI if doesnt exist
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    chmod +x /usr/local/bin/wp
fi

# Install WordPress if doesnt exist
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root --path=/var/www/html

    wp config create \
        --allow-root \
        --path=/var/www/html \
        --dbname="$DATABASE_NAME" \
        --dbuser="$DATABASE_ADMIN" \
        --dbpass="$DATABASE_ADMIN_PASS" \
        --dbhost=mariadb

    wp core install \
        --allow-root \
        --path=/var/www/html \
        --url="$URL" \
        --title="$TITLE" \
        --admin_user="$DATABASE_ADMIN" \
        --admin_password="$DATABASE_ADMIN_PASS" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL"

    wp theme activate twentytwentyfour --allow-root

    wp user create dlamrk dlamark@email.com \
        --role=editor \
        --user_pass="$WORDPRESS_USER_PASS" \
        --allow-root
fi

# Set correct permission
chown -R www-data:www-data /var/www/html

# Execute PHP-FPM in the foreground
exec /usr/sbin/php-fpm8.2 -F

