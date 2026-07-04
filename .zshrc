# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="kolo" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

# vi-mode plugin customization
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_VISUAL=2

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# zsh case insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# NVM node version manager settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# manage dotfiles
alias dt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dts='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status'
alias dtl='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME log --decorate --all --graph --oneline'


# Cpp library paths only if on MacOS
if [[ "$(uname)" == "Darwin" ]]; then
    export CPATH=/opt/homebrew/include
    export LIBRARY_PATH=/opt/homebrew/lib
fi

# rust bin path
export PATH="$PATH:$HOME/.cargo/bin"

# go bin path
export PATH="$PATH:$HOME/go/bin"

# Running simple cpp scripts
runCpp(){
    g++ -std=c++23 -lfmt "$1" -o ./tempCpp &&
    ./tempCpp &&
    rm ./tempCpp
}

runCppLldb(){
    g++ -std=c++23 -g -O0 -fno-omit-frame-pointer \
        -fsanitize=address,undefined -lfmt "$1" -o ./tempCpp &&
    lldb -o run -o bt ./tempCpp &&
    rm ./tempCpp
}

# Running simple rust scripts
runRust(){
	rustc --edition=2021 "$1" -o ./tempRust && ./tempRust && rm ./tempRust;
}


# Common aliases

# Only define eza alias if eza exists
if which eza &> /dev/null
then
	alias ls="eza -lh"
	alias la="eza -lha"
fi

alias ta="tmux a"
alias tls="tmux ls"
alias tms="sh ~/.config/tmux-sessionizer"
alias vim="nvim"

# Git aliases
alias gl="git log --decorate --all --graph --oneline"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gpush="git push"
alias gpull="git pull"
alias grprune="git remote prune origin"


# Docker aliases
alias dockStop='docker stop $(docker ps -aq)'
alias dockKill='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'
alias dockPrune='docker image rm $(docker image ls -q -f "dangling=true")'
alias dockVolumeClean='docker volume rm $(docker volume ls -q)'
alias dockMasterPrune='docker image rm $(docker image ls -q)'

#kubernetes aliases
#
# Only define kubectl alias if kubectl exists
if which kubectl &> /dev/null
then
	source <(kubectl completion zsh)
	alias kctl=kubectl
	compdef __start_kubectl kctl
fi

#seting the editor
export EDITOR="nvim"
export VISUAL="nvim"


export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# enable vim mode
#bindkey -v

#OPENAI_API_KEY=$(security find-generic-password -s OpenAI-Codex -w)
export OPENAI_API_KEY=$(security find-generic-password -s openai -w)

. "$HOME/.local/bin/env"
source $HOME/.venv/bin/activate

cac() {
    if [[ -f .venv/bin/activate ]]; then
        source .venv/bin/activate
    else
        echo "No virtual environment found at .venv/"
        return 1
    fi
}
