#!/usr/bin/env sh

########################################################################################################################
# Prepare NeoVim
########################################################################################################################

pip3 install neovim

# Install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim >/dev/null