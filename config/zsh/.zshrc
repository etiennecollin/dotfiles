# Launch Programs
fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################################################################################
# Aliases
################################################################################
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias less="less -R"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias a="zellij attach --create main"
alias z="zellij options --serialize-pane-viewport false --session-serialization false"
alias imgcat="wezterm imgcat"
alias rm="trash"

alias jekyll="bundle exec jekyll serve --livereload"
alias leptosfmt="leptosfmt -m 120 src/**/*.rs"
alias tserve="trunk serve --open"
alias typstw="typst watch --root ~ --open sioyek"
alias typstc="typst compile --root ~"
alias pytypstw="python -m typst_pyimage -w -a \"--root ~ --open sioyek\""

alias format="python /Users/etiennecollin/github/gist/file_system_formatter.py"
alias office2pdf="/Users/etiennecollin/github/gist/office_to_pdf.sh"
alias uni="cd ~/Desktop/university/semester-4/"

################################################################################
# Plugins and completions
################################################################################
# Download Zinit, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ ! -f "$XDG_CONFIG_HOME/zsh/.p10k.zsh" ] || source "$XDG_CONFIG_HOME/zsh/.p10k.zsh"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

################################################################################
# Custom GPG functions
################################################################################
function secret { # list preferred id last
	output="$(dirname ${1})/$(basename ${1}).$(date +%F).asc"
	recipients=${2:-collin.etienne.contact@gmail.com}

	gpg --encrypt --armor --output ${output} -r "${recipients}" "${1}" &&
		echo "$(basename "${1}") -> $(basename "${1}").$(date +%F).asc"
}

function secret-sign { # list preferred id last
	output="$(dirname ${1})/$(basename ${1}).$(date +%F).asc"
	recipients=${2:-collin.etienne.contact@gmail.com}

	gpg --sign --encrypt --armor --output ${output} -r "${recipients}" "${1}" &&
		echo "$(basename "${1}") -> $(basename "${1}").$(date +%F).asc"
}

function reveal {
	output=$(echo "${1}" | rev | cut -c16- | rev)

	gpg --decrypt --output ${output} "${1}" &&
		echo "$(basename "${1}") -> $(basename "${output}")"
}

function create-env {
	# Check that number of arguments is 1
	if [ $# -ne 2 ]; then
		echo "Please input the name of your environment and the python version to use as the arguments."
		return 1
	fi

	# Store the name as a variable
	name=$1
	py_version=$2

	echo "Creating environment the environment \"$name\" will overwrite any other environment with the same name"
	echo "Are you sure you want to create the environment \"$name\" (y/n)?"
	read choice
	if [ "$choice" = "y" ]; then
		echo "Starting creation"
	elif [ "$choice" = "n" ]; then
		echo "Aborting"
		return 0
	else
		echo "Invalid selection"
		return 1
	fi

	# Create the environment
	conda create -q -y -n $name python=$py_version pip ipykernel &>/dev/null &&
		echo "Created environment \"$name\"" || {
		echo "Environment creation failed"
		return 1
	}

	# Activate the environment
	conda activate $name &>/dev/null &&
		echo "Activated environment \"$name\"" || {
		echo "Environment activation failed"
		return 1
	}

	# Create the ipykernel
	python -m ipykernel install --user --name $name &>/dev/null &&
		echo "Created ipykernel \"$name\"" || {
		echo "ipykernel creation failed"
		return 1
	}
}

function remove-env {
	# Check that number of arguments is 1
	if [ $# -ne 1 ]; then
		echo "Please input the name of your environment as the argument."
		return 1
	fi

	# Store the name as a variable
	name=$1

	echo "Are you sure you want to delete this environment (y/n)?"
	read choice
	if [ "$choice" = "y" ]; then
		echo "Starting removal"
	elif [ "$choice" = "n" ]; then
		echo "Aborting"
		return 0
	else
		echo "Invalid selection"
		return 1
	fi

	# Uninstall the ipykernel
	jupyter kernelspec uninstall -y $name &>/dev/null &&
		echo "Remove ipykernel \"$name\"" || {
		echo "ipykernel \"$name\" deletion failed"
		return 1
	}

	# Remove the environment
	conda remove -q -y -n $name --all &>/dev/null &&
		echo "Removed environment \"$name\"" || {
		echo "Environment removal failed"
		return 1
	}
}

function rcd {
	# Check that number of arguments ie 1
	if [ $# -ne 1 ]; then
		echo "Please input the path to a directory as the argument."
		return 1
	fi

	# Store the given path as a variable
	dirpath=$1

	# Check that the path is a directory
	if [ ! -d $dirpath ]; then
		echo "Please input the path to a directory as the argument."
		return 1
	fi

	# While $dirpath contains a single item...
	while [ $(ls $dirpath | wc -l) -eq 1 ]; do
		# If the item in the directory is also a directory
		if [ -d "$dirpath/$(ls $dirpath)" ]; then
			# Add it to the path to cd into
			dirpath=$dirpath/$(ls $dirpath)
		else
			break
		fi
	done

	# cd into the directories
	cd $dirpath
}

function wdiff {
	input=$1
	output=$2

	# Check that the paths is a file
	if [ ! -f $input ]; then
		echo "Please input the path to a file as the first argument."
		return 1
	elif [ ! -f $output ]; then
		echo "Please input the path to a file as the second argument."
		return 1
	fi

	git diff -U$(wc -l $input | awk "{print $1}") --word-diff --no-index --no-prefix --color -- $input $output | grep -v ^@@ | less -R

}

