# checkout the magick.net source based on tag
artifactsDir="/mnt/repo/artifacts/"

magick_tag=$1
magick_quantum=$2
magick_hdri=$3

echo "Going to build Magick of tag $magick_tag, quantum $magick_quantum and HDRI $magick_hdri"

git clone https://github.com/dlemstra/Magick.NET.git
cd Magick.NET
git checkout tags/"$magick_tag"
git clean -fdx

# use the script to checkout the corresponding native magick
cd ImageMagick/Source
./Checkout.sh
cd ImageMagick/ImageMagick/
cp /mnt/repo/stupid_checkout.sh $PWD
chmod +x stupid_checkout.sh
dos2unix stupid_checkout.sh
./stupid_checkout.sh


# fix libs resolution
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/


# build the native part
magick_prefix="$artifactsDir"imagemagick_built
./configure --with-magick-plus-plus=no \
            --with-quantum-depth="$magick_quantum" \
            --with-jpeg \
            --with-png \
            --with-webp \
            --with-lcms \
            --with-zlib \
            --without-pango \
            --without-x \
            --without-fontconfig \
            --disable-shared \
            --with-pic \
            --enable-delegate-build \
            --enable-hdri="$magick_hdri"

make
make install

libMagickNetNativeOutDir="$artifactsDir"libMagick.NET-x64.Native

# build the wrapper
cd ../../../../Source/Magick.NET.Native/
cp /mnt/repo/CMakeLists.txt $PWD
cmake . -DIMAGEMAGICK_PREFIX="$magick_prefix" -DQUANTUM_DEPTH="$magick_quantum" -DHDRI="$magick_hdri"
make
mkdir -p "$libMagickNetNativeOutDir"

cp ./libMagick.NET-Q"$magick_quantum"-x64.Native.dll.so "$libMagickNetNativeOutDir"

# copy all the required binaries to the output directory
OUT_DIR="$artifactsDir"resultingOutPut/

OUT_FILES="$libMagickNetNativeOutDir/libMagick.NET-Q$magick_quantum-x64.Native.dll.so"

mkdir -p $OUT_DIR

cp $OUT_FILES $OUT_DIR