#!/bin/bash

sed -i 's/localhost/'$WORDPRESS_DB_HOST'/' /home/wordpress/app/wp-config.php

service php5-fpm start
service nginx start
