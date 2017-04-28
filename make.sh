#!/bin/bash

if [ -z $1 ]
then
  echo 'Usage   : '$0' <wordpress version | latest> <build version> <release status>';
  echo 'Example : '$0' 4.3.2 1 ALPHA';
  echo '          '$0' 4.6.1 0 DEV';
  echo '          '$0' latest';
  exit 1;
fi

if [ -z $3 ]
then
  rel="";
else
  rel="-"$3
fi

if [ -z $2 ]
then
  bld=0;
else
  bld=$2;
fi

if [ -f Dockerfile ]
then
  rm Dockerfile
fi

cp maindfile Dockerfile
if [ $1 == 'latest' ]
then
  sed -i -e 's/wordpress-wpversion/latest/g' Dockerfile
else
  sed -i -e 's/wpversion/'$1'/g' Dockerfile
fi
docker build -t septianw/wordpress:$1-$bld$rel .
