rm -rf artifacts

docker build -t magick_builder_amzn .

mkdir artifacts

docker run -it --rm -v ${PWD}:/mnt/repo magick_builder_amzn /bin/sh -c "mkdir /tmp/build; cp /mnt/repo/build_internal.sh /tmp/build; cd /tmp/build; chmod +x build_internal.sh; ./build_internal.sh"
