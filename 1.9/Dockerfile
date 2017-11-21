## -*- docker-image-name: "scaleway/golang:latest" -*-
ARG ARCH
FROM scaleway/ubuntu:${ARCH}-xenial


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

# Install golang from PPA
RUN add-apt-repository ppa:gophers/archive \
    && apt-get -qq update \
    && apt-get -qq install git golang-1.9-go \
    && echo "PATH=$PATH:/usr/lib/go-1.9/bin/" > /etc/profile.d/golang.sh

# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
