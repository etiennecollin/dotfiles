#!/bin/sh

# Make sure yay is installed
if ! command -v yay >/dev/null; then
	sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay
fi

yay -Syuq --needed bat blender bottom-git brave-bin brave-browser calf calibre celluloid discord discord easyeffects ethtool fail2ban fastfetch fd ffmpegthumbnailer freecad fzf gamemode github-cli gnupg graphviz hakuneko-desktop-bin hexyl htop jq kicad lazygit libreoffice-fresh lsp-plugins man-db man-pages neovim noto-fonts ntfs-3g nvtop openssh openssl os-prober pandoc-cli parallel poetry poppler python ripgrep rustup sed silicon sioyek steam stlink sudo testdisk tlrc tmux transmission-gtk trash tree ttf-jetbrains-mono-nerd typst udiskie ufw unarchiver unzip via-bin wezterm wget xclip xdg-ninja-git xdg-user-dirs xdg-utils yazi yubico-authenticator-bin yubikey-manager-qt zellij zip zoxide zsh

# Other dependencies
# texlive-meta

# Enable Yubikey service
sudo systemctl enable pcscd.service
# Update xdg directories
xdg-user-dirs-update
# Setup gpg agent
gpg-agent --daemon
# Updating mandb
sudo mandb
# Set default rust toolchain
rustup default stable

################################################################################

echo "| ########################################"
echo "| Setting up Steam"
echo "| ########################################"
# Enable multilib
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Install steam
if command -v nvidia-smi >/dev/null; then
	yay -S needed steam ttf-liberation lib32-nvidia-utils
else
	yay -S needed steam ttf-liberation lib32-mesa
fi

# Increase vm.max_map_count
if [ ! -f /etc/sysctl.d/80-gamecompatibility.conf ]; then
	echo "vm.max_map_count = 2147483642" | sudo tee -a /etc/sysctl.d/80-gamecompatibility.conf >/dev/null
	sudo sysctl --system >/dev/null
fi

################################################################################

echo "| ########################################"
echo "| Setting up SSH server"
echo "| Also see www.ssh-audit.com/hardening_guides.html"
echo "| ########################################"
# Overwrite sshd config
sudo mkdir -p "/etc/ssh"
sudo cp "${XDG_DATA_HOME:-$HOME/.local/share}/chezmoi/etc/ssh/sshd_config" "/etc/ssh/sshd_config"
sudo awk -i inplace '$5 >= 3071' /etc/ssh/moduli >/dev/null

# Enable SSH server
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

# Enable fail2ban
sudo mkdir -p "/etc/fail2ban/"
sudo cp "${XDG_DATA_HOME:-$HOME/.local/share}/chezmoi/etc/fail2ban/jail.local" "/etc/fail2ban/jail.local"
sudo systemctl enable fail2ban.service
sudo systemctl start fail2ban.service

# Setup ufw
sudo systemctl enable ufw.service
sudo ufw limit 22/tcp comment "Generic SSH"
sudo ufw limit 22022/tcp comment "Custom SSH"
sudo ufw limit 9/udp comment "Wake-on-LAN"
sudo ufw allow 80/tcp comment "HTTP"
sudo ufw allow 443/tcp comment "HTTPS"
sudo ufw default deny incoming comment "Deny all incoming"
sudo ufw default allow outgoing comment "Allow all outgoing"
sudo ufw enable

################################################################################

# Setup WOL
if [ ! -f "/etc/systemd/system/wol@.service" ]; then
	echo "| ########################################"
	echo "| Setting up wake-on-lan..."
	echo "| ########################################"
	sudo mkdir -p "/etc/systemd/system"
	sudo cp "${XDG_DATA_HOME:-$HOME/.local/share}/chezmoi/etc/systemd/system/wol@.service" "/etc/systemd/system/wol@.service"
	sudo systemctl enable "wol@${WOL_NETWORK_INTERFACE}.service"
	sudo systemctl start "wol@${WOL_NETWORK_INTERFACE}.service"
fi

################################################################################

# Setup liquidctl if NZXT Kraken AIO is used
if [ "$USE_KRAKEN_AIO" = true ] && [ ! -f "/etc/systemd/system/liquidcfg.service" ]; then
	echo "| ########################################"
	echo "| Setting up liquidctl..."
	echo "| ########################################"
	yay -S --needed liquidctl
	sudo mkdir -p "/etc/systemd/system"
	sudo cp "${XDG_DATA_HOME:-$HOME/.local/share}/chezmoi/etc/systemd/system/liquidctl.service" "/etc/systemd/system/liquidctl.service"
	sudo systemctl enable liquidctl.service
	sudo systemctl start liquidctl.service
fi

################################################################################

# Setup sudoers file for power commands
commentString="# Disabling sudo for power commands."
commandString="${commentString}\n$USER $(hostnamectl hostname) =NOPASSWD: /usr/bin/systemctl poweroff, /usr/bin/systemctl halt, /usr/bin/systemctl reboot, /usr/bin/systemctl suspend, /usr/bin/systemctl hibernate\n\n"

# Evaluate command to remove ${commentString} and $USER
eval $commandString >/dev/null

if [ "$REQUIRE_SUDO_POWER" = true ]; then
	# Check if command is already in sudoers file
	sudo grep -Pzq "${commandString}" /etc/sudoers >/dev/null
	if [ $? -eq 0 ]; then
		sudo sed -i "/^${commentString}$/,/^$/d" /etc/sudoers >/dev/null
	fi
else
	# Check if command is already in sudoers file
	sudo grep -Pzq "${commandString}" /etc/sudoers >/dev/null
	if [ $? -ne 0 ]; then
		printf "${commandString}" | sudo tee -a /etc/sudoers >/dev/null
	fi
fi
