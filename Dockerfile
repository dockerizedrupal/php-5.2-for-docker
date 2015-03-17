FROM simpledrupalcloud/base:dev

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN /src/entrypoint.sh build

EXPOSE 9000

CMD ["/src/entrypoint.sh", "run"]
