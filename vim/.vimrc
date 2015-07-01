set nocompatible              " be iMproved, required
filetype off                  " required

let vundle_installed=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')

if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""

  slient !mkdir -p ~/.vim/bundle
  slient !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle

  let vundle_installed=0
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'altercation/vim-colors-solarized'

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
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" http://dougblack.io/words/a-good-vimrc.html

" enable syntax highlighting
syntax enable
set background=dark
colorscheme solarized

" spacing
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set expandtab       " tabs are spaces

"
" UI configuration
"

set number          " show line numbers
set showcmd         " show command in bottom bar
set cursorline      " highlight current line
filetype indent on  " load filetype-specific indent files
set lazyredraw      " redraw only when we need to
set showmatch       " highlight matching [{()}]

"
" Search
"

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
