## -*- docker-image-name: "scaleway/golang:latest" -*-
FROM scaleway/ubuntu:amd64-trusty
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/ubuntu:armhf-trusty       # arch=armv7l
#FROM scaleway/ubuntu:arm64-trusty       # arch=arm64
#FROM scaleway/ubuntu:i386-trusty        # arch=i386
#FROM scaleway/ubuntu:mips-trusty        # arch=mips


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
    GOLANG_VERSION=1.5.3 \
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
 && echo '460caac03379f746c473814a65223397e9c9a2f6 go1.4.2.src.tar.gz' | sha1sum -c \
 && tar -C /usr/local -xzf go1.4.2.src.tar.gz \
 && rm -f go1.4.2.src.tar.gz \
 && mv /usr/local/go /usr/local/go1.4.2 \
 && cd /usr/local/go1.4.2/src \
 && ./make.bash \
&& echo "Installing Golang 1.5.3 Using go1.4.2" \
 && cd /tmp \
 && curl -O https://storage.googleapis.com/golang/go1.5.3.src.tar.gz \
 && echo 'c17563a84df8aefb6a1e703a42f1e2842615e4a6 go1.5.3.src.tar.gz' | sha1sum -c \
 && tar -C /usr/local -xzf go1.5.3.src.tar.gz \
 && rm -f /tmp/go1.5.3.src.tar.gz \
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
