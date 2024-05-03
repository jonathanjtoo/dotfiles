# Jonathan's dotfiles

This repository includes all my dotfiles setup.

## Installation
If git clone below shows permission error, may need to generate and add ssh key to GitHub settings.
```sh
git clone git@github.com:jonathanjtoo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install_dotfiles.py
```

### MacOS-specific
* Vim and Tmux are easily installed from [Homebrew](https://brew.sh/)
* Tmux paste with current config is also most compatible with iterm2
```sh
brew install tmux
brew install cask macvim
brew install cask iterm2
```

## Features
### 1. Backup and restore existing dotfiles
* Backup of existing dotfiles will be saved in `~/.dotfiles_backup/`
* To restore from the backup, use the `-r` option

```sh
cd ~/.dotfiles
./install_dotfiles.py -r
```

### 2. Vim-plug (vim plugin manager)
* When Vim is opened, vim-plug should auto-install and download needed plugins.
* To update plugins and upgrade vim-plug, use the custom command:

```sh
:PU
```

### 3. TPM (Tmux plugin manager)
- When Tmux is opened, tpm should auto-install and download needed plugins.
- To install or update plugins, use tpm's default bindings:

  - `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall)
  - `prefix` + <kbd>U</kbd> (capital u, as in **U**pdate)

## Thanks

Organization based on [Zack Holman](http://github.com/holman)'s brilliantly categorized [dotfiles](http://github.com/holman/dotfiles). I'm looking forward to adding more directories as I add more to my toolkit. Next stop, zsh!
