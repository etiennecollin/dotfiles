#!/bin/sh

# Make sure yay is installed
if ! command -v yay >/dev/null; then
	pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
fi

yay -Syu --needed bat blender bottom-git brave-bin brave-browser calf calibre celluloid discord discord easyeffects fail2ban fastfetch freecad fzf gamemode github-cli gnupg graphviz hakuneko-desktop-bin hexyl htop kicad lazygit libreoffice-fresh lsp-plugins man-db man-pages neovim noto-fonts ntfs-3g nvtop openssh openssl os-prober pandoc-cli parallel poetry python ripgrep rustup sed silicon sioyek ssh-audit steam stlink sudo testdisk tlrc tmux transmission-gtk trash tree ttf-jetbrains-mono-nerd typst udiskie unzip via-bin wezterm wget xclip xdg-ninja-git xdg-user-dirs xdg-utils yubico-authenticator-bin yubikey-manager-qt zellij zip zoxide zsh

# Other dependencies
# texlive-meta

# Update xdg directories
xdg-user-dirs-update

# Set default rust toolchain
rustup default stable
