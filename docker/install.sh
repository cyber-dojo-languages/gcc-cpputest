#!/usr/bin/env bash
set -Eeu

apk add --no-cache autoconf automake git libtool

git clone https://github.com/cpputest/cpputest.git
cd cpputest
autoreconf . -i
./configure
make tdd

export CPPUTEST_HOME=$(pwd).

apk del git
