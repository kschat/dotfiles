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

" UI
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

" Utility
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Language
Plug 'sheerun/vim-polyglot'

" Misc
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sainnhe/gruvbox-material'

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

" highlight text on yank
augroup yankgroup
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { timeout = 1000 }
augroup end

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

if (has("termguicolors"))
  set termguicolors
endif

" turn syntax highlighting on
syntax enable

let g:gruvbox_material_background='medium'
let g:gruvbox_material_enable_bold='1'
let g:gruvbox_material_diagnostic_line_highlight='1'
let g:gruvbox_material_sign_column_background='none'
let g:gruvbox_material_disable_terminal_colors='1'
let g:gruvbox_material_show_eob='0'
let g:gruvbox_material_menu_selection_background='aqua'

" iterm2 doesn't support setting a semibold italic font
if (has("mac"))
  let g:gruvbox_material_disable_italic_comment='1'
endif

set background=dark
colorscheme gruvbox-material

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

" adds 120 character vertical line
set colorcolumn=120

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

" don't display '-- MODE --' text as it's displayed in statusline
set noshowmode

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

" live update buffer as a substitute is being entered
set inccommand=nosplit

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
nnoremap <silent> <leader><space> :noh<CR><esc>

" shortcuts to cycle through buffers
nnoremap <leader><Tab> :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>

" shortcut to edit/reload vimrc
nmap <silent> <leader>ev :e $VIMRC<CR>
nmap <silent> <leader>sv :so $VIMRC \| echo "Reloaded vimrc"<CR>

" shortcut to delete a buffer without closing the split
nnoremap <silent> <leader>d :bp\|bd #<CR>

if has('nvim')
  " Hack to get C-h working in neovim
  nmap <BS> <C-W>h
endif

