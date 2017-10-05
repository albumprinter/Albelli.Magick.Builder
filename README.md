# Magick builder 

[![Build Status](https://travis-ci.org/albumprinter/Albelli.Magick.Builder.svg?branch=master)](https://travis-ci.org/albumprinter/Albelli.Magick.Builder)

Builds Magick.NET native wrapper in the amazonlinux docker container. This should make it compatible with AWS Lambda. At least that is what I think ;)
Static compilation includes the following libraries: `libjpeg-turbo` `zlib` `lcms2` `libwebp` `libpng`, you can see `stupid_checkout.sh` for details.

Currently only x64 build is supported.

A nuget package can be downloaded [here](https://www.myget.org/feed/derwasp/package/nuget/Albelli.Magick.NET-Q8-x64.AmazonLinux.Natives). It is only available as Q8 and no hdi.

To run this yourself, use the following scripts:

Windows:
```
make_magick.cmd {tag}
```

Linux

```
./make_magick.sh {tag}
```

The scripts can also accept optional parameters for Quantum and HDRI. The default values for these parameters are `8` and `no`

After the script is finished (it will take quite some time, that is expected), an `artifacts\resultingOutPut\` folder will appear.
This is where all the artifacts are.