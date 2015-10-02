## -*- docker-image-name: "scaleway/golang:latest" -*-
FROM scaleway/ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN apt-get update \
 && apt-get upgrade -y -q \
 && apt-get install -y -q \
    binutils \
    bison \
    gcc \
    git \
    make \
 && apt-get clean

# Install goroot_bootsrap
ENV BOOTSTRAP 1.4.2
RUN mkdir /usr/src$BOOTSTRAP
RUN curl -sSL https://golang.org/dl/go$BOOTSTRAP.src.tar.gz \
    	 | tar -v -C /usr/src$BOOTSTRAP -xz
RUN cd /usr/src$BOOTSTRAP/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/src$BOOTSTRAP/go/bin:$PATH
ENV GOPATH /go

ENV GOROOT_BOOTSTRAP /usr/src$BOOTSTRAP/go
ENV GOLANG_VERSION 1.5.1
RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
    	 | tar -v -C /usr/src -xz
RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1
RUN mkdir -p /go/src /go/bin && chmod -R 777 /go

ENV PATH /go/bin/usr/src/go/bin:$PATH
ENV GOPATH /go

RUN echo "\nexport PATH=/go/bin:/usr/src/go/bin:\$PATH\nexport GOPATH=/go" >> /etc/bash.bashrc

# Remove bootstrap source
RUN rm -fr /usr/src$BOOTSTRAP

# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
