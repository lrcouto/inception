#!/bin/bash

mysql_install_db

/etc/init.d/mysql start

if [ ! -d "$DATABASE_PATH" ]; then
	service mysql start

	mysql -u root --execute="
		CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
		CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
		GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	"
	
	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
fi

exec "$@"
