export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
# -------
# Aliases
# -------
alias l="ls -hl" # List files in current directory
alias ll="ls -al" # List all files in current directory in long list format
alias o="open" # Open the current directory in Finder
alias k='kubectl'
alias dc='docker-compose'
# ----------------------
# Git Aliases
# ----------------------
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin'
alias gss='git status -s'
