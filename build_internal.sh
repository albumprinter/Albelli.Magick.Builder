# checkout the magick.net source based on tag

git clone https://github.com/dlemstra/Magick.NET.git
cd Magick.NET
git checkout tags/7.0.7.0
git clean -fdx


# use the script to checkout the corresponding native magick
cd ImageMagick/Source
./Checkout.sh
cd ImageMagick/ImageMagick/

# build the native part
./configure --with-magick-plus-plus=no --with-quantum-depth=8 --enable-hdri=no --prefix=/mnt/repo/artifacts/imagemagick_built

make
make install


# build the wrapper
cd ../../../../Source/Magick.NET.Native/
cp /mnt/repo/CMakeList.txt $PWD
cmake CMakeLists.txt
make
mkdir /mnt/repo/artifacts/libMagick.NET-x64.Native

cp ./libMagick.NET-Q8-x64.Native.so /mnt/repo/artifacts/libMagick.NET-x64.Native/