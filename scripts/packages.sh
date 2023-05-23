#!/usr/bin/env sh

yayArguments=" --answerclean None --answerdiff None --answeredit None --answerupgrade None --removemake --devel -Syu --needed"

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
    sleep 1
fi

########################################################################################################################
# Basic Packages
########################################################################################################################

# Packages lists
# Basic tools
basicTools="base-devel curl htop zsh neovim zip unzip udisks2 udiskie imagemagick man-db man-pages os-prober openssh fail2ban"
# Fonts
fonts="noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra nerd-fonts-jetbrains-mono"
# Software GUI
softwareGUI="brave-bin github-desktop discord via-bin celluloid yubikey-manager-qt yubioath-desktop visual-studio-code-bin kitty easyeffects calf ardour lsp-plugins-lv2"
# Software CLI
softwareCLI="github-cli xdg-ninja-git neofetch"
# nvim dependencies
nvim="ripgrep zathura xdotool"
# Latex
latex="texlive-most biber tllocalmgr-git"

# Install packages
echo "Installing packages..."
yay ${yayArguments} ${basicTools} ${fonts} ${softwareGUI} ${softwareCLI} ${nvim} ${latex}

# nnn plugins
echo "Installing nnn plugins..."
curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh >/dev/null

########################################################################################################################
# DE/WM
########################################################################################################################

# i3wm
i3wm="i3-wm feh betterlockscreen polybar rofi picom lxappearance lxsession dunst scrot autotiling arandr xterm nnn"
# hyprland
hyprland="hyprland-nvidia-git nnn"
# gnome
gnome="gnome extension-manager file-roller seahorse simple-scan libinput-config"

# Ask for DE/WM
while true; do
    echo ""
    echo "Which DE/WM do you want to use?"
    echo "1. i3wm"
    echo "2. hyprland (nvidia patched)"
    echo "3. gnome"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        echo "Installing i3wm..."
        yay ${yayArguments} ${i3wm}

        # Setup autotiling
        echo "Setting up autotiling..."
        pip3 install i3ipc

        break
    elif [ "$input" = "2" ]; then
        echo "Installing hyprland..."
        yay ${yayArguments} ${hyprland}

        break
    elif [ "$input" = "3" ]; then
        echo "Installing gnome..."
        yay ${yayArguments} ${gnome}

        # Set scroll speed
        echo "Setting scroll speed..."
        echo "scroll-factor=8" | sudo tee -a /etc/libinput.conf >/dev/null

        break
    else
        echo "Wrong input"
    fi
done

exit 0