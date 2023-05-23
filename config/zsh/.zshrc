# Launch Programs
neofetch

#######################################################################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy/mm/dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $XDG_CONFIG_HOME/zsh/p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/p10k.zsh

#######################################################################################################################
#######################################################################################################################
#######################################################################################################################

# Aliases
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias v=nvim
alias vim=nvim
alias top=htop
alias nnn="nnn -e -H -i -P p"
alias ssh="ssh -X"
alias bynn="cd ~/github/BYNN/"
alias label="cd ~/github/BYNN/src/labelling && labelme images/ --labels labels.txt --validatelabel exact --nodata --autosave --keep-prev"
alias jekyll-run="cd ~/github/etiennecollin.github.io && bundle exec jekyll serve --livereload"

# Custom GPG functions
function secret {  # list preferred id last
  output="$(dirname ${1})/$(basename ${1}).$(date +%F).asc"
  recipients=${2:-collin.etienne.contact@gmail.com}

  gpg --encrypt --armor --output ${output} -r "${recipients}" "${1}" \
    && echo "$(basename "${1}") -> $(basename "${1}")_$(date +%F).asc"
}

function secret-sign {  # list preferred id last
  output="$(dirname ${1})/$(basename ${1}).$(date +%F).asc"
  recipients=${2:-collin.etienne.contact@gmail.com}

  gpg --sign --encrypt --armor --output ${output} -r "${recipients}" "${1}" \
    && echo "$(basename "${1}") -> $(basename "${1}")_$(date +%F).asc"
}

function reveal {
  output=$(echo "${1}" | rev | cut -c16- | rev)

  gpg --decrypt --output ${output} "${1}" \
    && echo "$(basename "${1}") -> $(basename "${output}")"
}

function scd {
    # Check that number of arguments is 1
    if [ $# -ne 1 ]; then
        echo "Please input the path to a directory as the argument."
        return 0
    fi

    # Store the given path as a variable
    dirpath=$1

    # Check that the path is a directory
    if ! [[ -d $dirpath ]]; then
        echo "Please input the path to a directory as the argument."
        return 0
    fi

    # While $dirpath contains a single item...
    while [ $(ls $dirpath | wc -l) -eq 1 ]; do
        # If the item in the directory is also a directory
        if [[ -d $dirpath/$(ls $dirpath) ]]; then
            # Add it to the path to cd into
            dirpath=$dirpath/$(ls $dirpath)
        else
            break
        fi
    done

    # cd into the directories
    cd $dirpath
}

#######################################################################################################################

# Initialize pyenv and pyenv-virtualenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
############

# Install Ruby Gems to ~/gems
#export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
#export PATH="$GEM_HOME/bin:$PATH"
############

# Initialize GPG
export GPG_TTY=$(tty)
export PATH="/usr/local/sbin:$PATH"
#############

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/etiennecollin/.config/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/etiennecollin/.config/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/etiennecollin/.config/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/etiennecollin/.config/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
