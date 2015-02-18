FROM debian:jessie
MAINTAINER Synctree App Force <appforce+docker@synctree.com>

RUN echo 'deb http://packages.erlang-solutions.com/debian jessie contrib' > /etc/apt/sources.list.d/esl.list

ENV ERLANG_VERSION 1:17.4

RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys  D208507CA14F4FCA

RUN apt-get update \
        && apt-get install -y \
               erlang="$ERLANG_VERSION" \
        && rm -rf /var/lib/apt/lists/*

CMD ["erl"]
