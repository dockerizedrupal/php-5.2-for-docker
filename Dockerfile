FROM simpledrupalcloud/base:dev

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update

RUN /src/build.sh
RUN /src/clean.sh

EXPOSE 9000

CMD ["/bin/bash", "-l", "-c", "/src/run.sh"]
