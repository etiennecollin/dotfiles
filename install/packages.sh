#!/usr/bin/env sh

yayArguments=" --answerclean All --answerdiff None --answeredit None --answerupgrade None --removemake --devel -Syu --needed"

########################################################################################################################
# yay
########################################################################################################################

# Install yay if ti isn't installed
echo "Checking if yay is installed..."
if [ ! -x "$(command -v yay)" ]; then
    echo "Installing yay and its dependencies..."
    sudo pacman -S --needed git base-devel >/dev/null && git clone https://aur.archlinux.org/yay.git >/dev/null && cd yay && makepkg -si >/dev/null
    cd .. && rm -rf yay
else
    echo "yay is already installed, skipping..."
fi

########################################################################################################################
# Basic Packages
########################################################################################################################

# Packages lists
# Basic tools
basicTools="curl htop zsh neovim zip unzip feh udisks2 udiskie imagemagick scrot man-db man-pages playerctl os-prober openssh fail2ban"
# Fonts
fonts="noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra nerd-fonts-jetbrains-mono"
# Software GUI
softwareGUI="brave-bin github-desktop discord via-bin celluloid yubikey-manager-qt yubioath-desktop visual-studio-code-bin kitty easyeffects"
# Software CLI
softwareCLI="nnn github-cli xdg-ninja-git neofetch"
# Latex
latex="texlive-most biber tllocalmgr-git"

# Install packages
echo "Installing packages..."
yay ${yayArguments} ${basicTools} ${fonts} ${softwareGUI} ${softwareCLI} ${latex}

# nnn plugins
echo "Installing nnn plugins..."
curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh >/dev/null

########################################################################################################################
# DE/WM
########################################################################################################################

# i3wm
i3wm="i3-wm betterlockscreen polybar rofi picom lxappearance lxsession dunst autotiling dolphin dolphin-plugins arandr xterm"
# hyprland
hyprland="hyprland-nvidia-git polybar dunst dolphin dolphin-plugins"

# Ask for DE/WM
while true; do
    echo ""
    echo "Which DE/WM do you want to use?"
    echo "1. i3wm"
    echo "2. hyprland (nvidia patched)"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        echo "Installing i3wm..."
        yay ${yayArguments} ${i3wm}

        # Setup autotiling
        echo "Setting up autotiling..."
        pip3 install i3ipc

        # Setup lockscreen wallpaper
        echo "Setting default lockscreen wallpaper..."
        betterlockscreen -u $HOME/pictures/wallpapers/iceland_blur.png --display 1 >/dev/null

        break
    elif [ "$input" = "2" ]; then
        echo "Installing hyprland..."
        yay ${yayArguments} ${hyprland}

        break
    else
        echo "Wrong input"
    fi
done

exit 0