FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y mariadb-server \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld 

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

CMD ["/usr/local/bin/setup.sh"]