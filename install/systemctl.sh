#!/usr/bin/env sh

echo "Setting up systemctl..."

echo "Enabling sshd..."
sudo systemctl enable sshd >/dev/null

echo "Enabling fail2ban..."
sudo systemctl enable fail2ban >/dev/null

if [ -x $(command -v betterlockscreen) ]; then
    echo "Enabling betterlockscreen..."
    sudo systemctl enable betterlockscreen@$USER >/dev/null
fi
