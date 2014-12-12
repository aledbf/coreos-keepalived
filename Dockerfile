FROM gcc:4.9

WORKDIR /tmp

RUN apt-get update && apt-get install curl

COPY build.sh /tmp/build.sh

RUN /tmp/build.sh
