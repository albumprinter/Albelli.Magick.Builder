FROM amazonlinux

RUN yum update -y

RUN yum groupinstall "Development Tools" -y
RUN yum install -y openssh-server yum-utils git make autoconf git openssh-server libjpeg-devel cmake
RUN yum-builddep ImageMagick -y

# dotnet core
RUN yum install -y libunwind libicu wget
RUN mkdir -p /opt/dotnet
RUN wget https://download.microsoft.com/download/E/7/8/E782433E-7737-4E6C-BFBF-290A0A81C3D7/dotnet-dev-centos-x64.1.0.4.tar.gz
RUN tar zxf dotnet-dev-centos-x64.1.0.4.tar.gz -C /opt/dotnet
RUN ln -s /opt/dotnet/dotnet /usr/local/bin
# end dotnet core

RUN mkdir ~/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBPTkVV7ExvxTAtD2H3mscrIp4oBIlgmo+LSYWRdRpGfSTWy8S4xsyiImUxKAFRiQcKHJA1UqrSW8WtT2iUMRGjlCAvxOT0xfZknKQf+YqJsdcHCd3bl/NjE/2JcU5TkpeEuTh4oJeXLugT9iENSR2m4/RhIOdMl8o8HyikNGuXuVsCiSs5DTg1Fyeu6tOy1XYDtImwEo9JHZewX7BnQ3loxvsiL0QXDtbo33p/f5lKmRa+sPpPjN5P+9AaT/HFz3x3ktNmkfyrw+zzazNH8URwRqQRTPo1lIAAetG6g3vcIZj91XJCFan+WhR/F12R8BJNxPOsZmg/OoFdUMz6CcZ denys" > ~/.ssh/authorized_keys
RUN sed -ri 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
RUN /etc/init.d/sshd start

RUN yum install -y vim fontconfig mc

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
