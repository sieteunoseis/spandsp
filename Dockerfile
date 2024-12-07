FROM ubuntu:22.04

# Metadata
LABEL "author"="github.com/sieteunoseis"
LABEL "system"="ubuntu:22.04"
LABEL "version"="spandsp 3.0.0"
LABEL "description"="spandsp with tests"

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get -q update \
    && apt-get -y -q --no-install-recommends install \
        apt-transport-https \
        autoconf \
        automake \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        debhelper \
        devscripts \
        dh-autoreconf \
        docbook-xsl \
        dos2unix \
        doxygen \
        dpkg-dev \
        git \
        graphviz \
        libglib2.0-dev \
        libssl-dev \
        lsb-release \
        pkg-config \
        wget \
        libtiff-dev \
        libtiff-tools \
        libpcap-dev \
        libxml2-dev \
        libsndfile-dev \
        libuv1-dev \
        libfltk1.3-dev \
        sox \
        libtool \
        netpbm \
        libfftw3-dev \
        ffmpeg \
        imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

# Use curl to download and extract the spandsp source archive
RUN curl -SL http://sources.buildroot.net/spandsp/spandsp-3.0.0-6ec23e5a7e.tar.gz | tar -xz

WORKDIR /usr/src/spandsp

# Build and install spandsp
RUN ./configure --enable-tests && make && make install

# Copy any additional scripts
COPY ./entrypoint.sh /usr/src/spandsp
RUN chmod +x /usr/src/spandsp/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/src/spandsp/entrypoint.sh"]
