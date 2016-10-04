FROM septianw/apachephp:5.6-dev

COPY genconfig.sh /usr/bin/
RUN apt-get update && apt-get install -y wget curl php5.6-mysqlnd php5.6-apcu php5.6-curl libapache2-mod-php5filter php5.6-gd php5.6-json php5.6-mcrypt php5.6-pspell php5.6-xmlrpc php5.6-xsl && rm -r /var/cache/apt /var/lib/apt/lists
RUN a2enmod rewrite
RUN wget https://wordpress.org/wordpress-4.6.tar.gz
RUN rm -rf /var/www/html && tar zxf wordpress-4.6.tar.gz && mv wordpress /var/www/html && cd /var/www/ && genconfig.sh
RUN rm -f wordpress-4.6.tar.gz
COPY config.php /var/www/html/wp-config.php

VOLUME /var/www/html/wp-content
