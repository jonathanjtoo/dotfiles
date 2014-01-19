if v:progname =~? "evim"
  finish
endif

set nocompatible

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

call pathogen#incubate()
call pathogen#helptags()

set nu
set expandtab
set shiftwidth=4
set tabstop=4
set ignorecase
set smartcase
set clipboard=unnamedplus
set autoindent
set smartindent
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set wrap linebreak nolist

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
filetype plugin indent on

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
 
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
