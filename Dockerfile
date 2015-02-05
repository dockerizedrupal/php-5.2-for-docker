FROM simpledrupalcloud/base:latest

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN apt-get update && /src/build.sh && /src/clean.sh

EXPOSE 9000

CMD ["/bin/su", "-", "root", "-mc", "/src/run.sh"]
