" use vim settings instead of vi (must be first)
set nocompatible

" -----------------------------------------------------------------------------
" Vim-plug Configuration {{{
" -----------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'baskerville/vim-sxhkdrc'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }

call plug#end()

" }}}

" -----------------------------------------------------------------------------
" General {{{
" -----------------------------------------------------------------------------

" change map leader from \ to , and map \ to reverse search
let mapleader=","
noremap \ ,

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

" move backup, swap, and undo file directories to central location
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" yank, delete, change, and put to system clipboard
set clipboard^=unnamedplus

" disable mouse buttons (but keep scroll enabled)
set mouse=

" }}}

" -----------------------------------------------------------------------------
" Colors and Fonts {{{
" -----------------------------------------------------------------------------

" turn syntax highlighting on
syntax enable

" set color scheme to dark solarized
set background=dark
colorscheme nameless

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

" encoding can only be set on startup
if has('vim_starting')
  set encoding=utf-8
endif

set fileencoding=utf-8

" string to put before wrapped screen lines
set showbreak=↪\ \

" }}}

" -----------------------------------------------------------------------------
" UI configuration {{{"{{{
" -----------------------------------------------------------------------------

" show line number relative to the cursor
set relativenumber

" show line current line number in front of the cursor
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
set noshowmatch

" adds 80 character vertical line
set colorcolumn=80

" decrease timeout to update mode UI
set timeoutlen=1000
set ttimeoutlen=10

" visual autocomplete for command menu and behave line shell completion
set wildmenu
set wildmode=list:longest

" use same vertical separator as tmux
set fillchars+=vert:│

" }}}
"}}}

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

" set C-l to clear out search highlighting
nnoremap <leader><space> :noh<CR><esc>

" shortcuts to cycle through buffers
nnoremap <leader><Tab> :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>

" shortcut to edit/reload vimrc
nmap <silent> <leader>ev :e $VIMRC<CR>
nmap <silent> <leader>sv :so $VIMRC<CR>

" shortcut to delete a buffer without closing the split
nnoremap <leader>d :bp\|bd #<CR>

if has('nvim')
  " Hack to get C-h working in neovim
  nmap <BS> <C-W>h
endif

" }}}

" -----------------------------------------------------------------------------
" CtrlP {{{
" -----------------------------------------------------------------------------

" ignore node_modules, and git directory
let g:ctrlp_custom_ignore='\v[\/](node_modules|\.git|coverage-output|build|recorded-data)$'

" show hidden files in CtrlP
let g:ctrlp_show_hidden=1

" }}}

" -----------------------------------------------------------------------------
" NERDTree {{{
" -----------------------------------------------------------------------------

let g:NERDTreeShowHidden=1

" }}}

" -----------------------------------------------------------------------------
" Ale {{{
" -----------------------------------------------------------------------------

let g:ale_linters = { 'javascript': ['eslint'] }

" don't lint on file open
let g:ale_lint_on_enter=0

" don't lint on text change
let g:ale_lint_on_text_changed=0

" lint on file save
let g:ale_lint_on_save=1

" run linter right away
let g:ale_lint_delay=0

" populate loclist with linting errors
let g:ale_open_list=1
let g:ale_set_quickfix=0

" update gutter symbols
let g:ale_sign_error = '●'
let g:ale_sign_warning = '⚠'

highlight link ALEErrorSign DiffDelete

" }}}

" -----------------------------------------------------------------------------
" Deoplete {{{
" -----------------------------------------------------------------------------

let g:tern_request_timeout=1

let g:deoplete#enable_at_startup=1

let g:deoplete#enable_smart_case=1

set completeopt-=preview

" }}}

" -----------------------------------------------------------------------------
" Startify {{{
" -----------------------------------------------------------------------------

" remove header
let g:startify_custom_header=[]

" remove 80 character column on startify
autocmd User Startified setlocal colorcolumn=0

" }}}

" -----------------------------------------------------------------------------
" Tsuquyomi {{{
" -----------------------------------------------------------------------------

autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" }}}

" vim:foldmethod=marker:foldlevel=0