" add a new line below or above the current line
nnoremap <silent> ]<space> @="m`o\eg``"<CR>
nnoremap <silent> [<space> @="m`O\eg``"<CR>

" move the current line up/down N lines
nnoremap <silent> ]e :<C-U>exec "exec 'norm m`' \| move +" . (0+v:count1)<CR>``
nnoremap <silent> [e :<C-U>exec "exec 'norm m`' \| move -" . (1+v:count1)<CR>``

" move the current selection up/down N lines
vnoremap <silent> ]e :<C-U>exec "'<,'>move '>+" . (0+v:count1)<CR>gv
vnoremap <silent> [e :<C-U>exec "'<,'>move '<-" . (1+v:count1)<CR>gv

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

let g:coc_config_home='~/.vim'

let g:coc_global_extensions=[
\  'coc-json',
\  'coc-tsserver',
\  'coc-eslint',
\  'coc-prettier',
\  'coc-vimlsp',
\  'coc-jest',
\  'coc-rust-analyzer',
\]

let g:coc_status_error_sign=' '
let g:coc_status_warning_sign=' '

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto code navigation

nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> <C-W>gd :call CocAction('jumpDefinition', 'split')<CR>
nnoremap <silent> <C-W>gD :call CocAction('jumpDefinition', 'vsplit')<CR>

nmap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> <C-W>gy :call CocAction('jumpTypeDefinition', 'split')<CR>
nnoremap <silent> <C-W>gY :call CocAction('jumpTypeDefinition', 'vsplit')<CR>

nmap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> <C-W>gi :call CocAction('jumpImplementation', 'split')<CR>
nnoremap <silent> <C-W>gI :call CocAction('jumpImplementation', 'vsplit')<CR>

nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <C-W>gr :call CocAction('jumpReferences', 'split')<CR>
nnoremap <silent> <C-W>gR :call CocAction('jumpReferences', 'vsplit')<CR>

" mapping to jump to floating window
nmap <silent> <C-w>k <Plug>(coc-float-jump)

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" formatting selected code
xmap <leader>= <Plug>(coc-format-selected)
nmap <leader>= <Plug>(coc-format-selected)

augroup fileTypeGroup
  autocmd!
  " setup formatexpr specified filetype(s)
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" remap keys for applying codeAction to the current line
nmap <leader>ac <Plug>(coc-codeaction-cursor)

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
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" fix jsx and tsx file types
augroup typescriptreact
  au!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript
augroup END

""" coc-jest

" run jest for current project
command! -nargs=0 Jest :call CocAction('runCommand', 'jest.projectTest')

" run jest for current file
command! -nargs=0 JestCurrent :call CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap <leader>tE :JestCurrent<CR>

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

" -----------------------------------------------------------------------------
" GitGutter {{{
" -----------------------------------------------------------------------------

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_modified_removed = '▎'
let g:gitgutter_sign_removed_above_and_below = '▎'

let g:gitgutter_preview_win_floating = 1
" let g:gitgutter_floating_window_options = {
"         \ 'relative': 'cursor',
"         \ 'row': 1,
"         \ 'col': 0,
"         \ 'width': 42,
"         \ 'height': &previewheight,
"         \ 'style': 'minimal',
"         \ 'border': 'single',
"         \ }

" }}}

" -----------------------------------------------------------------------------
" StatusLine {{{
" -----------------------------------------------------------------------------

" enable global status line
set laststatus=3

function! s:hl(group, fg, bg, ...)
  execute 'highlight' a:group
        \ 'guifg=' . a:fg[0]
        \ 'guibg=' . a:bg[0]
        \ 'ctermfg=' . a:fg[1]
        \ 'ctermbg=' . a:bg[1]
        \ 'gui=' . (a:0 >= 1 ?
          \ a:1 :
          \ 'NONE')
        \ 'cterm=' . (a:0 >= 1 ?
          \ a:1 :
          \ 'NONE')
        \ 'guisp=' . (a:0 >= 2 ?
          \ a:2[0] :
          \ 'NONE')
endfunction

let s:gruvbox_config = gruvbox_material#get_configuration()

let s:palette = gruvbox_material#get_palette(s:gruvbox_config.background, s:gruvbox_config.foreground, s:gruvbox_config.colors_override)

function! s:patch_status_line_colors()
  call s:hl('StatusNormalMode', s:palette.bg0, s:palette.aqua, 'bold')
  call s:hl('StatusNormalModeBorderLeft', s:palette.aqua, s:palette.bg0)
  call s:hl('StatusNormalModeBorderRight', s:palette.aqua, s:palette.fg0)

  call s:hl('StatusInsertMode', s:palette.bg0, s:palette.blue, 'bold')
  call s:hl('StatusInsertModeBorderLeft', s:palette.blue, s:palette.bg0)
  call s:hl('StatusInsertModeBorderRight', s:palette.blue, s:palette.fg0)

  call s:hl('StatusVisualMode', s:palette.bg0, s:palette.yellow, 'bold')
  call s:hl('StatusVisualModeBorderLeft', s:palette.yellow, s:palette.bg0)
  call s:hl('StatusVisualModeBorderRight', s:palette.yellow, s:palette.fg0)

  call s:hl('StatusReplaceMode', s:palette.bg0, s:palette.red, 'bold')
  call s:hl('StatusReplaceModeBorderLeft', s:palette.red, s:palette.bg0)
  call s:hl('StatusReplaceModeBorderRight', s:palette.red, s:palette.fg0)

  call s:hl('StatusTerminalMode', s:palette.bg0, s:palette.purple, 'bold')
  call s:hl('StatusTerminalModeBorderLeft', s:palette.purple, s:palette.bg0)
  call s:hl('StatusTerminalModeBorderRight', s:palette.purple, s:palette.fg0)

  call s:hl('StatusCommandMode', s:palette.bg0, s:palette.grey2, 'bold')
  call s:hl('StatusCommandModeBorderLeft', s:palette.grey2, s:palette.bg0)
  call s:hl('StatusCommandModeBorderRight', s:palette.grey2, s:palette.fg0)

  call s:hl('StatusSelectMode', s:palette.bg0, s:palette.grey2, 'bold')
  call s:hl('StatusSelectModeBorderLeft', s:palette.grey2, s:palette.bg0)
  call s:hl('StatusSelectModeBorderRight', s:palette.grey2, s:palette.fg0)

  call s:hl('StatusFileName', s:palette.bg0, s:palette.fg0)
  call s:hl('StatusFileNameBorderLeft', s:palette.fg0, s:palette.bg0)
  call s:hl('StatusFileNameBorderRight', s:palette.fg0, s:palette.bg3)

  call s:hl('StatusCoc', s:palette.fg0, s:palette.bg3)
  call s:hl('StatusCocBorder', s:palette.bg3, s:palette.none)

  call s:hl('StatusLineBackground', s:palette.fg0, s:palette.none)

  call s:hl('StatusFileLine', s:palette.bg0, s:palette.aqua)
  call s:hl('StatusFileLineBorderRight', s:palette.aqua, s:palette.bg0)
  call s:hl('StatusFileLineBorderLeft', s:palette.aqua, s:palette.bg0)

  call s:hl('StatusGitBranch', s:palette.bg0, s:palette.fg0)
  call s:hl('StatusGitBranchBorderRight', s:palette.fg0, s:palette.bg0)
  call s:hl('StatusGitBranchBorderLeft', s:palette.fg0, s:palette.bg0)
endfunction

call s:patch_status_line_colors()

" patch colors when color scheme is applied so plugins like GoYo reset colors
" correctly
augroup PatchStatusLine
  autocmd!
  autocmd! ColorScheme * call s:patch_status_line_colors()
augroup END

let g:current_mode={
      \ 'n': { 'text': 'NORMAL', 'color_group': 'StatusNormalMode' },
      \ 'i': { 'text': 'INSERT', 'color_group': 'StatusInsertMode' },
      \ 'R': { 'text': 'REPLACE', 'color_group': 'StatusReplaceMode' },
      \ 'v': { 'text': 'VISUAL', 'color_group': 'StatusVisualMode' },
      \ 'V': { 'text': 'V-LINE', 'color_group': 'StatusVisualMode' },
      \ "\<C-v>": { 'text': 'V-BLOCK', 'color_group': 'StatusVisualMode' },
      \ 'c': { 'text': 'COMMAND', 'color_group': 'StatusCommandMode' },
      \ 's': { 'text': 'SELECT', 'color_group': 'StatusSelectMode' },
      \ 'S': { 'text': 'S-LINE', 'color_group': 'StatusSelectMode' },
      \ "\<C-s>": { 'text': 'S-BLOCK', 'color_group': 'StatusSelectMode' },
      \ 't': { 'text': 'TERMINAL', 'color_group': 'StatusTerminalMode' },
      \ }

function! CurrentMode() abort
  let l:mode = mode()
  let l:mode_node = get(g:current_mode, l:mode, g:current_mode['t'])
  let l:border_group = '%#' . l:mode_node.color_group . 'Border'
  let l:left_border = l:border_group . 'Left#'
  let l:right_border = l:border_group . 'Right#'
  let l:value = '%#' . l:mode_node.color_group . '# ' . l:mode_node.text . ' '

  return l:left_border . l:value . l:right_border
endfunction

function! CurrentFile(...) abort
  let l:file_name = get(a:, 1, expand('%f'))
  let l:border_group = '%#StatusFileNameBorder'
  let l:left_border = l:border_group . 'Left#'
  let l:right_border = l:border_group . 'Right#'
  let l:file_label = l:file_name == '' ? 'NO NAME' : l:file_name
  let l:value = '%#StatusFileName#%( %H%W%R%M%) ' . l:file_label . ' '

  return l:left_border . l:value . l:right_border
endfunction

function! CocStatus() abort
  let l:status = coc#status()

  if l:status == ''
    if b:coc_status_on || b:coc_status_on == -1
      let b:coc_status_on = 0
      call s:hl('StatusFileNameBorderRight', s:palette.fg0, s:palette.none)
    endif

    return ''
  endif

  if !b:coc_status_on || b:coc_status_on == -1
    let b:coc_status_on = 1
    call s:hl('StatusFileNameBorderRight', s:palette.fg0, s:palette.bg3)
  endif

  return '%#StatusCoc# ' . l:status . ' %#StatusCocBorder#'
endfunction

function! FileLine() abort
  let l:border_group = '%#StatusFileLineBorder'
  let l:left_border = l:border_group . 'Left#'
  let l:right_border = l:border_group . 'Right#'

  return l:left_border . '%#StatusFileLine#%( %l,%c%V %= %P%) ' . l:right_border
endfunction

function! GitBranch() abort
  let l:current_branch = trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'))
  if l:current_branch == ''
    call s:hl('StatusFileLineBorderLeft', s:palette.aqua, s:palette.bg0)
    return ''
  endif

  " set background of previous node to white
  call s:hl('StatusFileLineBorderLeft', s:palette.aqua, s:palette.fg0)

  let l:border_group = '%#StatusGitBranchBorder'
  let l:left_border = l:border_group . 'Left#'
  let l:right_border = l:border_group . 'Right#'

  return l:left_border . '%#StatusGitBranch# ' . l:current_branch . ' ' . l:right_border
endfunction

" define a buffer local variable to cache the value so we're not constantly
" making system calls
let b:git_branch = GitBranch()
let b:coc_status_on = -1
augroup CacheStatusLineState
  autocmd!
  autocmd BufEnter * let b:git_branch = GitBranch() | let b:coc_status_on = -1
augroup END

set statusline=
set statusline+=%{%CurrentMode()%}
set statusline+=%{%CurrentFile()%}
set statusline+=%{%CocStatus()%}%#StatusLineBackground#
set statusline+=\ %=%{%b:git_branch%}
set statusline+=%{%FileLine()%}

" customize fzf statusline
function! s:fzf_statusline()
  setlocal statusline=%{%CurrentMode()%}
  setlocal statusline+=%{%CurrentFile('FZF')%}%#StatusLineBackground#
  setlocal statusline+=%=%{%FileLine()%}
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}

" -----------------------------------------------------------------------------
" TabLine {{{
" -----------------------------------------------------------------------------

function! s:patch_tab_line_colors()
  call s:hl('TabLineFill', s:palette.bg0, s:palette.none)
  call s:hl('TabLineSel', s:palette.bg0, s:palette.fg0, 'bold')
  call s:hl('TabLineSelBorder', s:palette.fg0, s:palette.none)

  call s:hl('TabLine', s:palette.fg0, s:palette.bg_current_word)
  call s:hl('TabLineBorder', s:palette.bg_current_word, s:palette.none)

  call s:hl('TabLineIcon', s:palette.bg0, s:palette.aqua, 'bold')
  call s:hl('TabLineIconBorderLeft', s:palette.aqua, s:palette.bg0)
  call s:hl('TabLineIconBorderRight', s:palette.aqua, s:palette.none)
endfunction

call s:patch_tab_line_colors()

" patch colors when color scheme is applied so plugins like GoYo reset colors
" correctly
augroup PatchTabLine
  autocmd!
  autocmd ColorScheme * call s:patch_tab_line_colors()
augroup END

function! TabLine()
  let l:s = '%#TabLineIconBorderLeft#% %#TabLineIcon#  %#TabLineIconBorderRight# '
  for i in range(tabpagenr('$'))
    let l:selected = i + 1 == tabpagenr()
    if l:selected
      let l:s ..= '%#TabLineSelBorder#%#TabLineSel#'
    else
      let l:s ..= '%#TabLineBorder#%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let l:s ..= '%' .. (i + 1) .. 'T'

    let l:s ..= ' %{TabLabel(' .. (i + 1) .. ')} '

    if l:selected
      let l:s ..= '%#TabLineSelBorder# '
    else
      let l:s ..= '%#TabLineBorder# '
    endif
  endfor

  let l:s ..= '%#TabLineFill#%T'

  return l:s
endfunction

function! TabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  let l:name = trim(fnamemodify(bufname(l:buflist[l:winnr - 1]), ':t'))

  return l:name == '' ? 'NO NAME' : l:name
endfunction

set tabline=%!TabLine()
set showtabline=2

" }}}

" vim:foldmethod=marker:foldlevel=0
