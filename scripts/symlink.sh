#!/usr/bin/env sh

########################################################################################################################
# Clone dotfiles
########################################################################################################################
# cd ~

# if [ -d ~/github/dotfiles ]; then
#     echo "Deleting old dotfiles repository..."
#     sudo rm -rf ~/github/dotfiles
# fi

# echo "Cloning dotfiles from GitHub..."
# mkdir ~/github/dotfiles
# git clone https://github.com/etiennecollin/dotfiles.git ~/github/dotfiles >/dev/null

########################################################################################################################
# Symlink dotfiles
########################################################################################################################

if [ ! -d ~/.config ]; then
    echo "Creating ~/.config directory..."
    mkdir ~/.config
fi

cd ~/.config
echo "Deleting old dotfiles..."
sudo rm -rf i3 polybar nvim kitty zsh/.zshrc zsh/.zshenv zsh/p10k.zsh neofetch

echo "Creating symlinks for cloned dotfiles..."
{
    ln -s ~/github/dotfiles/config/i3 ~/.config/i3
    ln -s ~/github/dotfiles/config/polybar ~/.config/polybar
    ln -s ~/github/dotfiles/config/nvim ~/.config/nvim
    ln -s ~/github/dotfiles/config/kitty ~/.config/kitty
    ln -s ~/github/dotfiles/config/zsh/.zshrc ~/.config/zsh/.zshrc
    ln -s ~/github/dotfiles/config/zsh/.zshenv ~/.config/zsh/.zshenv
    ln -s ~/github/dotfiles/config/zsh/p10k.zsh ~/.config/zsh/p10k.zsh
    ln -s ~/github/dotfiles/config/neofetch ~/.config/neofetch
} >/dev/null

########################################################################################################################
# Symlink wallpapers
########################################################################################################################

if [ ! -d ~/pictures ]; then
    echo "Creating ~/pictures directory..."
    mkdir ~/pictures
elif [ -d ~/pictures/wallpapers ]; then
    echo "Deleting old wallpapers..."
    rm -rf ~/pictures/wallpapers
fi

echo "Creating symlinks for wallpapers..."
ln -s ~/github/dotfiles/wallpapers ~/pictures/wallpapers

exit 0
