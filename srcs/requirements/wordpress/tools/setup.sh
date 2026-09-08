#!/bin/sh

set -e

if [ ! -f wp-settings.php ]; then
    echo "Downloading WordPress"
    wp core download --allow-root
fi

if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php"
    wp config create --allow-root \
    --dbname="${MYSQL_DATABASE}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost="mariadb:3306"
fi

if ! wp core is-installed --allow-root; then
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email
fi

if ! wp user get "${WP_USER}" --allow-root; then
    echo "Creating WordPress user"

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
fi

chown -R www-data:www-data /var/www/html

echo "Starting PHP-FPM"
exec php-fpm8.2 -F