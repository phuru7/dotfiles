##
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
alias rm='rm -Rf'
alias l="ls" # List files in current directory
alias ll="ls -alh" # List all files in current directory in long list format
alias o="explorer.exe" # Open the current directory in Finder
alias pbcopy='clip.exe'
alias dw='cd /mnt/c/Users/Santi/OneDrive/1Downloads'
alias db='cd /mnt/c/Users/Santi/Dropbox/'
alias od='cd /mnt/c/Users/Santi/OneDrive'
alias ex='cd /mnt/c/Users/santi/Dropbox/4FinanceTracker/2024'

#-------------
# tmux aliases
#-------------
alias santi='tmux new -s " Phuru " -n "ﮧ"'
alias santiatt='tmux attach -t " Phuru "'

#------------
# Git Aliases
#------------
alias gaa='git add .'
alias gcm='git commit -m'
alias gpsh='git push'
alias gss='git status -s'

#-------
#exports
#-------
export od=/mnt/c/Users/Santi/OneDrive/
export db=/mnt/c/Users/santi/Dropbox/
