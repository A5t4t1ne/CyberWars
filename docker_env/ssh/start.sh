#!/bin/bash

# make /etc/hosts exploitable
# has to be done here, otherwise permissions get overwritten again
groupadd netw_admins
chown root:netw_admins /etc/hosts
chmod 664 /etc/hosts
echo '10.0.3.12   cyberwars.awesome' >> /etc/hosts

service cron start
/usr/sbin/sshd -D
