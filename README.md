# Install applications before installing dotfiles

* git

* zsh (and make it your default terminal)
```
apt install zsh

chsh -s /bin/zsh
```

* ohmyzsh
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

* nvim

* plug for nvim
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

* nvm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

* node (using nvm)
```
nvm install node # "node" is an alias for the latest version
```



# Install your dotfiles onto a new system (or migrate to this setup)

If you already store your configuration/dotfiles in a Git repository, on a new system you can migrate to this setup with the following steps:

* Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:
After that you can use the `dt` command to interact with the dotfiles.

```
alias dt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

* And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:

```
echo ".dotfiles" >> .gitignore
```

* Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:

```
git clone --bare https://github.com/asimsedhain/.dotfiles.git $HOME/.dotfiles
```

* Define the alias in the current shell scope. This might already be an alias in your .zshrc. Check before adding:
```
alias dt='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

* Checkout the actual content from the bare repository to your $HOME:
```
dt checkout
```

* Don't show untracked file
```
dt config --local status.showUntrackedFiles no
```
* Run :PlugInstall on nvim
* Run :CocInstall on nvim
