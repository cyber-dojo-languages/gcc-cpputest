#!/usr/bin/env bash
set -Eeu

apk add --no-cache autoconf automake git libtool

git clone https://github.com/cpputest/cpputest.git
cd cpputest
autoupdate
mkdir cpputest_build
cd cpputest_build
autoreconf .. -i
../configure
make

export CPPUTEST_HOME=$(pwd).

apk del git
