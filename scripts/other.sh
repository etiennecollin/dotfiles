#!/usr/bin/env sh

########################################################################################################################
# zsh setup
########################################################################################################################

# Check if zsh enviroment is already set
sudo grep -Pzq "export ZDOTDIR=\"$HOME\"/.config/zsh" /etc/zsh/zshenv >/dev/null
if [ ! $? == 0 ]; then
    echo "Setting zsh enviroment..."
    echo "export ZDOTDIR="$HOME"/.config/zsh" | sudo tee -a /etc/zsh/zshenv >/dev/null
fi

echo "Setting zsh as default shell..."
sudo chsh -s /usr/bin/zsh >/dev/null
chsh -s /usr/bin/zsh >/dev/null

source ~/.config/zsh/.zshenv

########################################################################################################################
# Oh-my-zsh
########################################################################################################################

echo "Setting up oh-my-zsh..."

if [ -d ~/github/dotfiles/config/zsh/oh-my-zsh ]; then
    echo "Deleting old oh-my-zsh..."
    rm -rf ~/github/dotfiles/config/zsh/oh-my-zsh
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >/dev/null

echo "Restoring .zshrc..."
rm ~/github/dotfiles/config/zsh/.zshrc
mv ~/github/dotfiles/config/zsh/.zshrc.pre-oh-my-zsh ~/github/dotfiles/config/zsh/.zshrc

########################################################################################################################
# Powerlevel10k
########################################################################################################################

echo "Setting up Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.config/zsh/oh-my-zsh/custom}/themes/powerlevel10k >/dev/null
sed -i 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|g' ~/.config/zsh/.zshrc >/dev/null

########################################################################################################################
# Set default boot target
########################################################################################################################

while true; do
    echo ""
    echo "Select default boot target"
    echo "1. TTY"
    echo "2. GUI"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        echo "Setting default boot target to TTY..."
        sudo systemctl set-default multi-user.target >/dev/null
        break
    elif [ "$input" = "2" ]; then
        echo "Setting default boot target to GUI..."
        sudo systemctl set-default graphical.target >/dev/null
        break
    else
        echo "Wrong input"
    fi
done

########################################################################################################################
# Sudo without password for power commands (systemctl poweroff, halt, reboot, suspend and hibernate)
########################################################################################################################
commentString="# Disabling sudo for power commands."
commandString="${commentString}\n$USER archlinux =NOPASSWD: /usr/bin/systemctl poweroff, /usr/bin/systemctl halt, /usr/bin/systemctl reboot, /usr/bin/systemctl suspend, /usr/bin/systemctl hibernate\n\n"

# Evaluate command to remove ${commentString} and $USER
eval $commandString >/dev/null

while true; do
    echo ""
    echo "Do you require sudo for power commands (systemctl poweroff, halt, reboot, suspend and hibernate)?"
    echo "1. Yes"
    echo "2. No"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        # Check if command is already in sudoers file
        sudo grep -Pzq "${commandString}" /etc/sudoers >/dev/null
        if [ $? == 0 ]; then
            echo "Enabling sudo for power commands..."
            sudo sed -i "/^${commentString}$/,/^$/d" /etc/sudoers >/dev/null
        else
            echo "Sudo already enabled for power commands. Skipping..."
        fi

        break
    elif [ "$input" = "2" ]; then
        # Check if command is already in sudoers file
        sudo grep -Pzq "${commandString}" /etc/sudoers >/dev/null
        if [ $? == 0 ]; then
            echo "Sudo already disabled for power commands. Skipping..."
        else
            echo "Disabling sudo for power commands..."
            printf "${commandString}" | sudo tee -a /etc/sudoers >/dev/null
        fi

        break
    else
        echo "Wrong input"
    fi
done

########################################################################################################################
# NVIDIA Setup for wayland
########################################################################################################################

if [ -x "$(command -v nvidia-smi)" ]; then
    echo "Setting up for NVIDIA GPU..."

    # Check if nvidia_drm.modeset=1 is already in grub
    sudo grep -Pzq "nvidia_drm.modeset=1" /etc/default/grub >/dev/null
    if [ ! $? == 0 ]; then
        echo "Adding nvidia_drm.modeset=1 to grub..."
        sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/ s/"$/ nvidia_drm.modeset=1"/' /etc/default/grub
    else
        echo "nvidia_drm.modeset=1 already in grub. Skipping..."
    fi
    echo "Updating grub..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg >/dev/null

    # Check if nvidia modules are already in mkinitcpio.conf
    sudo grep -Pzq "nvidia nvidia_modeset nvidia_uvm nvidia_drm" /etc/mkinitcpio.conf >/dev/null
    if [ ! $? == 0 ]; then
        echo "Adding nvidia modules to mkinitcpio.conf..."
        sudo sed -i '/MODULES=/ s/)/ nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    else
        echo "nvidia modules already in mkinitcpio.conf. Skipping..."
    fi
    echo "Updating mkinitcpio..."
    sudo mkinitcpio -P >/dev/null

    echo "Setting up Xorg..."
    sudo nvidia-xconfig >/dev/null
fi

########################################################################################################################
# Detect dual boot using os-prober
########################################################################################################################
echo "Detecting dual boot using os-prober..."
sudo sed -i '/#GRUB_DISABLE_OS_PROBER=/ s/#//' /etc/default/grub
sudo os-prober >/dev/null
sudo grub-mkconfig -o /boot/grub/grub.cfg >/dev/null

########################################################################################################################
# Setup SSHD
########################################################################################################################

echo "Setting up SSHD..."
echo "Deleting old SSHD config..."
sudo rm -rf /etc/ssh/sshd_config
echo "Creating symlink to new SSHD config..."
sudo ln -s ~/github/dotfiles/other/etc/ssh/sshd_config /etc/ssh/sshd_config

while true; do
    echo ""
    echo "Do you want to generate new SSH keys?"
    echo "1. Yes"
    echo "2. No"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        echo "Generating new SSH keys..."
        sudo rm /etc/ssh/ssh_host_*
        sudo ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N "" >/dev/null
        sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N "" >/dev/null

        break
    elif [ "$input" = "2" ]; then
        echo "Skipping SSH key generation..."

        break
    else
        echo "Wrong input"
    fi
done

echo "Removing weak moduli..."
sudo awk -i inplace '$5 >= 3071' /etc/ssh/moduli >/dev/null

echo "Restarting SSHD..."
sudo systemctl restart sshd

########################################################################################################################
# Prepare NeoVim
########################################################################################################################

echo "Installing neovim in python..."
pip3 install neovim >/dev/null

# Install packer.nvim
echo "Installing packer.nvim..."
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim >/dev/null
else
    echo "packer.nvim already installed. Skipping..."
fi

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
# Generate lockscreen wallpaper
########################################################################################################################

if [ -x "$(command -v betterlockscreen)" ]; then
    # Setup lockscreen wallpaper
    echo "Setting default lockscreen wallpaper..."
    betterlockscreen -u $HOME/pictures/wallpapers/iceland_blur.png --display 1 >/dev/null
fi

########################################################################################################################
# nnn plugins
########################################################################################################################
if [ -x "$(command -v nnn)" ]; then
    echo "Installing nnn plugins..."
    curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh >/dev/null
fi

########################################################################################################################
# Generate mandb
########################################################################################################################

echo "Generating man database..."
mandb >/dev/null

exit 0
