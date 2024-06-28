export XDG_CONFIG_HOME="$HOME/.config"

# Initialize Cargo
source "$HOME/.cargo/env"

# Set PATH, MANPATH, etc., for Homebrew.
if [ -f "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
	# Use Homebrew's Python
	export PATH="$(brew --prefix python)/libexec/bin:$PATH"
fi

# Initialize Ruby downloaded via Homebrew's chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3 # run 'chruby' to see actual version to se as argument

# Initialize Haskell
[ -f "/Users/etiennecollin/.ghcup/env" ] && source "/Users/etiennecollin/.ghcup/env" # ghcup-env
