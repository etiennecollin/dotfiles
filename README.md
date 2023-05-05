# DOTFILES <!-- omit from toc -->

**Dotfiles for easy system installs.**

## Table of Contents <!-- omit from toc -->

- [Installation](#installation)
    - [xinit](#xinit)
- [Other Commands](#other-commands)
- [Optional Packages Install](#optional-packages-install)
- [Antidote:](#antidote)

## Installation

1. Clone this repository
2. Run the `installation.sh` script as root:
    ```bash
    sudo sh ./installation.sh
    ```

### xinit

1. In `~/.xinitrc` delete content after last `fi`
2. Run the following command:
    ```bash
    sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc && echo -e "\nexec i3" >> ~/.xinitrc
    ```
3. Start X session with `startx`

---

## Other Commands

Default boot:

```bash
# TTY
sudo systemctl set-default multi-user.target
# GUI
sudo systemctl set-default graphical.target
```

Generate lockscreen background:

```bash
betterlockscreen -u $HOME/pictures/wallpapers/iceland_blur.png --display 1
```

---

## Optional Packages Install

Desktop:

```bash
# For AIO
yay -Syu liquidctl
sudo systemctl daemon-reload && sudo systemctl start liquidcfg && systemctl enable liquidcfg
```

Laptop:

```bash
yay -Syu auto-cpufreq
sudo systemctl enable auto-cpufreq
```

---

## Antidote:

-   Download installer from official website
-   Before proceeding to the installation, run:
-   `mkdir /etc/dbus-1 && mkdir /etc/dbus-1/system.d`
-   If Antidote was previously installed:
-   `rm -rf /opt/Druide`
