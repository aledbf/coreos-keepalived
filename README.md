coreos-keepalived
=================

Use keepalived inside CoreOS

Steps:

* run make (requires docker)

* adapt keepalived.conf

* upload keepalived.conf and the content of the bin directory to /opt/keepalived/ in each node

* add the content of cloud-init.conf to the cloudinit services

* restart the nodes