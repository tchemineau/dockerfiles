#
# tchemineau/wordpress_app docker file
#
# How to build this image ?
#   docker build -t tchemineau/wordpress_app:1.0 .
#
# How to use this image ?
#   docker run --name mywordpress_app -i -d -P -e WORDPRESS_DB_HOST=<IP> tchemineau/wordpress_app:1.0
#   docker port mywordpress_app
#

FROM debian:wheezy
MAINTAINER Thomas Chemineau <thomas.chemineau@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV WORDPRESS_DB_HOST localhost

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install --reinstall procps vim curl

RUN apt-get -y install --reinstall nginx mysql-client php5-mysql php5-fpm php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl

ADD conf/nginx.conf /etc/nginx/sites-available/wordpress
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/wordpress

RUN mkdir /home/wordpress
ADD http://wordpress.org/latest.tar.gz /home/wordpress/latest.tar.gz
RUN cd /home/wordpress && tar xvf latest.tar.gz && rm latest.tar.gz && mv wordpress app
RUN chown -R www-data:www-data /home/wordpress/app

RUN cp /home/wordpress/app/wp-config-sample.php /home/wordpress/app/wp-config.php
RUN sed -i 's/database_name_here/wordpress/' /home/wordpress/app/wp-config.php
RUN sed -i 's/password_here/wordpress123/' /home/wordpress/app/wp-config.php
RUN sed -i 's/username_here/wordpress/' /home/wordpress/app/wp-config.php

ADD scripts/start.sh /home/wordpress/start.sh

VOLUME ["/home/wordpress"]
EXPOSE 80
CMD /bin/bash
