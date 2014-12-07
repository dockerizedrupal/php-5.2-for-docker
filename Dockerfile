FROM simpledrupalcloud/base:dev

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update

RUN chmod +x /src/build.sh
RUN /src/build.sh

RUN rm -rf /tmp/*
RUN rm -rf /var/lib/apt/lists/*

RUN apt-get clean

EXPOSE 9000

CMD ["/bin/bash", "-l", "-c", "/src/run.sh"]
