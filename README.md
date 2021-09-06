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
```
config config --local status.showUntrackedFiles no
```
