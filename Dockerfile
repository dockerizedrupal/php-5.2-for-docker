FROM dockerizedrupal/base-debian-wheezy:1.1.0

MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>

LABEL vendor=dockerizedrupal.com

ENV TERM xterm

ADD ./src /src

RUN /src/entrypoint.sh build

EXPOSE 9000

ENTRYPOINT ["/src/entrypoint.sh", "run"]
