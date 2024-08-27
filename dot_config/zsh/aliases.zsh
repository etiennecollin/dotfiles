alias a="zellij attach --create main"
alias at="zellij options --serialize-pane-viewport false --session-serialization false"
alias cat="bat -pp --color=never"
alias cm="chezmoi"
alias imgcat="wezterm imgcat"
alias lag="lazygit"
alias lad="lazydocker"
alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias rm="trash"
alias sshp="ssh -L 8080:localhost:8080 -L 11434:localhost:11434 -L 8888:localhost:8888"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias poetry_shell='source $(poetry env info --path)/bin/activate'

alias jekyll="bundle exec jekyll serve --livereload"
alias leptosfmt="leptosfmt -m 120 src/**/*.rs"
alias pytypstw="python -m typst_pyimage -w -a \"--root ~ --open sioyek\""
alias tserve="trunk serve --open"
alias typstc="typst compile --root ~"
alias typstw="typst watch --root ~ --open sioyek"

alias format="python ~/github/gist/file_system_formatter.py"
alias office2pdf="~/github/gist/office_to_pdf.sh"
alias uni="cd ~/Desktop/university/semester-4/"
