if v:progname =~? "evim"
  finish
endif

set nocompatible    " be iMproved

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" Auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/autoload_cscope.vim'
Plug 'jlanzarotta/bufexplorer'
let g:bufExplorerVersionWarn=0
Plug 'chazy/cscope_maps'

""""""""" Python plugins """""""""""
"" AutoComplete for many languages
"Plug 'Valloric/YouCompleteMe'
"" close autocomplete window when done
"let g:ycm_autoclose_preview_window_after_completion=1
"" shortcut to goto definition
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Python's indent folding
Plug 'tmhedberg/SimpylFold'
" Include __doc__ in folded preview
let g:SimpylFold_docstring_preview=1

" Plug 'WolfgangMehner/vim-plugins'
" Plug 'vim-latex/vim-latex'
" Plug 'mrtazz/simplenote.vim'
" source ~/.simplenoterc

call plug#end()

" Update all plugins and then upgrade vim-plug
command! PU PlugUpdate | PlugUpgrade

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
" let g:C_InsertFileHeader='no'
" let g:BASH_InsertFileHeader='no'
set splitright
set splitbelow

"ignore case for files and commands
if exists("&wildignorecase")
    set wildignorecase
endif
if has('wildmenu')
    set wildmenu
    set wildmode=list:longest,full
endif

"clipboard upgrade
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

"highlight search results
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"color solarized
syntax enable
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized

filetype plugin indent on

"Diff modified vs original shortcut
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

" Associate .py files as python files
au BufRead,BufNewFile *.py set filetype=python


" Highlight line if more than 80 characters. (Optional)
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" If doing a diff. Upon writing changes to file, automatically update the
" differences
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" Highlight bad extra white spaces
" define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8

" Use :TrimWhiteSpace to remove all BadWhiteSpace
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command TrimWhiteSpace call TrimWhiteSpace()

" Disable middle/third click
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

