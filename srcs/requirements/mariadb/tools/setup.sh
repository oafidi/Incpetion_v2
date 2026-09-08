#!/bin/sh

set -e



if [ ! -f /var/lib/mysql/.setup_done ]; then
    echo "Starting mariadb deamon"

    service mariadb start

    echo "Executing sql commands"

    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    echo "Shutdowning the deamon"

    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

    touch /var/lib/mysql/.setup_done
fi


echo "Starting mariadbs in the foreground"

exec mariadbd --user=mysql --console
