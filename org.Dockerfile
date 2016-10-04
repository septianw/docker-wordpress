FROM septianw/apachephp

COPY genconfig.sh /usr/bin/
RUN apt-get update && apt-get install -y wget curl php5-mysqlnd && rm -r /var/cache/apt /var/lib/apt/lists
RUN a2enmod rewrite
RUN wget https://wordpress.org/latest.tar.gz
RUN rm -rf /var/www/html && tar zxf latest.tar.gz && mv wordpress /var/www/html && cd /var/www/ && genconfig.sh
COPY config.php /var/www/html/wp-config.php

VOLUME /var/www/html/wp-content
