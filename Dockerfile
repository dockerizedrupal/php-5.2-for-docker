FROM simpledrupalcloud/base

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./build /tmp/build

RUN chmod +x /tmp/build/build.sh
RUN /tmp/build/build.sh
RUN rm -rf /tmp/*

EXPOSE 9000

ENTRYPOINT ["/bin/bash", "-l", "-c", "/run.sh"]
