#!/bin/bash

WORDPRESS_VERSION=$1
BUILD_NUMBER=$2

quit() {
  docker rm --force wordpressmachine;
  docker rm --force wordpressdb;
}

startMachine() {
  docker run --name wordpressdb -d septianw/tidb:latest;
  docker run --name wordpressmachine -e DBNAME=test -e DBUSER=root -e DBPASS="" -e DBHOST=db --link wordpressdb:db -d -p 127.0.0.1:3280:80 septianw/wordpress:$WORDPRESS_VERSION-$BUILD_NUMBER-TEST;
  docker ps -a
}

./make.sh $WORDPRESS_VERSION $BUILD_NUMBER TEST;
startMachine;

sleep 20
Status=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3280)
sleep 10
curl -I http://127.0.0.1:3280

if [[ $Status == '' ]]; then Status=0; fi

if [[ $Status -ne 500 ]] && [[ $Status -ne 0 ]];then
#  quit;
  echo "Response status = "$Status;
  exit 0;
else
#  quit;
  echo "Response status = "$Status;
  exit 1;
fi
