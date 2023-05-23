#!/usr/bin/env sh

if [ "$EUID" -eq 0 ]; then
    echo "Please do not run this script as root"
    exit 1
fi

########################################################################################################################
# scripts packages
########################################################################################################################

sh "./scripts/packages.sh"

########################################################################################################################
# Setup systemctl
########################################################################################################################

sh "./scripts/systemctl.sh"

########################################################################################################################
# Setup zsh
########################################################################################################################

sh "./scripts/zsh.sh"

########################################################################################################################
# Setup symlink
########################################################################################################################

sh "./scripts/symlink.sh"

########################################################################################################################
# Setup rest
########################################################################################################################

sh "./scripts/other.sh"

########################################################################################################################
# Setup neovim
########################################################################################################################

sh "./scripts/nvim.sh"

########################################################################################################################
# Exit
########################################################################################################################

echo "Installation complete. Please reboot"
exit 0
