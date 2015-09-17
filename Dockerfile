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

# Install golang
ENV GOLANG_VERSION 1.4.2
RUN curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz \
    	 | tar -v -C /usr/src -xz
RUN cd /usr/src/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/src/go/bin:$PATH
RUN mkdir -p /go/src /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
