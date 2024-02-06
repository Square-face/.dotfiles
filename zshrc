
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

eval "$(starship init zsh)"
