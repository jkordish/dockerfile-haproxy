# Pull base image.
FROM ubuntu:14.04

# Install Haproxy.
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:vbernat/haproxy-1.5
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install haproxy wget cloud-utils

RUN sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

# Consul-Template
RUN wget https://github.com/hashicorp/consul-template/releases/download/v0.9.0/consul-template_0.9.0_linux_amd64.tar.gz -O /tmp/consul-template.tar.gz
RUN tar -xvzf /tmp/consul-template.tar.gz -C /usr/local/bin --strip-components=1

# Add files.
ADD haproxy.ctmpl /etc/haproxy/haproxy.ctmpl
#ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD haproxy-start.sh /haproxy-start

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "./haproxy-start"]

# Expose ports.
EXPOSE 80
EXPOSE 443
