# fix the pkg config variable, so lcms and webp libs are recognized by the builder
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/


# clone & build jpeg

git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git jpeg
cd jpeg
git checkout tags/1.5.2

autoreconf -fiv
./configure --disable-shared --with-pic
make

cd ..

##########################

# clone & build zlib, 1.2.9
git clone https://github.com/madler/zlib.git zlib
cd zlib
git checkout tags/1.2.9
./configure --static
make CFLAGS='-fPIC'
make install
cd ..

#########################

# lcms 2.8
git clone https://github.com/mm2/Little-CMS.git lcms
cd lcms
git checkout tags/lcms2.8
./configure --disable-shared --with-pic
make
make install
cd ..

########

# webp 0.5.1
git clone https://github.com/webmproject/libwebp.git webp
cd webp
git checkout tags/v0.5.1
./autogen.sh
./configure --disable-shared --with-pic
make
make install
cd ..