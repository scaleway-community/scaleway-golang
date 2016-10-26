## -*- docker-image-name: "scaleway/golang:latest" -*-
FROM scaleway/ubuntu:amd64-xenial
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/ubuntu:armhf-xenial       # arch=armv7l
#FROM scaleway/ubuntu:arm64-xenial       # arch=arm64
#FROM scaleway/ubuntu:i386-xenial        # arch=i386
#FROM scaleway/ubuntu:mips-xenial        # arch=mips


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN apt-get update -qq \
 && apt-get install -y -q --no-install-recommends \
      curl gcc ca-certificates libc6-dev git mercurial \
 && apt-get clean


# Configure environment
ENV GOOS=linux \
    GOLANG_VERSION=1.7.3 \
    GOLANG_SHASUM=79430a0027a09b0b3ad57e214c4c1acfdd7af290961dd08d322818895af1ef44 \
    GOROOT=/usr/local/go \
    GOPATH=/go \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/go/bin


# Install Golang
RUN case "${ARCH}" in \
    armhf|arm|armv7l) \
      export GOARCH=arm; \
      ;; \
    esac \
 && set -x \
 && echo "Installing Golang 1.4" \
 && cd /tmp \
 && curl -O https://storage.googleapis.com/golang/go1.4.2.src.tar.gz \
 && echo '299a6fd8f8adfdce15bc06bde926e7b252ae8e24dd5b16b7d8791ed79e7b5e9b go1.4.2.src.tar.gz' | sha256sum -c \
 && tar -C /usr/local -xzf go1.4.2.src.tar.gz \
 && rm -f go1.4.2.src.tar.gz \
 && mv /usr/local/go /usr/local/go1.4.2 \
 && cd /usr/local/go1.4.2/src \
 && ./make.bash \
&& echo "Installing Golang ${GOLANG_VERSION} Using go1.4.2" \
 && cd /tmp \
 && curl -O https://storage.googleapis.com/golang/go${GOLANG_VERSION}.src.tar.gz \
 && echo "${GOLANG_SHASUM} go${GOLANG_VERSION}.src.tar.gz" | sha256sum -c \
 && tar -C /usr/local -xzf go${GOLANG_VERSION}.src.tar.gz \
 && rm -f /tmp/go${GOLANG_VERSION}.src.tar.gz \
 && cd /usr/local/go/src \
 && GOROOT_BOOTSTRAP=/usr/local/go1.4.2 ./make.bash --no-clean \
 && rm -rf /usr/local/go1.4.2


# Configure environment
RUN echo "Configure environment" \
 && mkdir -p /go/src /go/bin \
 && chmod -R 777 /go \
 && echo export GOROOT=${GOROOT} > /etc/profile.d/golang.sh \
 && echo export GOPATH=${GOPATH} >> /etc/profile.d/golang.sh \
 && echo export PATH=\${PATH}:\${GOROOT}/bin:\${GOPATH}/bin >> /etc/profile.d/golang.sh


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
