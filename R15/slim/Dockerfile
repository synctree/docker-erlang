FROM debian:wheezy
MAINTAINER Synctree App Force <appforce+docker@synctree.com>

ENV ERLANG_VERSION 1:15.b.1-dfsg-4+deb7u1

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
               erlang-base="$ERLANG_VERSION" \
               erlang-crypto="$ERLANG_VERSION" \
        && rm -rf /var/lib/apt/lists/*

CMD ["erl"]
