#!/bin/sh
# Build local ImageMagick

set -e

mkdir -p build
cd build

../ImageMagick/ImageMagick/configure --enable-static --libdir="$PWD" --with-quantum-depth=8 --disable-hdri
make install-libLTLIBRARIES
