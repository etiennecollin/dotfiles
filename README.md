# DOTFILES <!-- omit from toc -->

**Dotfiles for easy system installs.**

## Table of Contents <!-- omit from toc -->

- [Installation](#installation)
- [Setup i3](#setup-i3)
- [Other Commands](#other-commands)
    - [Default boot:](#default-boot)
    - [Generate lockscreen background:](#generate-lockscreen-background)
- [Optional Packages Install](#optional-packages-install)
- [Antidote:](#antidote)

---

## Installation

Run the `install.sh` script:

```bash
git clone https://github.com/etiennecollin/dotfiles ~/github/dotfiles && cd ~/github/dotfiles && sh install.sh
```

> It is important that the repository is located at `~/github/dotfiles` and that the script is run from there.

---

## Setup i3

1. In `~/.xinitrc` delete everything after last `fi`
2. Add your DE/WM to `xinitrc` (in this case, i3):
    ```bash
    sudo printf "\nexec i3\n" >> ~/.xinitrc
    ```
3. Start X session with `startx`

---

## Other Commands

These are commands that are run in the install script and that might be useful for the user to know.

### Default boot:

```bash
# TTY
sudo systemctl set-default multi-user.target
# GUI
sudo systemctl set-default graphical.target
```

### Generate lockscreen background:

```bash
betterlockscreen -u $HOME/Pictures/wallpapers/iceland_blur.png --display 1
```

---

## Optional Packages Install

Desktop:

```bash
# For AIO
yay -Syu liquidctl
sudo rm -rf /etc/systemd/system/liquidcfg.service
sudo ln -s ~/github/dotfiles/other/etc/systemd/system/liquidcfg.service /etc/systemd/system/liquidcfg.service
sudo systemctl daemon-reload && sudo systemctl start liquidcfg && sudo systemctl enable liquidcfg
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
