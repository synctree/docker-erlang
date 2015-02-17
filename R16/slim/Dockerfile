FROM debian:wheezy
MAINTAINER Synctree App Force <appforce+docker@synctree.com>

RUN echo 'deb http://packages.erlang-solutions.com/debian wheezy contrib' > /etc/apt/sources.list.d/esl.list

ENV ERLANG_VERSION 1:16.b.3-2

RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys  D208507CA14F4FCA

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
               erlang-base="$ERLANG_VERSION" \
               erlang-crypto="$ERLANG_VERSION" \
        && rm -rf /var/lib/apt/lists/*

CMD ["erl"]
