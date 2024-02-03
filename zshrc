
export STARSHIP_CONFIG=~/.dotfiles/starship.toml

alias v='nvim'
alias vi='nvim init.*'
alias vm='nvim main.*'

alias c='clear'
alias sz='source ~/.zshrc'
alias vz='nvim ~/.zshrc'

alias .='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias ls='exa'
alias l='exa -a'
alias la='exa -la'
alias ll='exa -l'

eval "$(starship init zsh)"
