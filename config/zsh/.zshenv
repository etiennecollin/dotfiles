export EDITOR=nvim
export VISUAL=nvim

# NNN
export LC_COLLATE="C" # hidden files on top
export NNN_PLUG="p:preview-tui"
export NNN_FIFO="/tmp/nnn.fifo"
export SPLIT='v' # to split Kitty vertically
export NNN_FCOLORS="AAAAE631BBBBCCCCDDDD9999" # feel free to change the colors

# XDG-ninja
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_MUSIC_DIR="$HOME/dusic"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_TEMPLATES_DIR="$HOME/templates"
export XDG_VIDEOS_DIR="$HOME/videos"

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
