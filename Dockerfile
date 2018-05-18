FROM ubuntu

# Install packer
RUN apt-get update \
  && apt-get install -y \
    apt-utils \
    unzip \
    wget \
    python \
    python-requests \
    python-boto \
    curl \
    make \
  && rm -rf /tmp/packer \
  && mkdir -p /tmp/packer \
  && cd /tmp/packer \
  && wget https://releases.hashicorp.com/packer/1.2.3/packer_1.2.3_linux_amd64.zip \
  && unzip packer_1.2.3_linux_amd64.zip \
  && rm packer_1.2.3_linux_amd64.zip \
  && mv packer* /usr/local/bin/

# Install docker binary
RUN set -x \
	&& curl -fsSL get.docker.com -o get-docker.sh \
	&& sh get-docker.sh \
	&& docker -v

# Cleanup
RUN apt-get clean autoclean \
  && apt-get autoremove -y --purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
  && mkdir -p /src

WORKDIR /src