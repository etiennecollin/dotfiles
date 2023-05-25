#!/usr/bin/env sh

yayArguments=" --answerclean None --answerdiff None --answeredit None --answerupgrade None --removemake --devel -Syu --needed"

########################################################################################################################
# yay
########################################################################################################################

# Install yay if it isn't installed
echo "Checking if yay is installed..."
if [ ! -x "$(command -v yay)" ]; then
    echo "Installing yay and its dependencies..."
    sudo pacman -S --needed git base-devel >/dev/null
    git clone https://aur.archlinux.org/yay.git >/dev/null
    cd yay
    makepkg -si >/dev/null
    cd ..
    rm -rf yay
else
    echo "yay is already installed, skipping..."
fi

########################################################################################################################
# Basic Packages
########################################################################################################################

# Packages lists
# Basic tools
basicTools="base-devel git github-cli sudo curl htop zsh neovim zip unzip udiskie imagemagick man-db man-pages os-prober openssh ssh-audit fail2ban"
# Fonts
fonts="noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra ttf-jetbrains-mono-nerd"
# Software GUI
softwareGUI="brave-bin github-desktop discord via-bin celluloid yubikey-manager-qt yubico-authenticator-bin visual-studio-code-bin kitty easyeffects calf qtractor lsp-plugins"
# Software CLI
softwareCLI="github-cli xdg-ninja-git neofetch"
# nvim dependencies
nvim="ripgrep zathura xdotool"
# Latex
latex="texlive-most biber tllocalmgr-git"

# Install packages
echo "Installing packages..."
yay ${yayArguments} ${basicTools} ${fonts} ${softwareGUI} ${softwareCLI} ${nvim} ${latex}

########################################################################################################################
# Rust
########################################################################################################################

echo "Installing Rust..."
if [ -x "$(command -v rustc)" ]; then
    echo "Rust is already installed, skipping..."
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

########################################################################################################################
# Miniconda
########################################################################################################################

echo "Installing Miniconda..."
if [ -x "$(command -v conda)" ]; then
    echo "Miniconda is already installed, skipping..."
else
    if [ ! -d ~/Downloads ]; then
        echo "Creating ~/Downloads..."
        mkdir ~/Downloads
    fi
    curl -fo ~/Downloads/Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh >/dev/null
    sh ~/Downloads/Miniconda3-latest-Linux-x86_64.sh
    rm ~/Downloads/Miniconda3-latest-Linux-x86_64.sh
fi

########################################################################################################################
# Steam
########################################################################################################################

echo "Preparing for steam install..."

echo "Adding multilib to pacman..."
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

echo "Installing Steam..."
if [ -x "$(command -v nvidia-smi)" ]; then
    yay ${yayArguments} steam lib32-nvidia-utils
else
    yay ${yayArguments} steam
fi

if [ ! -f /etc/sysctl.d/80-gamecompatibility.conf ]; then
    echo "Increasing vm.max_map_count..."
    echo "vm.max_map_count = 2147483642" | sudo tee -a /etc/sysctl.d/80-gamecompatibility.conf >/dev/null
    sudo sysctl --system >/dev/null
fi

########################################################################################################################
# DE/WM
########################################################################################################################

# i3wm
i3wm="i3-wm feh betterlockscreen polybar rofi picom lxappearance lxsession dunst scrot autotiling arandr xterm nnn"
# hyprland
hyprland="hyprland-nvidia-git nnn"
# gnome
gnome="gnome extension-manager file-roller seahorse simple-scan"

# Ask for DE/WM
while true; do
    echo ""
    echo "Which DE/WM do you want to use?"
    echo "0. None"
    echo "1. i3wm"
    echo "2. hyprland (nvidia patched)"
    echo "3. gnome"
    printf "Input: "
    read input

    if [ "$input" = "0" ]; then
        echo "Skipping..."
        break
    elif [ "$input" = "1" ]; then
        echo "Installing i3wm..."
        yay ${yayArguments} ${i3wm}

        # Setup X11
        echo "Setting up X11..."
        sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc

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
