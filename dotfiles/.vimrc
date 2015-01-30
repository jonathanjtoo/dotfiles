if v:progname =~? "evim"
  finish
endif

set nocompatible    " be iMproved

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" set the runtime path to include Vundle and initialize
filetype off        " required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() " required

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'WolfgangMehner/vim-plugins'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Plugin 'vim-latex/vim-latex'
" Plugin 'mrtazz/simplenote.vim'
" source ~/.simplenoterc

call vundle#end()   " required
filetype plugin indent on  " required for Vundle
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

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


"ignore LaTeX-Box's indent
let s:extfname = expand("%:e")
if s:extfname ==? "tex" || s:extfname ==? "cls"
  let g:LatexBox_custom_indent='0'
endif

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
