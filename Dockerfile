FROM gcc:4.9

WORKDIR /tmp

RUN apt-get update && apt-get install curl 
RUN curl -ksSL https://github.com/acassen/keepalived/archive/v1.2.13.tar.gz -o /tmp/v1.2.13.tar.gz

RUN tar zxpvf v1.2.13.tar.gz

RUN cd keepalived-1.2.13 && \
  ./configure && \
  make

RUN cp /tmp/keepalived-1.2.13/bin/genhash /tmp/genhash
RUN cp /tmp/keepalived-1.2.13/bin/keepalived /tmp/keepalived
