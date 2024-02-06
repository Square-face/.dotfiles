
export PATH=$HOME/.cargo/bin:$PATH
export STARSHIP_CONFIG=~/.dotfiles/starship.toml

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

eval "$(starship init zsh)"
