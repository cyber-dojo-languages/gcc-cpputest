#!/usr/bin/env bash
set -Eeu

apk add --no-cache autoconf automake git libtool

git clone https://github.com/cpputest/cpputest.git
cd cpputest

# Ignore failing tests
#FILE='tests/CppUTest/UtestTest.cpp'
#head -n 635 "${FILE}" > file.bak
#echo "IGNORE_TEST(UtestShellPointerArrayTest, firstTestisNotTheFirstTestWithSeed1234)" >> file.bak
#tail -n +637 "${FILE}" >> file.bak
#mv file.bak "${FILE}"

#FILE='tests/CppUTest/MemoryLeakWarningTest.cpp'
#head -n 484 "${FILE}" > file.bak
#echo "IGNORE_TEST(MemoryLeakWarningThreadSafe, turnOnThreadSafeNewDeleteOverloads)" >> file.bak
#tail -n +486 "${FILE}" >> file.bak
#mv file.bak "${FILE}"

autoreconf . -i
./configure
make tdd

apk del git
