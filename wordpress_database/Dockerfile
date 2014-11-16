#
# tchemineau/wordpress_database docker file
#
# How to build this image ?
#   docker build -t tchemineau/wordpress_database:1.0 .
#
# How to use this image ?
#   docker run --name mywordpress_database -i -d -P tchemineau/wordpress_database:1.0
#   docker port mywordpress_database
#

FROM debian:wheezy
MAINTAINER Thomas Chemineau <thomas.chemineau@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install --reinstall procps vim

RUN echo "[client]" >> ~/.my.cnf
RUN echo "user=root" >> ~/.my.cnf
RUN echo "password=root" >> ~/.my.cnf
RUN echo "mysql-server mysql-server/root_password password root" >> ~/.mysql_debconf
RUN echo "mysql-server mysql-server/root_password_again password root" >> ~/.mysql_debconf
RUN debconf-set-selections ~/.mysql_debconf

RUN apt-get -y install mysql-server
RUN sed -i 's/bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/my.cnf
RUN /usr/sbin/mysqld & \
	sleep 10s && \
	echo "create database wordpress default character set utf8 default collate utf8_general_ci;" | mysql && \
	echo "grant all on wordpress.* to 'wordpress'@'%' identified by 'wordpress123'; flush privileges;" | mysql

RUN rm -f ~/.my.cnf ~/.mysql_* ~/.bash_history

VOLUME ["/var/lib/mysql"]
EXPOSE 3306
CMD service mysql start && /bin/bash

