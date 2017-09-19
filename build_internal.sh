
# checkout the magick.net source based on tag

git clone https://github.com/dlemstra/Magick.NET.git
cd Magick.NET
git checkout tags/7.0.7.0
git clean -fdx

cd ImageMagick/Source
./Checkout.sh
cd ImageMagick/ImageMagick/

./configure --with-magick-plus-plus=no --with-quantum-depth=8 --enable-hdri=no --prefix=/tmp/imagemagick_built

make
make install

cd ../../../../Source/Magick.NET.Native/
cp /mnt/repo/CMakeList.txt $PWD
cmake CMakeLists.txt
make
mkdir /tmp/libMagick.NET-x64.Native

dotnet restore
dotnet build

cd ./src/Albelli.Viesus.Lambda/bin/Debug/netcoreapp1.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:pwd

dotnet Albelli.Viesus.Lambda.dll