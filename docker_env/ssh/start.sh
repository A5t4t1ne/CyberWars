#!/bin/bash

service cron start
/usr/sbin/sshd -D

# Change ownership of /etc/hosts
chown john:john /etc/hosts
chmod 644 /etc/hosts