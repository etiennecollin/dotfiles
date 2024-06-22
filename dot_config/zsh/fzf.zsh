# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd for listing path candidates.
_fzf_compgen_path() {
	fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git . "$1"
}

# Use eza or bat to preview files and directories
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --level=3 --all --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=3 --all --color=always {} | head -200'"
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
        cd) fzf --preview "eza --tree --level=3 --all --color=always {} | head -200" "$@" ;;
        export | unset) fzf --preview "eval \${}" "$@" ;;
        ssh) fzf --preview "dig +short {}" "$@" ;;
        *) fzf --preview "$show_file_or_dir_preview" "$@" ;;
	esac
}

# Completion styling
zstyle ':completion:*' fzf-search-display true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -ww"
zstyle ':completion:*:descriptions' format '[%d]'

# fzf-tab completions
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
zstyle ':fzf-tab:complete:(cd|__zoxide_z):*' fzf-preview 'eza --tree --level=3 --all --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:(kill|ps):*' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:(kill|ps):*' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o command="" -ww'
zstyle ':fzf-tab:complete:*' fzf-preview 'if [ -d "$realpath" ]; then eza --tree --level=3 --all --color=always "$realpath" | head -200; else bat -n --color=always --line-range :500 "$realpath"; fi'
zstyle ':fzf-tab:complete:-command-:*' fzf-preview '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-flags '--preview-window=down'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
        "modified file") git diff $word | delta ;;
        "recent commit object name") git show --color=always $word | delta ;;
        *) git log --color=always $word ;;
	esac'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
        "commit tag") git show --color=always $word ;;
        *) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:ssh:*' fzf-preview 'dig +short $word'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:tldr:*' fzf-preview 'tldr --color always $word'
