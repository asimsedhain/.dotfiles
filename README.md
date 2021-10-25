# Install your dotfiles onto a new system (or migrate to this setup)

If you already store your configuration/dotfiles in a Git repository, on a new system you can migrate to this setup with the following steps:

* Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:

```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

* And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:

```
echo ".dotfiles" >> .gitignore
```

* Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:

```
git clone --bare https://github.com/asimsedhain/.dotfiles.git $HOME/.dotfiles
```
* Define the alias in the current shell scope:
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
* Checkout the actual content from the bare repository to your $HOME:
```
config checkout
```
* Don't show untracked file
```
config config --local status.showUntrackedFiles no
```
* Install Plug for Neovim
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
* Install NVM
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```
* Install Node
```
nvm install node # "node" is an alias for the latest version
```
* Install zsh
```
apt install zsh
```
* Install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
* Make zsh your default terminal
```
chsh -s /bin/zsh
```
