# DOTFILES <!-- omit from toc -->

**Dotfiles for easy system installs.**

## Table of Contents

<!-- vim-markdown-toc GFM -->

- [Table of Contents](#table-of-contents)
- [Installation](#installation)
- [Setups](#setups)
  - [i3](#i3)
    - [Generate lockscreen background:](#generate-lockscreen-background)
- [Other Commands](#other-commands)
  - [Default boot target](#default-boot-target)
- [Optional Packages Install](#optional-packages-install)
- [Antidote](#antidote)

<!-- vim-markdown-toc -->

---

## Installation

Install `chezmoi` and run

```bash
chezmoi init etiennecollin
```

---

## Setups

### i3

1. In `~/.xinitrc` delete everything after last `fi`
2. Add your DE/WM to `xinitrc` (in this case, i3):
   ```bash
   sudo printf "\nexec i3\n" >> ~/.xinitrc
   ```
3. Start X session with `startx`

#### Generate lockscreen background:

```bash
betterlockscreen -u $HOME/Pictures/wallpapers/iceland_blur.png --display 1
```

---

## Other Commands

These are commands that are run in the install script and that might be useful for the user to know.

### Default boot target

```bash
# TTY
sudo systemctl set-default multi-user.target
# GUI
sudo systemctl set-default graphical.target
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

## Antidote

- Download installer from official website
- Before proceeding to the installation, run:
- `mkdir /etc/dbus-1 && mkdir /etc/dbus-1/system.d`
- If Antidote was previously installed:
- `rm -rf /opt/Druide`
