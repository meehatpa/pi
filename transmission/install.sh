#!/bin/bash
set -xe

sudo apt install transmission-daemon
sudo service transmission-daemon stop

sudo mv /lib/systemd/system/transmission-daemon.service /lib/systemd/system/transmission-daemon.service.backup
sudo cp transmission-daemon.service /lib/systemd/system/transmission-daemon.service

sudo mkdir -p /nfs
sudo chown pi:pi /nfs

cp settings.json /nfs

sudo systemctl daemon-reload
sudo service transmission-daemon start
sudo service transmission-daemon status
