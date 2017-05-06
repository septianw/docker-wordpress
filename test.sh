#!/bin/bash

WORDPRESS_VERSION=$1
BUILD_NUMBER=$2

quit() {
  docker rm --force wordpressmachine;
  docker rm --force wordpressdb;
}

startMachine() {
  docker run --name wordpressdb -d septianw/tidb:latest;
  docker run --name wordpressmachine -e DBNAME=test -e DBUSER=root -e DBPASS="" -e DBHOST=db --link wordpressdb:db -d -p 3280:80 septianw/wordpress:$WORDPRESS_VERSION-$BUILD_NUMBER-TEST;
}

./make.sh $WORDPRESS_VERSION $BUILD_NUMBER TEST;
startMachine;

Status=$(curl -I http://localhost:3280 2>/dev/null | head -n 1|cut -d$' ' -f2)

if [ $Status -ne 500 ];then
  quit;
  echo "Response status = "$Status;
  exit 0;
else
  quit;
  echo "Response status = "$Status;
  exit 1;
fi
