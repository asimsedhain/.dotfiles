# zsh case insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# adding python env
export PATH="$PATH:$HOME/Library/Python/3.8/bin"

# NVM node version manager settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


export PS1="%1/ >"

runCpp(){
	g++ "$1" -o ./tempCpp && ./tempCpp && rm ./tempCpp;
}

# Bash aliases
alias ls="ls -lah"
alias ta="tmux a"
alias vim="nvim"

# Git aliases
alias gl="git log --decorate --all --graph --oneline"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gpush="git push"
alias gpull="git pull"
alias grprune="git remote prune origin"


# Docker aliases
alias dockKill='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'
alias dockPrune='docker image rm $(docker image ls -q -f "dangling=true")'
alias dockMasterPrune='docker image rm $(docker image ls -q)'

# SSH
alias sshPi='ssh pi@10.120.69.1'


#seting the editor
export EDITOR="nvim"
export VISUAL="nvim"
