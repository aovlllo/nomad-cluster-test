#!/bin/bash

# consul agent -dev -client=0.0.0.0 -recursor=8.8.8.8 -config-file=/etc/consul.d/config.json &
# nomad agent -config=/etc/nomad.d -dev
rm /var/run/docker.pid
service docker start
consul agent -dev -client=0.0.0.0 -dns-port=53 & nomad agent -dev -config=/etc/nomad.d
