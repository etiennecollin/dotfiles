#!/usr/bin/env sh

echo "Setting up systemctl..."

echo "Enabling sshd..."
sudo systemctl enable sshd

echo "Enabling fail2ban..."
sudo systemctl enable fail2ban

echo "Enabling pcscd for yubikey management..."
sudo systemctl enable pcscd.service

if [ -x "$(command -v betterlockscreen)" ]; then
    echo "Enabling betterlockscreen..."
    sudo systemctl enable betterlockscreen@$USER
fi

exit 0
