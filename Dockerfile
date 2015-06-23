## -*- docker-image-name: "armbuild/scw-app-golang:latest" -*-
FROM armbuild/scw-distrib-ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
