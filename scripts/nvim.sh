#!/usr/bin/env sh

########################################################################################################################
# Prepare NeoVim
########################################################################################################################

echo "Installing neovim in python..."
pip3 install neovim

# Install packer.nvim
echo "Installing packer.nvim..."
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim >/dev/null
else
    echo "packer.nvim already installed. Skipping..."
fi

exit 0
