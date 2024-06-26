# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# zsh case insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# adding python env
export PATH="$PATH:/usr/local/include"
export PATH="$PATH:/Users/ashimsedhain/Library/Python/3.8/bin"
export PATH="$PATH:/Users/ashimsedhain/Library/Python/3.8/lib/python/site-packages"

# NVM node version manager settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# manage dotfiles
alias dt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dts='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status'
alias dtl='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME log --decorate --all --graph --oneline'


# Cpp library paths
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# rust bin path
export PATH="$PATH:~/.cargo/bin"

# Running simple cpp scripts
runCpp(){
	g++ -std=c++17 -lfmt "$1" -o ./tempCpp && ./tempCpp && rm ./tempCpp;
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
