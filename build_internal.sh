# checkout the magick.net source based on tag
tag="7.0.7.0"
magick_quantum="8"
magick_hdri="no"
artifactsDir="/mnt/repo/artifacts/"

git clone https://github.com/dlemstra/Magick.NET.git
cd Magick.NET
git checkout tags/"$tag"
git clean -fdx

# use the script to checkout the corresponding native magick
cd ImageMagick/Source
./Checkout.sh
cd ImageMagick/ImageMagick/

# build the native part
magickBuildDir="$artifactsDir"imagemagick_built
./configure --with-magick-plus-plus=no --with-quantum-depth="$magick_quantum" --enable-hdri="$magick_hdri" --prefix="$magickBuildDir"

make
make install

# build the wrapper
cd ../../../../Source/Magick.NET.Native/
cp /mnt/repo/CMakeLists.txt $PWD
cmake . -DIMAGEMAGICK_LIB_DIR="$magickBuildDir"/lib -DQUANTUM_DEPTH="$magick_quantum" -DHDRI="$magick_hdri"
make
mkdir -p /mnt/repo/artifacts/libMagick.NET-x64.Native

cp ./libMagick.NET-Q"$magick_quantum"-x64.Native.so /mnt/repo/artifacts/libMagick.NET-x64.Native/