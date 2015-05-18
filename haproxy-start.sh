#!/bin/bash -ex

HAPROXY="/etc/haproxy"

CONFIG="haproxy.cfg"

cd "$HAPROXY"

exec consul-template \
  -consul=localhost:8500 \
  -template "/tmp/template.ctmpl:/tmp/result"
  -template="/haproxy.ctmpl:/haproxy.cfg:service haproxy reload"
