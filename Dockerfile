FROM simpledrupalcloud/base-image

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./build /tmp/build

RUN chmod +x /tmp/build/build.sh
RUN /tmp/build/build.sh
RUN rm -rf /tmp/*

EXPOSE 9052
EXPOSE 9053
EXPOSE 9054
EXPOSE 9055

CMD ["/opt/run.sh"]