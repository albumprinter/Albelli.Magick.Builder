# Magick builder

Builds Magick.NET native wrapper in the amazonlinux docker container. It should make it compatible with AWS Lambda. At least that is what I think ;)

Windows:
```
make_magick.cmd {tag}
```

Linux

```
./make_magick.sh {tag}
```

The scripts can also assept optional parameters for Quantum and HDRI. The default values for these parameters are `8` and `no`

After the script is finished (it will take quite some time, that is expected), an `artifacts` folder will appear.
`artifacts/imagemagick_built/lib/` will contain the native magick binaries.
and `artifacts/libMagick.NET-x64.Native` will contain the native wrapper binary.