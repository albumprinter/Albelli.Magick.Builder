#!/bin/bash 
magick_tag=$1
magick_quantum=${2:-8}
magick_hdri=${3:-no}

if [[ -z $magick_tag ]];
then
    echo "Please specify the Magick.NET tag to build"
    exit 1
fi

rm -rf artifacts

docker build -t magick_builder_amzn .

mkdir artifacts

docker run -i --rm -v ${PWD}:/mnt/repo magick_builder_amzn /bin/sh -c "mkdir /tmp/build; cp /mnt/repo/build_internal.sh /tmp/build; cd /tmp/build; chmod +x build_internal.sh; ./build_internal.sh $magick_tag $magick_quantum $magick_hdri"

mkdir empty

cp nuget/template.nuspec Albelli.Magick.NET-Q"$magick_quantum"-x64.AmazonLinux.Natives.nuspec
cp nuget/template.targets Albelli.Magick.NET-Q"$magick_quantum"-x64.AmazonLinux.Natives.targets

sed -i -e "s/MAGICK_QUANTUM/$magick_quantum/g" ./Albelli.Magick.NET-Q"$magick_quantum"-x64.AmazonLinux.Natives.nuspec
sed -i -e "s/MAGICK_VERSION/$magick_tag/g" ./Albelli.Magick.NET-Q"$magick_quantum"-x64.AmazonLinux.Natives.nuspec

nuget pack