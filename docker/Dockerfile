FROM  cyberdojofoundation/gcc
LABEL maintainer=jon@jaggersoft.com

# Note: I have tried putting the commands below into an install.sh
# file but it does not work! You get the following error from the
# autoreconf
# configure.ac:11: error: required file './ltmain.sh' not found

RUN apt-get update
RUN apt-get install --yes automake autoconf libtool git
WORKDIR /
RUN git clone https://github.com/cpputest/cpputest.git
WORKDIR cpputest/
RUN autoreconf . -i
RUN ./configure
RUN make

COPY red_amber_green.rb /usr/local/bin
