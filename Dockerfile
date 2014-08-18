FROM docker-registry.simpledrupalcloud.com/puppet

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src/build /opt/build
RUN chmod +x /opt/build/build.sh
RUN /opt/build/build.sh
RUN rm -rf /opt/build

ADD ./src/run.sh /opt/run.sh
RUN chmod +x /opt/run.sh

CMD ["/opt/run.sh"]