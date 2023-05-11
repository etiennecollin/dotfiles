#!/usr/bin/env sh

########################################################################################################################
# Clone dotfiles
########################################################################################################################

if [ -d "~/github/dotfiles" ]; then
    echo "Deleting old dotfiles repository..."
    rm -rf ~/github/dotfiles >/dev/null
fi

echo "Cloning dotfiles from GitHub..."
git clone https://github.com/etiennecollin/dotfiles.git ~/github/dotfiles >/dev/null

if [ ! -d "~/.config" ]; then
    echo "Creating ~/.config directory..."
    mkdir ~/.config >/dev/null
fi

########################################################################################################################
# Symlink dotfiles
########################################################################################################################

cd ~/.config
echo "Deleting old dotfiles..."
rm -rf i3 polybar nvim kitty zsh/.zshrc zsh/.zshenv zsh/p10k.zsh neofetch

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

if [ ! -d "~/pictures" ]; then
    echo "Creating ~/pictures directory..."
    mkdir ~/pictures >/dev/null
elif [ -d "~/pictures/wallpapers" ]; then
    echo "Deleting old wallpapers..."
    rm -rf ~/pictures/wallpapers >/dev/null
fi

echo "Creating symlinks for wallpapers..."
ln -s ~/github/dotfiles/wallpapers ~/pictures/wallpapers >/dev/null

exit 0