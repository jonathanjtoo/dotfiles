# Jonathan's dotfiles

This repository includes all my dotfiles setup.

## Installation

```sh
git clone https://github.com/jonathanjtoo/dotfiles.git ~/.dotfiles
```

[optional backup all config files]

```sh
mv ~/.vimrc ~/.vimrc_backup
mv ~/.vim ~/.vim_backup
mv ~/.bashrc ~/.bashrc_backup
mv ~/.bash_profile ~/.bash_profile_backup
mv ~/.bash_aliases ~/.bash_aliases_backup
mv ~/.gitconfig ~/.gitconfig_backup
mv ~/.gitignore_global ~/.gitignore_global_backup
mv ~/.tmux.conf ~/.tmux.conf_backup
```

soft link all config files

```sh
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/ ~/.vim
ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
ln -s ~/.dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/bash/bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
```

When Vim is opened, vim-plug should auto-install and download needed plugins.
To update plugins and upgrade vim-plug, use the custom command:

```sh
:PU
```

## Thanks

Organization based on [Zack Holman](http://github.com/holman)'s brilliantly categorized [dotfiles](http://github.com/holman/dotfiles). I'm looking forward to adding more directories as I add more to my toolkit. Next stop, zsh!
