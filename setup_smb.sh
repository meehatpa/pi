#!/bin/sh
set -xe

sudo apt-get install samba samba-common-bin

sudo bash -c "cat <<EOF >> /etc/samba/smb.conf
# BEGIN added by setup_smb.sh
[share]
    path = /nfs
    read only = no
    public = yes
    writable = yes
# END added by setup_smb.sh
EOF"


