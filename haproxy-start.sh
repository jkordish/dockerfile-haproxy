#!/bin/bash -ex

HAPROXY="/etc/haproxy"

CONFIG="haproxy.cfg"

cd "$HAPROXY"

exec consul-template \
  -log-level debug \
  -consul=$(/usr/bin/ec2metadata --local-ip):8500 \
  -template="/etc/haproxy/haproxy.ctmpl:/etc/haproxy/haproxy.cfg:service haproxy reload"
