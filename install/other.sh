#!/usr/bin/env sh

########################################################################################################################
# Generate mandb
########################################################################################################################

echo "Generating man database..."
mandb

########################################################################################################################
# Set default boot target
########################################################################################################################

while true; do
    echo "\nSelect default boot target"
    echo "1. TTY"
    echo "2. GUI"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        echo "Setting default boot target to CLI..."
        sudo systemctl set-default multi-user.target
        break
    elif [ "$input" = "2" ]; then
        echo "Setting default boot target to GUI..."
        sudo systemctl set-default graphical.target
        break
    else
        echo "Wrong input"
    fi
done

########################################################################################################################
# Sudo without password for power commands (systemctl poweroff, halt, reboot, suspend and hibernate)
########################################################################################################################

while true; do
    echo "\nDo you require sudo for power commands (systemctl poweroff, halt, reboot, suspend and hibernate)?"
    echo "1. Yes"
    echo "2. No"
    printf "Input: "
    read input

    if [ "$input" = "1" ]; then
        echo "Sudo will be required for power commands"
        break
    elif [ "$input" = "2" ]; then
        echo "Disabling sudo for power commands..."
        printf "\n$USER archlinux =NOPASSWD: /usr/bin/systemctl poweroff,/usr/bin/systemctl halt,/usr/bin/systemctl reboot, /usr/bin/systemctl suspend, /usr/bin/systemctl hibernate\n" | sudo tee -a /etc/sudoers
        break
    else
        echo "Wrong input"
    fi
done
