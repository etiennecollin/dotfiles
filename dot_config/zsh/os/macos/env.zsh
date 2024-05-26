# Set PATH, MANPATH, etc., for Homebrew.
if [ -f "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Initialize Ruby downloaded via Homebrew's chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3 # run 'chruby' to see actual version to se as argument

# Initialize Haskell
[ -f "/Users/etiennecollin/.ghcup/env" ] && source "/Users/etiennecollin/.ghcup/env" # ghcup-env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
		. "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
	else
		export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Added by Toolbox App
export PATH="$PATH:/Users/etiennecollin/Library/Application Support/JetBrains/Toolbox/scripts"
