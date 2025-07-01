#!/usr/bin/env bash
set -Eeu

apk add --no-cache autoconf automake git libtool

cd /

git clone https://github.com/cpputest/cpputest.git
cd cpputest
mkdir cpputest_build
cd cpputest_build
autoreconf .. -i
../configure
make

#wget https://github.com/cpputest/cpputest/releases/download/latest-passing-build/cpputest-latest.tar.gz
#tar -xf ./cpputest-latest.tar.gz
#rm ./cpputest-latest.tar.gz
#mv cpputest-latest cpputest

#cd cpputest/
#autoreconf . -i
#./configure
#make

apk del git
