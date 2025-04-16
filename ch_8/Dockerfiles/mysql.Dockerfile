FROM quay.io/redhattraining/bitnami-mysql

ENV MYSQL_ROOT_PASSWORD=rootpass
ENV MYSQL_DATABASE=testdb
ENV MYSQL_USER=testuser
ENV MYSQL_PASSWORD=testpass

COPY ./mysql_init/init.sql /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306