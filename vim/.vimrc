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

" Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'bling/vim-airline'

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

"
" Syntax highlighting
"

syntax enable
set background=dark
colorscheme solarized

"
" Spacing
"

set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set expandtab       " tabs are spaces

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace

"
" UI configuration
"

set number          " show line numbers
set showcmd         " show command in bottom bar
set cursorline      " highlight current line
filetype indent on  " load filetype-specific indent files
set lazyredraw      " redraw only when we need to
set showmatch       " highlight matching [{()}]
set colorcolumn=80  " adds 80 character vertical line
set laststatus=2    " always show vim-airline

"
" Search
"

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

"
" Key mappings
"

" set space to clear out search highlighting
nnoremap <space> :noh<return><esc>


"
" Misc
"

set autoread        " reload files when changed outside of vim

