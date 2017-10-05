FROM amazonlinux

RUN yum update -y

RUN yum groupinstall "Development Tools" -y
RUN yum install -y cmake git make autoconf yum-utils
# RUN yum install -y libjpeg-devel libpng-devel libwebp-devel lcms2-devel

# dotnet core
RUN yum install -y libunwind libicu wget
RUN mkdir -p /opt/dotnet
RUN wget https://download.microsoft.com/download/E/7/8/E782433E-7737-4E6C-BFBF-290A0A81C3D7/dotnet-dev-centos-x64.1.0.4.tar.gz
RUN tar zxf dotnet-dev-centos-x64.1.0.4.tar.gz -C /opt/dotnet
RUN ln -s /opt/dotnet/dotnet /usr/local/bin
# end dotnet core


# this thing is needed for the windows build script
RUN yum install -y dos2unix
