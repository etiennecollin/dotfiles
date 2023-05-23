#!/usr/bin/env sh

########################################################################################################################
# Generate mandb
########################################################################################################################

echo "Generating man database..."
mandb >/dev/null

########################################################################################################################
# Generate lockscreen wallpaper
########################################################################################################################

if [ -x $(command -v betterlockscreen) ]; then
    # Setup lockscreen wallpaper
    echo "Setting default lockscreen wallpaper..."
    betterlockscreen -u $HOME/pictures/wallpapers/iceland_blur.png --display 1 >/dev/null
fi

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

if [ -x $(command -v nvidia-smi) ]; then
    echo "Setting up for NVIDIA GPU..."
    sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/ s/"$/ nvidia_drm.modeset=1"/' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg >/dev/null
    sudo sed -i '/MODULES=/ s/)/ nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    sudo mkinitcpio -P >/dev/null
fi

exit 0
