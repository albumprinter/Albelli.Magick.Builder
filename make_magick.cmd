SET magick_tag=%1
SET magick_quantum=%2
SET magick_hdri=%3

if "%1"=="" (
    echo "Please specify the Magick.NET tag to build"
    exit /b 1
)

rd /s /q artifacts

docker build -t magick_builder_amzn .

mkdir artifacts

docker run -i --rm -v %cd%:/mnt/repo magick_builder_amzn /bin/sh -c "mkdir /tmp/build; cp /mnt/repo/build_internal.sh /tmp/build; cd /tmp/build; chmod +x build_internal.sh; ./build_internal.sh %magick_tag% %magick_quantum% %magick_hdri%"
