#!/usr/bin/env sh

sudo systemctl enable sshd
sudo systemctl enable fail2ban
sudo systemctl enable betterlockscreen@$USER
