# DOTFILES

**Dotfiles for easy system installs.**

---

# SETUP COMMANDS

## PACKAGES

Install yay:

> sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

General:

> yay -Syu brave-bin curl github-desktop discord htop via-bin celluloid yubikey-manager-qt yubioath-desktop zsh openssh fail2ban visual-studio-code-bin xdg-ninja-git glow neovim neofetch i3-gaps nano polybar python-pywal rofi picom nnn zip unzip arandr feh udisks2 udiskie imagemagick scrot lxappearance lxsession dunst network-manager-applet os-prober texlive-most biber tllocalmgr-git xterm

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

Polybar themes:

> git clone --depth=1 https://github.com/adi1090x/polybar-themes.git && cd polybar-themes && chmod +x setup.sh && ./setup.sh

---

## SYSTEMCTL

> sudo systemctl enable sshd

> sudo systemctl enable fail2ban

> sudo systemctl start auto-cpufreq

---

## OTHER COMMANDS

> sudo systemctl set-default multi-user.target

---

## KEYMAP

For Apple Laptop:

> echo -e "\nexec setxkbmap -model apple_laptop -layout ca -variant multi" >> ~/.xinitrc

Run following command:

> localectl --no-convert set-x11-keymap ca apple_laptop multi

> localectl set-keymap --no-convert cf
