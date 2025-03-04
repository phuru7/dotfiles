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
alias db="cd /Users/santiago/Library/CloudStorage/Dropbox"
alias dw="/Users/santiago/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads"
# ----------------------
# Git Aliases
# ----------------------
alias gaa='git add .'
alias gcm='git commit -m'
alias gpsh='git push'
alias gss='git status -s'
