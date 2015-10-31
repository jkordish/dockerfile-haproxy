# Pull base image.
FROM ubuntu:14.04

# Install Haproxy.
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:vbernat/haproxy-1.5
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install haproxy wget cloud-utils unzip

RUN sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

# Consul-Template
RUN wget https://releases.hashicorp.com/consul-template/0.11.1/consul-template_0.11.1_linux_amd64.zip -O /tmp/consul-template.zip
RUN unzip /tmp/consul-template.zip -d /usr/local/bin

# Add files.
ADD haproxy.ctmpl /etc/haproxy/haproxy.ctmpl
ADD haproxy-start.sh /haproxy-start

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "./haproxy-start"]

# Expose ports.
EXPOSE 80
EXPOSE 443
