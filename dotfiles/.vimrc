if v:progname =~? "evim"
  finish
endif

set nocompatible

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'
Bundle 'WolfgangMehner/vim-plugins'

set nu
set expandtab
set shiftwidth=4
set tabstop=4
set ignorecase
set smartcase
set autoindent
set smartindent
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set wrap linebreak nolist
let g:C_InsertFileHeader='no'
set splitright
set splitbelow

if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
