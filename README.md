# DOTFILES

**Dotfiles for easy system installs.**

---

# SETUP COMMANDS

## PACKAGES

Install yay:

> sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

General:

> yay -Syu brave-bin curl github-desktop discord htop via-bin celluloid yubikey-manager-qt yubioath-desktop zsh openssh fail2ban visual-studio-code-bin xdg-ninja-git glow neovim neofetch i3-wm betterlockscreen nano polybar python-pywal rofi picom nnn zip unzip arandr feh udisks2 udiskie imagemagick scrot lxappearance lxsession dunst os-prober texlive-most biber tllocalmgr-git xterm playerctl man-db man-pages autotiling noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra nerd-fonts-jetbrains-mono wol-systemd parsec-bin github-cli

Desktop:

> yay -Syu liquidctl

Laptop:

> yay -Syu auto-cpufreq

---

## CONFIG FILES

Start i3 with "startx":

In ~/.xinitrc delete content after last fi.

> sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc && echo -e "\nexec i3" >> ~/.xinitrc

Allow power commands without sudo:

> echo -e "\netiennecollin archlinux =NOPASSWD: /usr/bin/systemctl poweroff,/usr/bin/systemctl halt,/usr/bin/systemctl reboot, /usr/bin/systemctl suspend, /usr/bin/systemctl hibernate" | sudo tee -a /etc/sudoers

---

## GITHUB REPOS

nnn plugins:

> curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh

Oh-my-zsh:

> sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Powerlevel10k:

> git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

---

## SYSTEMCTL

> sudo systemctl enable sshd

> sudo systemctl enable fail2ban

> sudo systemctl enable auto-cpufreq

> sudo systemctl enable betterlockscreen@$USER

> sudo systemctl daemon-reload && sudo systemctl start liquidcfg && systemctl enable liquidcfg

---

## WOL

List network interfaces with:

> ip link show

Enable systemd service (wol@_interface_.service) for each interface with:

> sudo systemctl enable wol@enp113s0.service
> sudo systemctl enable wol@enp112s0.service

---

## OTHER COMMANDS

For autotiling:

> pip3 install i3ipc

Boot in TTY:

> sudo systemctl set-default multi-user.target

Generate lockscreen background:

> betterlockscreen -u $HOME/pictures/wallpapers/iceland_blur.png --display 1

Generate man database:

> mandb

Antidote:
- Download installer from official website
- Before proceeding to the installation, run:
> mkdir /etc/dbus-1 && mkdir /etc/dbus-1/system.d
- If Antidote was previously installed:
> rm -rf /opt/Druide

---

## KEYMAP

For Apple Laptop:

> echo -e "\nexec setxkbmap -model apple_laptop -layout ca -variant multi" >> ~/.xinitrc

Run following command:

> localectl --no-convert set-x11-keymap ca apple_laptop multi

> localectl set-keymap --no-convert cf
