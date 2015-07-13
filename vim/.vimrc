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
Plugin 'tpope/vim-fugitive'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'mattn/emmet-vim'

" Required. All of your Plugins must be added before the following line
call vundle#end()

if vundle_installed == 0
  echo "Installing plugins"
  echo ""
  :PluginInstall
  :qa
endif

filetype plugin indent on

" config settings based on http://dougblack.io/words/a-good-vimrc.html

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
set shiftwidth=2    " number of spaces per tab
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
set timeoutlen=50   " decrease timeout to update mode UI
set noshowmode      " remove default mode infavor of airline
set wildmenu        " visual autocomplete for command menu

"
" Search
"

set incsearch       " search as characters are entered
set hlsearch        " highlight matches

"
" Key mappings
"

" set space to clear out search highlighting
nnoremap <space> :noh<return><esc>

" shortcuts to cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

"
" Misc
"

set autoread                    " reload files when changed outside of vim
set backspace=indent,eol,start  " allow backspace over anything in Insert mode

let g:airline_powerline_fonts=1 " enable powerline fonts
let g:ctrlp_show_hidden=1

