#!/usr/bin/env sh

########################################################################################################################
# yay
########################################################################################################################

# Install yay
echo "Installing yay and its dependencies..."
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

########################################################################################################################
# Basic Packages
########################################################################################################################

# Packages lists
# Basic tools
basicTools="curl htop zsh neovim zip unzip feh udisks2 udiskie imagemagick scrot man-db man-pages playerctl os-prober openssh fail2ban"
# Fonts
fonts="noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra nerd-fonts-jetbrains-mono"
# Software GUI
softwareGUI="brave-bin github-desktop discord via-bin celluloid yubikey-manager-qt yubioath-desktop visual-studio-code-bin kitty"
# Software CLI
softwareCLI="nnn github-cli xdg-ninja-git neofetch"
# Latex
latex="texlive-most biber tllocalmgr-git"

# Install packages
echo "Installing packages..."
yay --save --answerclean All --answerdiff None --answeredit None -Syu ${basicTools} ${fonts} ${softwareGUI} ${softwareCLI} ${latex}

# nnn plugins
echo "Installing nnn plugins..."
curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh

########################################################################################################################
# DE/WM
########################################################################################################################

# i3wm
i3wm="i3-wm betterlockscreen polybar rofi picom lxappearance lxsession dunst autotiling dolphin dolphin-plugins arandr xterm"

# Ask for DE/WM
while true; do
    echo "\nWhich DE/WM do you want to use?"
    echo "1. i3wm"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        echo "Installing i3wm..."
        yay --save --answerclean All --answerdiff None --answeredit None -Syu ${i3wm}

        # Setup autotiling
        echo "Setting up autotiling..."
        pip3 install i3ipc

        # Setup lockscreen wallpaper
        echo "Setting default lockscreen wallpaper..."
        betterlockscreen -u $HOME/pictures/wallpapers/iceland_blur.png --display 1

        break
    else
        echo "Wrong input"
    fi
done
