#!/usr/bin/env bash

# fail on any command exiting non-zero
set -eo pipefail

VERSION_OPENSSL=openssl-1.0.1j
VERSION_KEEPALIVED=1.2.13

SOURCE_KEEPALIVED=https://github.com/acassen/keepalived/archive/v
SOURCE_OPENSSL=https://www.openssl.org/source/

apt-get -y install curl wget build-essential

rm -rf build && mkdir build

# grab the source files
wget -P ./build $SOURCE_KEEPALIVED$VERSION_KEEPALIVED.tar.gz --no-check-certificate
wget -P ./build $SOURCE_OPENSSL$VERSION_OPENSSL.tar.gz --no-check-certificate

# expand the source files
cd build

tar xzf $VERSION_OPENSSL.tar.gz
tar xzf v$VERSION_KEEPALIVED.tar.gz

cd ../

BUILD_PATH=/tmp/build
STATICLIBSSL="$BUILD_PATH/staticlibssl"

cd $BUILD_PATH/$VERSION_OPENSSL
rm -rf "$STATICLIBSSL"
mkdir "$STATICLIBSSL"
make clean
./config --prefix=$STATICLIBSSL no-shared \
&& make depend \
&& make \
&& make install_sw

cd $BUILD_PATH/keepalived-$VERSION_KEEPALIVED

CFLAGS="-I $STATICLIBSSL/include -I/usr/include" LDFLAGS="-L $STATICLIBSSL/lib -Wl,-rpath -lssl -lcrypto -ldl -lz" \
  ./configure && make

cp bin/* /tmp