#!/bin/bash

echo "<?php" >> wp-config.php
echo "/* MySQL settings */" >> wp-config.php
echo "define('DB_NAME', getenv('DBNAME'));" >> wp-config.php
echo "define('DB_USER', getenv('DBUSER'));" >> wp-config.php
echo "define('DB_PASSWORD', getenv('DBPASS'));" >> wp-config.php
echo "define('DB_HOST', getenv('DBHOST'));" >> wp-config.php
echo "define( 'DB_CHARSET',  'utf8mb4' );" >> wp-config.php
printf "\n" >> wp-config.php
echo "/* MySQL database table prefix. */" >> wp-config.php
if [ -z $1 ]
then
  echo "\$table_prefix = 'wp_';" >> wp-config.php
else
  echo "\$table_prefix = $1;" >> wp-config.php
fi
printf "\n" >> wp-config.php
echo "/* Authentication Unique Keys and Salts. */" >> wp-config.php
echo "/* https://api.wordpress.org/secret-key/1.1/salt/ */" >> wp-config.php
curl https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php
printf "\n" >> wp-config.php

echo "/* Absolute path to the WordPress directory. */" >> wp-config.php
echo "if ( !defined('ABSPATH') )" >> wp-config.php
echo "	define('ABSPATH', dirname(__FILE__) . '/');" >> wp-config.php

printf "\n" >> wp-config.php
echo "/* Sets up WordPress vars and included files. */" >> wp-config.php
echo "require_once(ABSPATH . 'wp-settings.php');" >> wp-config.php
