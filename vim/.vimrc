" use vim settings instead of vi (must be first)
set nocompatible

" -----------------------------------------------------------------------------
" Vim-plug Configuration {{{
" -----------------------------------------------------------------------------

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'baskerville/vim-sxhkdrc', { 'for': 'sxhkdrc' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'rust-lang/rust.vim'
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
Plug 'jparise/vim-graphql', { 'for': ['graphql', 'javascript', 'typescript'] }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

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

" reduce the time vim waits to trigger plugins
set updatetime=250

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

" give more space for displaying messages
set cmdheight=2

" highlight current line
set cursorline

" load filetype-specific indent files
filetype plugin indent on

" redraw only when we need to (not during macros)
set lazyredraw

" faster redraws
set ttyfast

" don't highlight matching [{()}]
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
hi VertSplit ctermbg=NONE guibg=NONE

" don't pass messages to |ins-completion-menu|.
set shortmess+=c

" always show the signcolumn
set signcolumn=yes

" horizontal splits are created below current window
set splitbelow

" vertical splits are created to the right of the current window
set splitright

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

" shortcut to add a new line below or above the current line
nnoremap <leader>o mmo<esc>`m
nnoremap <leader>O mmO<esc>`m

" }}}

" -----------------------------------------------------------------------------
" NERDTree {{{
" -----------------------------------------------------------------------------

let g:NERDTreeShowHidden=1

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
" CoC {{{
" -----------------------------------------------------------------------------

let g:coc_global_extensions=[
\  'coc-json',
\  'coc-tsserver',
\  'coc-eslint',
\  'coc-prettier',
\  'coc-vimlsp',
\  'coc-jest',
\]

" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" TODO: doesn't work, fix
" highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" formatting selected code
xmap <leader>= <Plug>(coc-format-selected)
nmap <leader>= <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s)
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" remap keys for applying codeAction to the current line
nmap <leader>ac <Plug>(coc-codeaction)

" apply AutoFix to problem on the current line
nmap <leader>qf <Plug>(coc-fix-current)

" introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" mapping for range selection
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" add command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" add command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" add command to organize imports of the current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" add native statusline support
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" fix jsx and tsx file types
augroup typescriptreact
  au!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript
augroup END

""" coc-jest

" run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

" init jest in current cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')

" }}}

" -----------------------------------------------------------------------------
" FZF {{{
" -----------------------------------------------------------------------------

let g:fzf_command_prefix='Z'

let g:fzf_colors={
\  'fg':      ['fg', 'Normal'],
\  'bg':      ['bg', 'Normal'],
\  'hl':      ['fg', 'Comment'],
\  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\  'hl+':     ['fg', 'Statement'],
\  'info':    ['fg', 'Exception'],
\  'prompt':  ['fg', 'Conditional'],
\  'pointer': ['fg', 'Exception'],
\  'marker':  ['fg', 'Keyword'],
\  'spinner': ['fg', 'Label'],
\  'header':  ['fg', 'Comment'],
\  'gutter':  ['bg', 'Normal']
\}

" muscle memory
nmap <c-p> :ZGFiles<CR>

" fuzzy search files
nmap <leader>f :ZGFiles<CR>
nmap <leader>F :ZFiles<CR>

" fuzzy search lines
nmap <leader>l :ZBLines<CR>
nmap <leader>L :ZLines<CR>

" fuzzy search project
nmap <leader>/ :ZRg<Space>

" hide status line
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" }}}

" -----------------------------------------------------------------------------
" GoYo {{{
" -----------------------------------------------------------------------------

" set default dimensions
let g:goyo_width=100
let g:goyo_height='100%'
let g:goyo_linenr=1

nmap <leader>z :Goyo<CR>

" }}}

" vim:foldmethod=marker:foldlevel=0
