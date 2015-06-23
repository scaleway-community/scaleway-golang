## -*- docker-image-name: "armbuild/scw-app-golang:latest" -*-
FROM armbuild/scw-distrib-ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN apt-get update \
 && apt-get upgrade -y -q \
 && apt-get install -y -q \
    golang \
 && apt-get clean


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
