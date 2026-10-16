#!/usr/bin/env bash
set -Eeu

# Appends one test framework to the test_frameworks list the base image
# wrote in /versions.json, keeping any entry an earlier image added. Stops
# the build if the list is not found, rather than record nothing.
add_test_framework()
{
  local -r name="${1}"
  local -r version="${2}"
  local -r entry="{\"name\": \"${name}\", \"version\": \"${version}\"}"
  if grep --quiet '"test_frameworks": \[\]' /versions.json; then
    sed -i "s|\"test_frameworks\": \[\]|\"test_frameworks\": [${entry}]|" /versions.json
  else
    sed -i "/\"test_frameworks\": \[/s|}\]|}, ${entry}]|" /versions.json
  fi
  if ! grep --quiet --fixed-strings "${entry}" /versions.json; then
    echo "Could not add ${name} to /versions.json" >&2
    cat /versions.json >&2
    exit 1
  fi
}

apt-get update
apt-get install --yes autoconf automake git libtool

# Install the newest CppUTest release. Its releases/latest points at a rolling
# latest-passing-build tag rather than a version, so the highest v<version>
# tag is resolved here at build time instead, and a rebuild picks up the next
# release by itself.
readonly CPPUTEST_TAG=$(git ls-remote --tags --refs https://github.com/cpputest/cpputest.git \
  | sed --quiet 's|.*refs/tags/\(v[0-9][0-9.]*\)$|\1|p' \
  | sort --version-sort \
  | tail -n 1)

# An empty tag means the tag listing could not be read or has changed shape,
# not that CppUTest stopped releasing, so stop rather than install nothing.
if [ -z "${CPPUTEST_TAG}" ]; then
  echo 'Found no CppUTest v<version> tag at github.com/cpputest/cpputest' >&2
  exit 1
fi

git clone --branch "${CPPUTEST_TAG}" https://github.com/cpputest/cpputest.git
cd cpputest

autoreconf . -i
./configure
make tdd

apt-get remove --yes git

add_test_framework CppUTest "${CPPUTEST_TAG#v}"
cat /versions.json
