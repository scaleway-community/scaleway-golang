## -*- docker-image-name: "scaleway/golang:latest" -*-
FROM scaleway/ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

# Install packages
RUN apt-get update -qq \
 && apt-get install -y -q --no-install-recommends \
      curl gcc ca-certificates libc6-dev git mercurial \
 && apt-get clean

# Configure environment
ENV GOARCH=arm GOOS=linux GOLANG_VERSION=1.5.2 GOROOT=/usr/local/go GOPATH=/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

# Install Golang
RUN echo "Installing Golang 1.4" \
 && cd /tmp \
 && curl -O https://storage.googleapis.com/golang/go1.4.2.src.tar.gz \
 && echo '460caac03379f746c473814a65223397e9c9a2f6 go1.4.2.src.tar.gz' | sha1sum -c \
 && tar -C /usr/local -xzf go1.4.2.src.tar.gz \
 && rm -f go1.4.2.src.tar.gz \
 && mv /usr/local/go /usr/local/go1.4.2 \
 && cd /usr/local/go1.4.2/src \
 && ./make.bash \
&& echo "Installing Golang 1.5.2 Using go1.4.2" \
 && cd /tmp \
 && curl -O https://storage.googleapis.com/golang/go1.5.2.src.tar.gz \
 && echo 'c7d78ba4df574b5f9a9bb5d17505f40c4d89b81c go1.5.2.src.tar.gz' | sha1sum -c \
 && tar -C /usr/local -xzf go1.5.2.src.tar.gz \
 && rm -f /tmp/go1.5.2.src.tar.gz \
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
