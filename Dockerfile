FROM simpledrupalcloud/base-image

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./build /tmp/build

RUN chmod +x /tmp/build/build.sh
RUN /tmp/build/build.sh
RUN rm -rf /tmp/*

VOLUME ["/data"]

EXPOSE 5217
EXPOSE 5328
EXPOSE 5431
EXPOSE 5515

ENTRYPOINT ["/bin/bash", "-l", "-c", "/run.sh"]