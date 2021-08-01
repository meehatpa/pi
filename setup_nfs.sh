#!/bin/sh
set -xe

sudo apt install nfs-kernel-server

sudo bash -c "cat <<EOF >> /etc/exports
/nfs       192.168.1.0/24(rw,all_squash,anonuid=1000,anongid=1000,insecure,no_subtree_check,async)
EOF"

sudo exportfs -a
sudo systemctl restart nfs-kernel-server

