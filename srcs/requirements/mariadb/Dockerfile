FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install mariadb-server -y
RUN apt-get install vim -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY tools/config.sh /tmp/config.sh
RUN chmod +x /tmp/config.sh
ENTRYPOINT ["sh", "/tmp/config.sh"]
CMD ["mariadbd"]
