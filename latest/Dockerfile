## -*- docker-image-name: "scaleway/golang:latest" -*-
ARG SCW_ARCH
FROM scaleway/ubuntu:${SCW_ARCH}-xenial


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

ARG GOVER

# Install golang from PPA
RUN add-apt-repository ppa:gophers/archive \
    && apt-get -qq update \
    && apt-get -qq install git golang-${GOVER}-go \
    && echo "PATH=$PATH:/usr/lib/go-${GOVER}/bin/" > /etc/profile.d/golang.sh

# Activate the go binaries
RUN for binary in $(ls /usr/lib/go-${GOVER}/bin); do \
        ln -s /usr/lib/go-${GOVER}/bin/$binary /usr/local/bin/$binary; \
    done

# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
