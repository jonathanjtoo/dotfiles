# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias h='history'

#ARCH LINUX only
alias pacman='yaourt'
alias pacup="echo 'pacman -Syu --aur --devel' && pacman -Syu --aur --devel"

#Mac only
alias brewup="echo 'brew update && brew upgrade && brew cask list | xargs brew cask upgrade && brew cleanup' \
&& brew update && brew upgrade && brew cask list | xargs brew cask upgrade && brew cleanup"
