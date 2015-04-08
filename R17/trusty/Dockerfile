FROM ubuntu:trusty
MAINTAINER Synctree App Force <appforce+docker@synctree.com>

RUN echo 'deb http://packages.erlang-solutions.com/debian trusty contrib' > /etc/apt/sources.list.d/esl.list

ENV ERLANG_VERSION 1:17.5

RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-keys  434975BD900CCBE4F7EE1B1ED208507CA14F4FCA

RUN set -x; \
	apt-get update \
	&& apt-get install -y \
		erlang="$ERLANG_VERSION" \
	&& rm -rf /var/lib/apt/lists/*

CMD ["erl"]
