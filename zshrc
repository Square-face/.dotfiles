
export PATH=$HOME/.cargo/bin:$PATH
export STARSHIP_CONFIG=~/.dotfiles/starship.toml
export PATH=~/Applications/jdk-17.0.10/bin:$PATH
export PATH=~/Applications/gradle-7.6.4/bin/:$PATH

export EDITOR=nvim
export VISUAL=nvim

# General shortcuts
alias c='clear'
alias sz='source ~/.zshrc'

# Neovim shortcuts
alias v='nvim'
alias vi='nvim init.*'
alias vm='nvim main.*'

# File navigation shortcuts
alias .='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# exa > ls
alias ls='exa'
alias l='exa -a'
alias la='exa -la'
alias ll='exa -l'

# Git schortcuts
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias glg='git log --graph --oneline --all'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'

alias cwd='pwd'

alias ta='tmux attach'
alias tls='tmux ls'
alias tns='tmux new'

eval "$(starship init zsh)"
