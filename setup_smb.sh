#!/bin/sh
set -xe

sudo apt-get install samba samba-common-bin

sudo bash -c "cat <<EOF >> /etc/samba/smb.conf
# BEGIN added by setup_smb.sh
[pi4]
    path = /nfs
    read only = no
    public = yes
    writable = yes
    create mask = 0644
    directory mask = 0755
    force user = pi
# END added by setup_smb.sh
EOF"


