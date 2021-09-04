# NVM node version manager settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '- ('$branch')'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

export PS1="%1/$(git_branch_name) >"

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


#seting the editor
export EDITOR="nvim"
export VISUAL="nvim"
