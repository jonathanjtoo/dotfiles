# Jonathan's dotfiles

This repository includes all my dotfiles setup.

## Installation

```sh
git clone https://github.com/jonathanjtoo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install_dotfiles.py
```

When Vim is opened, vim-plug should auto-install and download needed plugins.
To update plugins and upgrade vim-plug, use the custom command:

```sh
:PU
```

Backup of existing dotfiles will be saved in `~/.dotfiles_backup/`
To restore from the backup, use the `-r` option

```sh
cd ~/.dotfiles
./install_dotfiles.py -r
```

## Thanks

Organization based on [Zack Holman](http://github.com/holman)'s brilliantly categorized [dotfiles](http://github.com/holman/dotfiles). I'm looking forward to adding more directories as I add more to my toolkit. Next stop, zsh!
