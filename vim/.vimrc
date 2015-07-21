set nocompatible              " be iMproved, required
filetype off                  " required

let vundle_installed=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')

if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""

  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  let vundle_installed=0
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'mattn/emmet-vim'
Plugin 'wavded/vim-stylus'

" Required. All of your Plugins must be added before the following line
call vundle#end()

if vundle_installed == 0
  echo "Installing plugins"
  echo ""
  :PluginInstall
  :qa
endif

filetype plugin indent on

"
" General
"

" change map leader from \ to ,
let mapleader=","

" reload files when changed outside of vim
set autoread

" allow backspace over anything in Insert mode
set backspace=indent,eol,start

"
" Syntax highlighting
"

syntax enable
set background=dark
colorscheme solarized

"
" Spacing
"

" number of visual spaces per TAB
set tabstop=2

" number of spaces in tab when editing
set softtabstop=2

" number of spaces per tab
set shiftwidth=2

" tabs are spaces
set expandtab

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace

"
" UI configuration
"

" show line numbers
set number

" show command in bottom bar
set showcmd

" highlight current line
set cursorline

" load filetype-specific indent files
filetype indent on

" redraw only when we need to (not during macros)
set lazyredraw

" highlight matching [{()}]
set showmatch

" adds 80 character vertical line
set colorcolumn=80

" always show vim-airline
set laststatus=2

" decrease timeout to update mode UI
set timeoutlen=1000
set ttimeoutlen=10

" remove default mode infavor of airline
set noshowmode

" visual autocomplete for command menu
set wildmenu

"
" Search
"

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

"
" Key mappings
"

" set space to clear out search highlighting
nnoremap <leader><space> :noh<return><esc>

" shortcuts to cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" shortcut to edit/reload vimrc
nmap <silent> <leader>ev :e $VIMRC<CR>
nmap <silent> <leader>sv :so $VIMRC<CR>

"
" Misc
"

" enable powerline fonts
let g:airline_powerline_fonts=1
let g:ctrlp_show_hidden=1

