FROM gcc:4.9

RUN apt-get update && apt-get install -y curl wget build-essential debhelper bc p7zip-full

WORKDIR /tmp

COPY build.sh /tmp/build.sh

RUN /tmp/build.sh
