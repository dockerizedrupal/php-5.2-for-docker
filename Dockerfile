FROM docker-registry.simpledrupalcloud.com/puppet

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src/build /tmp/build
RUN chmod +x /tmp/build/build.sh
RUN /tmp/build/build.sh
RUN rm -rf /tmp/build

ADD ./src/run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

EXPOSE 9052
EXPOSE 9053
EXPOSE 9054
EXPOSE 9055

CMD ["/opt/run.sh"]