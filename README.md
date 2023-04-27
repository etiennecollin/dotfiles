# DOTFILES - Setup Commands <!-- omit from toc -->

**Dotfiles for easy system installs.**

## Table of Contents <!-- omit from toc -->

- [Install Packages and Dependencies](#install-packages-and-dependencies)
- [Clone GitHub Repos](#clone-github-repos)
- [Link Config Files](#link-config-files)
- [Systemctl Setup](#systemctl-setup)
- [Other Commands](#other-commands)


## Install Packages and Dependencies

Install yay:

```bash
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

General:

```bash
yay -Syu brave-bin curl github-desktop discord htop via-bin celluloid yubikey-manager-qt yubioath-desktop zsh openssh fail2ban visual-studio-code-bin xdg-ninja-git glow neovim neofetch i3-wm betterlockscreen nano polybar python-pywal rofi picom nnn zip unzip arandr feh udisks2 udiskie imagemagick scrot lxappearance lxsession dunst os-prober texlive-most biber tllocalmgr-git xterm playerctl man-db man-pages autotiling noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra nerd-fonts-jetbrains-mono parsec-bin github-cli
```

Desktop:

```bash
# For AIO
yay -Syu liquidctl
```

Laptop:

```bash
yay -Syu auto-cpufreq
```

---

## Clone GitHub Repos

nnn plugins:

```bash
curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
```

Oh-my-zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Powerlevel10k:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

---

## Link Config Files

Start i3 with "startx":

In ~/.xinitrc delete content after last fi.

```bash
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc && echo -e "\nexec i3" >> ~/.xinitrc
```

Symlink all config files:

```bash
mkdir ~/github
cd ~/github
git clone https://github.com/etiennecollin/dotfiles.git

cd ~/.config
rm -rf i3 polybar nvim kitty zsh/.zshrc zsh/p10k.zsh neofetch

ln -s ~/github/dotfiles/config/i3 ~/.config/i3
ln -s ~/github/dotfiles/config/polybar ~/.config/polybar
ln -s ~/github/dotfiles/config/nvim ~/.config/nvim
ln -s ~/github/dotfiles/config/kitty ~/.config/kitty
ln -s ~/github/dotfiles/config/zsh/.zshrc ~/.config/zsh/.zshrc
ln -s ~/github/dotfiles/config/zsh/p10k.zsh ~/.config/zsh/p10k.zsh
ln -s ~/github/dotfiles/config/neofetch ~/.config/neofetch
```

---

## Systemctl Setup

```bash
sudo systemctl enable sshd

sudo systemctl enable fail2ban

sudo systemctl enable auto-cpufreq

sudo systemctl enable betterlockscreen@$USER

sudo systemctl daemon-reload && sudo systemctl start liquidcfg && systemctl enable liquidcfg
```

---

## Other Commands

For autotiling:

```bash
pip3 install i3ipc
```

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

Generate man database:

```bash
mandb
```

Allow power commands without sudo:

```bash
echo -e "\netiennecollin archlinux =NOPASSWD: /usr/bin/systemctl poweroff,/usr/bin/systemctl halt,/usr/bin/systemctl reboot, /usr/bin/systemctl suspend, /usr/bin/systemctl hibernate" | sudo tee -a /etc/sudoers
```

Antidote:

-   Download installer from official website
-   Before proceeding to the installation, run:
-   `mkdir /etc/dbus-1 && mkdir /etc/dbus-1/system.d`
-   If Antidote was previously installed:
-   `rm -rf /opt/Druide`
