# checkout the magick.net source based on tag
artifactsDir="/mnt/repo/artifacts/"

magick_tag=$1
magick_quantum=$2
magick_hdri=$3

git clone https://github.com/dlemstra/Magick.NET.git
cd Magick.NET
git checkout tags/"$magick_tag"
git clean -fdx

# use the script to checkout the corresponding native magick
cd ImageMagick/Source
./Checkout.sh
cd ImageMagick/ImageMagick/

# build the native part
magick_prefix="$artifactsDir"imagemagick_built
./configure --with-magick-plus-plus=no --with-quantum-depth="$magick_quantum" --enable-hdri="$magick_hdri" --prefix="$magick_prefix"

make
make install

# build the wrapper
cd ../../../../Source/Magick.NET.Native/
cp /mnt/repo/CMakeLists.txt $PWD
cmake . -DIMAGEMAGICK_PREFIX="$magick_prefix" -DQUANTUM_DEPTH="$magick_quantum" -DHDRI="$magick_hdri"
make
mkdir -p /mnt/repo/artifacts/libMagick.NET-x64.Native

cp ./libMagick.NET-Q"$magick_quantum"-x64.Native.so /mnt/repo/artifacts/libMagick.NET-x64.Native/