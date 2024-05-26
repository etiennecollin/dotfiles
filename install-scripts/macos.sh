#!/bin/sh

# Make sure brew is installed
if ! command -v brew >/dev/null; then
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Dependencies of dotfiles
brew install --quiet --formula bat fastfetch fzf gh gnu-sed gnupg graphviz hexyl lazygit neovim ollama openssl pandoc parallel pngpaste poetry python ripgrep silicon stlink testdisk tlrc tmux trash tree typst wakeonlan wget zellij zoxide

brew install --quiet --cask aldente appcleaner blender brave-browser calibre coconutbattery discord font-jetbrains-mono-nerd-font freecad glance-chamburr hakuneko kicad libreoffice macs-fan-control omnidisksweeper rectangle sioyek transmission wezterm

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
