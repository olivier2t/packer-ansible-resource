FROM alpine:3.14.2

RUN apk add --no-cache --update jq bash git curl ca-certificates openssh-client openssl unzip tar ansible \
    && adduser --disabled-password --home /home/packer packer

# Install Packer
ENV PACKER_VERSION 1.7.6
RUN mkdir -p /opt/packer
RUN wget -nc -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -P /opt/packer
RUN unzip -q /opt/packer/packer_${PACKER_VERSION}_linux_amd64.zip -d /opt/packer

# Install Concourse Resource Scripts
RUN mkdir -p /opt/resource
ADD bin /opt/resource
RUN chmod -R a+x /opt/resource

# Set non-root user environement
USER packer
ENV PATH $PATH:/opt/packer
WORKDIR /home/packer