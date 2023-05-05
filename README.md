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

1. Copy the default `xinitrc` config
    ```bash
    sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
    ```
2. In `~/.xinitrc` delete everything after last `fi`
3. Add your DE/WM to `xinitrc` (in this case, i3):
    ```bash
    sudo printf "\nexec i3\n" >> ~/.xinitrc
    ```
4. Start X session with `startx`

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
