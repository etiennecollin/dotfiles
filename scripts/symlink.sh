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
# Setting up git
########################################################################################################################

echo "Setting up git..."
printf "Full name: "
read fullName
printf "Email: "
read email
printf "Sign-in key: "
read signInKey

git config --global user.name "$fullName"
git config --global user.email "$email"
git config --global user.signingkey "$signInKey"
gh auth login

########################################################################################################################
# Symlink dotfiles
########################################################################################################################

if [ ! -d ~/.config ]; then
    echo "Creating ~/.config directory..."
    mkdir ~/.config
fi

cd ~/.config
echo "Deleting old dotfiles..."
sudo rm -rf git kitty neofetch nvim zsh

echo "Creating symlinks for cloned dotfiles..."
{
    ln -s ~/github/dotfiles/config/git ~/.config/git
    ln -s ~/github/dotfiles/config/kitty ~/.config/kitty
    ln -s ~/github/dotfiles/config/neofetch ~/.config/neofetch
    ln -s ~/github/dotfiles/config/nvim ~/.config/nvim
    ln -s ~/github/dotfiles/config/zsh ~/.config/zsh
} >/dev/null

if [ -x "$(command -v i3)" ]; then
    sudo rm -rf dunst i3 picom polybar rofi X11
    # Setup i3
    echo "Setting up i3..."
    ln -s ~/github/dotfiles/config/dunst ~/.config/dunst
    ln -s ~/github/dotfiles/config/i3 ~/.config/i3
    ln -s ~/github/dotfiles/config/picom ~/.config/picom
    ln -s ~/github/dotfiles/config/polybar ~/.config/polybar
    ln -s ~/github/dotfiles/config/rofi ~/.config/rofi
    ln -s ~/github/dotfiles/config/X11 ~/.config/X11
fi

########################################################################################################################
# Symlink wallpapers
########################################################################################################################

if [ ! -d ~/Pictures ]; then
    echo "Creating ~/Pictures directory..."
    mkdir ~/Pictures
elif [ -d ~/Pictures/wallpapers ]; then
    echo "Deleting old wallpapers..."
    rm -rf ~/Pictures/wallpapers
fi

echo "Creating symlinks for wallpapers..."
ln -s ~/github/dotfiles/wallpapers ~/Pictures/wallpapers

exit 0
