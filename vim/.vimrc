" use vim settings instead of vi (must be first)
set nocompatible

" -----------------------------------------------------------------------------
" Vundle Configuration {{{
" -----------------------------------------------------------------------------

" install vundle if it doesn't exist on the current system
let vundle_installed=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')

if !filereadable(vundle_readme)
  echo "Installing Vundle..."
  echo ""

  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  let vundle_installed=0
endif

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

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
Plugin 'tmux-plugins/vim-tmux-focus-events'

call vundle#end()

" only install plugins if vundle was just installed
if vundle_installed == 0
  echo "Installing plugins"
  echo ""
  :PluginInstall
  :qa
endif

" }}}

" -----------------------------------------------------------------------------
" General {{{
" -----------------------------------------------------------------------------

" change map leader from \ to ,
let mapleader=","

" reload files when changed outside of vim
set autoread
autocmd FocusGained,BufEnter * :checktime

" allow backspace over anything in Insert mode
set backspace=indent,eol,start

" allow buffers to be put in the background without writing the file, and
" preserve undo-history, and marks when returning to buffer
set hidden

" bump up history limit from 20 to 1000
set history=1000

" enable extended `%` matching. note: runtime is the same as source except
" that it's relative to the vim installation directory
runtime macros/matchit.vim

" replace system bell with screen flash
set visualbell

" }}}

" -----------------------------------------------------------------------------
" Colors and Fonts {{{
" -----------------------------------------------------------------------------

" turn syntax highlighting on
syntax enable

" set color scheme to dark solarized
set background=dark
colorscheme solarized

" }}}

" -----------------------------------------------------------------------------
" Text and Spacing {{{
" -----------------------------------------------------------------------------

" number of visual spaces per TAB
set tabstop=2

" number of spaces in TAB when editing
set softtabstop=2

" number of spaces per TAB
set shiftwidth=2

" tabs are spaces
set expandtab

" copy indent from current line
set autoindent

" use multiples of shiftwidth when indenting with `<<` or `>>`
set shiftround

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" turn modelines on
set modelines=1

" number of vertical screen lines to show around cursor
set scrolloff=8

" number of horizontal screen lines to show around cursor
set sidescrolloff=15

" number of columns to scroll horizontally by
set sidescroll=1

" only wrap at characters in `breakat` option
set linebreak

" turn list off as it disables linebreak
set nolist

" string to put before wrapped screen lines
set showbreak=↪\ \

" }}}

" -----------------------------------------------------------------------------
" UI configuration {{{
" -----------------------------------------------------------------------------

" show line numbers
set number

" show command in bottom bar
set showcmd

" highlight current line
set cursorline

" load filetype-specific indent files
filetype plugin indent on

" redraw only when we need to (not during macros)
set lazyredraw

" faster redraws
set ttyfast

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

" visual autocomplete for command menu and behave line shell completion
set wildmenu
set wildmode=list:longest

" }}}

" -----------------------------------------------------------------------------
" Search {{{
" -----------------------------------------------------------------------------

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

" ignore case when searching a file
set ignorecase

" override `ignorecase` when a upper case letter is entered
set smartcase

" }}}

" -----------------------------------------------------------------------------
" Folding {{{
" -----------------------------------------------------------------------------

" turn folding off by default
set nofoldenable

" fold any blocks nested 10 times
set foldlevelstart=10

" only fold up to 10 nested blocks
set foldnestmax=10

" }}}

" -----------------------------------------------------------------------------
" Key mappings {{{
" -----------------------------------------------------------------------------

" set space to clear out search highlighting
nnoremap <leader><space> :noh<return><esc>

" shortcuts to cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" shortcut to edit/reload vimrc
nmap <silent> <leader>ev :e $VIMRC<CR>
nmap <silent> <leader>sv :so $VIMRC<CR>

" shortcut to delete a buffer without closing the split
nnoremap <leader>d :bp\|bd #<CR>

" }}}

" -----------------------------------------------------------------------------
" CtrlP {{{
" -----------------------------------------------------------------------------

" ignore node_modules directory
let g:ctrlp_custom_ignore='\v[\/](node_modules)$'

" show hidden files in CtrlP
let g:ctrlp_show_hidden=1

" }}}

" -----------------------------------------------------------------------------
" Powerline {{{
" -----------------------------------------------------------------------------

" enable powerline fonts
let g:airline_powerline_fonts=1

" }}}

" vim:foldmethod=marker:foldlevel=0
