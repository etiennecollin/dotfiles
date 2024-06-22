#!/bin/sh

# Make sure brew is installed
if ! command -v brew >/dev/null; then
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Dependencies of dotfiles
brew install --quiet --formula bat eza fastfetch fd ffmpegthumbnailer fzf gh git-delta gnu-sed gnupg graphviz hexyl jq lazygit neovim oh-my-posh ollama openssl pandoc parallel pngpaste poetry poppler python ripgrep silicon stlink testdisk tlrc tmux trash tree typst unar wakeonlan wget yazi zellij zoxide

brew install --quiet --cask alacritty aldente appcleaner blender brave-browser calibre coconutbattery discord font-jetbrains-mono-nerd-font freecad glance-chamburr hakuneko keepassxc kicad libreoffice macs-fan-control omnidisksweeper rectangle sioyek transmission wezterm

# Other dependencies
# mactex ghdl gtkwave

# Make sure rust is installed
if ! command -v rustup >/dev/null; then
	echo "| ########################################"
	echo "| Installing rust..."
	echo "| ########################################"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
	echo "| ########################################"
	echo "| Updating rust..."
	echo "| ########################################"
	rustup update
fi
