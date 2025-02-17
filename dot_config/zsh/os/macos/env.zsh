export XDG_CONFIG_HOME="$HOME/.config"

# Export pipx path
export PATH="$HOME/.local/bin:$PATH"

# Initialize Cargo
source "$HOME/.cargo/env"

# Set PATH, MANPATH, etc., for Homebrew.
local brew_path="/opt/homebrew/bin/brew"
if [ -f $brew_path ]; then
    # Initialize Homebrew environment using the found brew path
    eval "$($brew_path shellenv)"

    # Use Homebrew's Python
    export PATH="$($brew_path --prefix python)/libexec/bin:$PATH"
fi

# # Initialize Ruby downloaded via Homebrew's chruby
# source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
# source /opt/homebrew/opt/chruby/share/chruby/auto.sh
# chruby ruby-3.1.3 # run 'chruby' to see actual version to se as argument
#
# # Initialize Haskell
# [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
