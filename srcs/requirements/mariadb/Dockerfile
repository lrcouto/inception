FROM		debian:buster

RUN			apt-get update && apt-get install -y \
			apt-utils \
			mariadb-server \
            mariadb-client \
			procps \
			vim \
			&& mkdir -p /var/run/mysqld \
			&& chown -R mysql:mysql /var/run/mysqld \
            && chmod -R 755 /var/lib/mysql/

COPY		./tools/start_db.sh /usr/local/bin/

COPY		./conf/mysqld.conf ~/my.cnf
COPY		./conf/mysqld.conf /etc/mysql/my.cnf
COPY		./conf/mysqld.conf /etc/my.cnf

EXPOSE		3306

ENTRYPOINT ["start_db.sh"]

CMD			["mysqld", "--bind-address=0.0.0.0"]