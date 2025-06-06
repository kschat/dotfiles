" -----------------------------------------------------------------------------
" Vim-plug Configuration {{{
" -----------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Libraries
Plug 'nvim-lua/plenary.nvim'
Plug 'kevinhwang91/promise-async'
Plug 'nvim-neotest/nvim-nio'

" UI
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'mbbill/undotree'
Plug 'goolord/alpha-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'moll/vim-bbye'
Plug 'tiagovla/scope.nvim'

" Folding
Plug 'luukvbaal/statuscol.nvim'
Plug 'kevinhwang91/nvim-ufo'

" Debugging
Plug 'nvim-neotest/nvim-nio'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'microsoft/vscode-js-debug', { 'do': 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out' }
Plug 'mxsdev/nvim-dap-vscode-js'

" Test runner
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-jest'

" Tmux
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

" Utility
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'nat-418/boole.nvim'
Plug 'sindrets/diffview.nvim'

" Language
Plug 'OXY2DEV/markview.nvim'

" Misc
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sainnhe/gruvbox-material'

Plug 'OXY2DEV/markview.nvim'

call plug#end()

" }}}

hi! InverseGroup gui=reverse cterm=reverse

lua << EOF
local presets = require('markview.presets');

require'markview'.setup({
  checkboxes = presets.checkboxes.nerd,
  markdown = {
    horizontal_rules = presets.horizontal_rules.thick,
    headings = presets.headings.marker,
    headings = {
      enable = true,
      shift_width = 0,
      textoff = 7,

      heading_1 = {
        style = 'icon',
        sign = '',
        sign_hl = 'MarkviewHeading1Sign',

        icon = '█ ',
        icon_hl = 'MarkviewHeading1Sign',
        hl = 'MarkviewHeading1',
      },
      heading_2 = {
        style = 'icon',
        sign = '',
        sign_hl = 'MarkviewHeading2Sign',

        icon = '█ ',
        icon_hl = 'MarkviewHeading2Sign',
        hl = 'MarkviewHeading2',
      },
      heading_3 = {
        style = 'icon',

        icon = '█ ',
        icon_hl = 'MarkviewHeading3Sign',
        hl = 'MarkviewHeading3',
      },
      heading_4 = {
        style = 'icon',

        icon = '█ ',
        icon_hl = 'MarkviewHeading4Sign',
        hl = 'MarkviewHeading4',
      },
      heading_5 = {
        style = 'icon',

        icon = '█ ',
        icon_hl = 'MarkviewHeading5Sign',
        hl = 'MarkviewHeading5',
      },
      heading_6 = {
        style = 'icon',

        icon = '█ ',
        icon_hl = 'MarkviewHeading5Sign',
        hl = 'MarkviewHeading6',
      }
    },
  },
});
EOF

" -----------------------------------------------------------------------------
" General {{{
" -----------------------------------------------------------------------------

" disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" change map leader from \ to , and set local leader to \
let mapleader=","
let maplocalleader="\\"

" reload files when changed outside of vim
set autoread
augroup ReloadFiles
  autocmd!
  autocmd FocusGained,BufEnter * if mode() != 'c' | checktime
augroup end

" highlight text on yank
augroup YankGroup
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
set mouse=nvi

" reduce the time vim waits to trigger plugins
set updatetime=250

set nospell
set spellsuggest=best,5

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

set background=dark
colorscheme gruvbox-material

let s:gruvbox_config = gruvbox_material#get_configuration()
let g:palette = gruvbox_material#get_palette(s:gruvbox_config.background, s:gruvbox_config.foreground, s:gruvbox_config.colors_override)
let s:palette = g:palette

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "rust",
    "lua",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "json",
    "jsonc",
    "toml",
    "dockerfile",
    "bash"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

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
augroup RemoveWhitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup end

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

" indent line breaks at the same level as the previous line
set breakindent

" turn list off as it disables linebreak
set nolist

" encoding can only be set on startup
if has('vim_starting')
  set encoding=utf-8
endif

set fileencoding=utf-8

" string to put before wrapped screen lines
let &showbreak='↪ '

" }}}

" -----------------------------------------------------------------------------
" UI configuration {{{
" -----------------------------------------------------------------------------

" show line number relative to the cursor
set relativenumber

" show line current line number in front of the cursor
set number

" show command in bottom bar
set showcmd

" give more space for displaying messages
set cmdheight=1

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

" remove color column
set colorcolumn=

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
" Key mappings {{{
" -----------------------------------------------------------------------------

" '/<esc>' to clear search highlighting, '/' for new search
nnoremap <nowait> / :noh<CR>/

" '<leader>/<esc>' to clear search term, '<leader>/' for new search
nnoremap <nowait> <leader>/ :let @/=""<CR>/

" shortcuts to cycle through buffers
nnoremap <silent> <leader><Tab> :bnext<CR>
nnoremap <silent> <leader><S-Tab> :bprevious<CR>

" shortcut to edit/reload vimrc
nmap <silent> <leader>ev :vsplit $VIMRC<CR>
nmap <silent> <leader>sv :so $VIMRC \| echo "Reloaded vimrc"<CR>

" shortcut to delete a buffer without closing the split
nnoremap <silent> <leader>bd :Bdelete<CR>

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

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" no more ex-mode
nnoremap <silent> Q <nop>

" make script executable
nnoremap <leader>x <cmd>silent !chmod +x %<CR>

" }}}

" -----------------------------------------------------------------------------
" Utilities {{{
" -----------------------------------------------------------------------------

function! Highlight(group, ...)
  execute 'highlight' a:group
        \ 'guifg=' . (a:0 >= 1 ? a:1[0] : 'NONE')
        \ 'guibg=' . (a:0 >= 2 ? a:2[0] : 'NONE')
        \ 'ctermfg=' . (a:0 >= 1 ? a:1[1] : 'NONE')
        \ 'ctermbg=' . (a:0 >= 2 ? a:2[1] : 'NONE')
        \ 'gui=' . (a:0 >= 3 ? a:3 : 'NONE')
        \ 'cterm=' . (a:0 >= 3 ? a:3 : 'NONE')
        \ 'guisp=' . (a:0 >= 4 ? a:4[0] : 'NONE')
endfunction

" }}}

" -----------------------------------------------------------------------------
" Notes {{{
" -----------------------------------------------------------------------------

function! Notes(note_scope, ...)
  let l:note_type = a:0 >= 1 ? ' ' .. a:1 : ''
  let l:result = trim(system('notes ' .. a:note_scope .. l:note_type))
  if v:shell_error
    throw 'Failed to get note path: ' . l:result
  endif

  execute 'e ' l:result
endfunction

command! -nargs=1 NotesWork call Notes('work', <f-args>)
command! -nargs=1 NotesPersonal call Notes('personal', <f-args>)

nnoremap <silent> <leader>nwt :NotesWork today<CR>
nnoremap <silent> <leader>nwy :NotesWork yesterday<CR>
nnoremap <silent> <leader>nwT :NotesWork todo<CR>

nnoremap <silent> <leader>npt :NotesPersonal today<CR>
nnoremap <silent> <leader>npy :NotesPersonal yesterday<CR>
nnoremap <silent> <leader>npT :NotesPersonal todo<CR>

" }}}

" -----------------------------------------------------------------------------
" Debugger {{{
" -----------------------------------------------------------------------------

nnoremap <silent> <leader>db <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB <cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dlp <cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr <cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>di <cmd>lua require'dapui'.toggle()<CR>
nnoremap <silent> <leader>dk <cmd>lua require'dap'.terminate()<CR>

nnoremap <silent> <leader>dsc <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dsi <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dso <cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>dsv <cmd>lua require'dap'.step_over()<CR>

nnoremap <silent> <leader>de <cmd>lua require'dapui'.eval()<CR>

call Highlight('DapBreakpoint', s:palette.red)
call Highlight('DapLogPoint', s:palette.blue)
call Highlight('DapStopped', s:palette.yellow)
call Highlight('DapStoppedLine', s:palette.none, s:palette.bg_visual_yellow)

call Highlight('DapUIPlayPause', s:palette.aqua)
call Highlight('DapUIRestart', s:palette.green)
call Highlight('DapUIStop', s:palette.red)
call Highlight('DapUIStepOver', s:palette.aqua)
call Highlight('DapUIStepInto', s:palette.aqua)
call Highlight('DapUIStepOut', s:palette.aqua)
call Highlight('DapUIStepBack', s:palette.aqua)

augroup NvimDap
  autocmd!
  " REPL auto complete
  autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup end

lua << EOF
local dap, dapui = require("dap"), require("dapui")
require'nvim-dap-virtual-text'.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require('dap.ext.vscode').load_launchjs(nil, {
  ['pwa-node'] = { 'typescript', 'javascript' },
  ['node'] = { 'typescript', 'javascript' },
})

dapui.setup({
  force_buffers = true,
  icons = {
    collapsed = '',
    expanded = '',
    current_frame = '',
  },
  controls = {
    enabled = true,
  },
  layouts = {
    {
      position = 'left',
      size = 40,
      elements = {
        {
          id = 'scopes',
          size = 0.25,
        },
        {
          id = 'watches',
          size = 0.25,
        },
        {
          id = 'stacks',
          size = 0.25,
        },
        {
          id = 'breakpoints',
          size = 0.25,
        },
      },
    },
    {
      position = 'bottom',
      size = 10,
      elements = {
        {
          id = 'repl',
          size = 0.5,
        },
        {
          id = 'console',
          size = 0.5,
        },
      },
    },
  },
})

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStoppedLine' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint' })

local dap = require'dap'

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb',
}

local lldb = {
  name = 'Launch lldb',
  type = 'lldb',
  request = 'launch',
  program = function()
    return vim.fn.input(
      'Path to executable: ',
      vim.fn.getcwd() .. '/',
      'file'
    )
  end,
  cwd = '${workspaceFolder}',
  stopOnEntry = false,
  showDisassembly = 'never',
}

dap.configurations.rust = {
  lldb,
}

require("dap-vscode-js").setup({
  debugger_path = vim.env.HOME .. "/.vim/plugged/vscode-js-debug",
  -- debugger_cmd = { "js-debug-adapter" },
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch project',
      program = '${workspaceFolder}/dist/index.js',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      -- outFiles = { '${workspaceFolder}/dist/**/*.js' },
      skipFiles = { '<node_internals>/**' },
      resolveSourceMapLocations = { "${workspaceFolder}/dist/**/*.js", "${workspaceFolder}/**", "!**/node_modules/**" }
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require'dap.utils'.pick_process,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      trace = true,
      -- outFiles = { '${workspaceFolder}/dist/**/*.js' },
      skipFiles = { '<node_internals>/**' },
      -- resolveSourceMapLocations = { "${workspaceFolder}/dist/**/*.js", "${workspaceFolder}/**" },
      -- localRoot = vim.fn.getcwd(),
    }
  }
end
EOF

" }}}

" -----------------------------------------------------------------------------
" Neotest {{{
" -----------------------------------------------------------------------------

lua << EOF
require('neotest').setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = 'npm test -- ',
    }),
  },
  status = {
    signs = false,
    virtual_text = true,
  },
})
EOF

" run tests for current file
nnoremap <silent> <leader>tE <cmd>lua require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' })<CR>

" run current test
nnoremap <silent> <leader>te <cmd>lua require('neotest').run.run({ strategy = 'dap' })<CR>

" }}}

" -----------------------------------------------------------------------------
" Folding - UFO {{{
" -----------------------------------------------------------------------------

set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
set foldenable

function! SetFoldColumn()
  set fillchars=eob:\ ,fold:\ ,foldopen:,foldsep:\ ,foldclose:
endfunction

lua << EOF

vim.fn['SetFoldColumn']()

local builtin = require('statuscol.builtin')

require('statuscol').setup({
  relculright = true,
  segments = {
    { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
    -- TODO figure out why this isn't using default line number highlight groups
    { text = { builtin.lnumfunc, '' }, click = 'v:lua.ScLa' },
    { text = { '%s' }, click = 'v:lua.ScSa' },
  },
})

require('ufo').setup()
EOF

" }}}

" -----------------------------------------------------------------------------
" Indent Blanklines {{{
" -----------------------------------------------------------------------------

lua << EOF
require("ibl").setup({
  indent = { char = '│' },
  scope = { show_start = false, show_end = false, },
})
EOF

" }}}

" -----------------------------------------------------------------------------
" Nvim Tree {{{
" -----------------------------------------------------------------------------

lua << EOF
local api = require('nvim-tree.api')
local Event = api.events.Event

local function nvim_tree_on_attach(bufnr)
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<C-t>', api.tree.close, opts('Close'))
end

require'nvim-tree'.setup {
  disable_netrw = true,
  on_attach = nvim_tree_on_attach,
  diagnostics = {
    enable = true,
  },
  renderer = {
    root_folder_label = false,
    group_empty = true,
    highlight_git = true,
    indent_width = 1,
    icons = {
      webdev_colors = true,
      show = {
        folder_arrow = false,
        git = false,
      },
      glyphs = {
        folder = {
          empty = '',
          empty_open = '',
          open = '',
          symlink_open = '',
        },
      },
    },
  },
  filters = {
    git_ignored = false,
    custom = {
      '^.git$',
    },
  },
}

api.events.subscribe(Event.TreeOpen, function()
  vim.g.tab_line_offset = vim.api.nvim_win_get_width(api.tree.winid())
end)

api.events.subscribe(Event.TreeClose, function()
  vim.g.tab_line_offset = 0
end)

api.events.subscribe(Event.Resize, function(width)
  vim.g.tab_line_offset = width
end)
EOF

" hide cursor in Nvim Tree
function! s:nvim_tree_enter()
  highlight! Cursor blend=100
  set guicursor=n:Cursor/lCursor,
    \v-c-sm:block,
    \i-ci-ve:ver25,
    \r-cr-o:hor2
endfunction

" reshow cursor when leaving Nvim Tree
function! s:nvim_tree_leave()
  highlight! Cursor blend=NONE
  set guicursor=n-v-c-sm:block,
    \i-ci-ve:ver25,
    \r-cr-o:hor20
endfunction

augroup NvimTreeEnter
  autocmd!
  autocmd WinEnter,BufWinEnter NvimTree_* call s:nvim_tree_enter()
augroup END

augroup NvimTreeLeave
  autocmd!
  autocmd WinClosed,BufLeave NvimTree_* call s:nvim_tree_leave()
augroup END

call Highlight('NvimTreeNormal', s:palette.fg0, s:palette.bg1)
call Highlight('NvimTreeEndOfBuffer', s:palette.bg0, s:palette.bg1)
call Highlight('NvimTreeCursorLine', ['NONE', 'NONE'], s:palette.bg3)
call Highlight('NvimTreeFolderName', s:palette.fg0)
call Highlight('NvimTreeEmptyFolderName', s:palette.fg0)
call Highlight('NvimTreeOpenedFolderName', s:palette.fg0)
call Highlight('NvimTreeFolderIcon', s:palette.yellow)
call Highlight('NvimTreeWinSeparator', s:palette.bg0)

" toggle Nvim Tree
nnoremap <C-t> :NvimTreeToggle<CR>

" }}}

" -----------------------------------------------------------------------------
" Alpha {{{
" -----------------------------------------------------------------------------

lua << EOF
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

-- Set header
dashboard.section.header.val = {
    '                                                     ',
    '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
    '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
    '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
    '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
    '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
    '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
    '                                                     ',
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
EOF

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
\  'coc-rust-analyzer',
\  '@yaegassy/coc-marksman',
\  'coc-biome',
\]

let g:coc_status_error_sign=' '
let g:coc_status_warning_sign=' '

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <silent><expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

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
nmap <silent> <leader>rn <Plug>(coc-rename)

" formatting selected code
xmap <silent> <leader>= <Plug>(coc-format-selected)
nmap <silent> <leader>= <Plug>(coc-format-selected)

augroup fileTypeGroup
  autocmd!
  " setup formatexpr specified filetype(s)
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" remap keys for applying codeAction to the current line
nmap <silent> <leader>ac <Plug>(coc-codeaction-cursor)

" apply source code action for the current line
nmap <silent> <leader>as <Plug>(coc-codeaction-source)

" apply AutoFix to problem on the current line
nmap <silent> <leader>qf <Plug>(coc-fix-current)

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

" add command to organize imports of the current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" fix jsx and tsx file types
augroup typescriptreact
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript
augroup END

" }}}

" -----------------------------------------------------------------------------
" Telescope {{{
" -----------------------------------------------------------------------------

lua << EOF
local telescope = require('telescope')

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden'
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    multi_icon = ' ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    set_env = { ['COLORTERM'] = 'truecolor' },
  },
})

telescope.load_extension('live_grep_args')
telescope.load_extension('fzf')
EOF

call Highlight("TelescopeBorder", s:palette.bg_statusline1, s:palette.bg_statusline1)
call Highlight("TelescopePromptBorder", s:palette.bg3, s:palette.bg3)

call Highlight("TelescopePromptNormal", s:palette.fg0, s:palette.bg3)
call Highlight("TelescopePromptPrefix", s:palette.red, s:palette.bg3)
call Highlight("TelescopePromptCounter", s:palette.fg0, s:palette.bg3)

call Highlight("TelescopeNormal", s:palette.none, s:palette.bg_statusline1)

call Highlight("TelescopePreviewTitle", s:palette.bg0, s:palette.green)
call Highlight("TelescopePromptTitle", s:palette.bg0, s:palette.red)
call Highlight("TelescopeResultsTitle", s:palette.bg_statusline1, s:palette.bg_statusline1)

call Highlight("TelescopeSelection", s:palette.fg0, s:palette.bg3)

" muscle memory
nmap <silent> <c-p> <cmd>:lua require('telescope.builtin').find_files { find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' } }<CR>

" search all files
nmap <silent> <leader>ff <cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>

" search word under cursor in all files
nmap <silent> <leader>fc <cmd>:lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>

" search buffers
nmap <silent> <leader>fb <cmd>Telescope buffers<CR>

" }}}

" -----------------------------------------------------------------------------
" Zen Mode {{{
" -----------------------------------------------------------------------------

lua << EOF
require('zen-mode').setup {
  window = {
    backdrop = 1,
    width = 140,
  },

  on_open = function(win)
    -- Fix fold column style
    -- https://github.com/folke/zen-mode.nvim/issues/55
    vim.fn['SetFoldColumn']()
  end,
}
EOF

nmap <silent> <leader>z :ZenMode<CR>

" }}}

" -----------------------------------------------------------------------------
" GitGutter {{{
" -----------------------------------------------------------------------------

let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'
let g:gitgutter_sign_modified_removed = '┃'
let g:gitgutter_sign_removed_above_and_below = '┃'

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

call Highlight('StatusNormalMode', s:palette.bg0, s:palette.aqua, 'bold')
call Highlight('StatusNormalModeBorderLeft', s:palette.aqua, s:palette.bg0)
call Highlight('StatusNormalModeBorderRight', s:palette.aqua, s:palette.fg0)

call Highlight('StatusInsertMode', s:palette.bg0, s:palette.blue, 'bold')
call Highlight('StatusInsertModeBorderLeft', s:palette.blue, s:palette.bg0)
call Highlight('StatusInsertModeBorderRight', s:palette.blue, s:palette.fg0)

call Highlight('StatusVisualMode', s:palette.bg0, s:palette.yellow, 'bold')
call Highlight('StatusVisualModeBorderLeft', s:palette.yellow, s:palette.bg0)
call Highlight('StatusVisualModeBorderRight', s:palette.yellow, s:palette.fg0)

call Highlight('StatusReplaceMode', s:palette.bg0, s:palette.red, 'bold')
call Highlight('StatusReplaceModeBorderLeft', s:palette.red, s:palette.bg0)
call Highlight('StatusReplaceModeBorderRight', s:palette.red, s:palette.fg0)

call Highlight('StatusTerminalMode', s:palette.bg0, s:palette.purple, 'bold')
call Highlight('StatusTerminalModeBorderLeft', s:palette.purple, s:palette.bg0)
call Highlight('StatusTerminalModeBorderRight', s:palette.purple, s:palette.fg0)

call Highlight('StatusCommandMode', s:palette.bg0, s:palette.grey2, 'bold')
call Highlight('StatusCommandModeBorderLeft', s:palette.grey2, s:palette.bg0)
call Highlight('StatusCommandModeBorderRight', s:palette.grey2, s:palette.fg0)

call Highlight('StatusSelectMode', s:palette.bg0, s:palette.grey2, 'bold')
call Highlight('StatusSelectModeBorderLeft', s:palette.grey2, s:palette.bg0)
call Highlight('StatusSelectModeBorderRight', s:palette.grey2, s:palette.fg0)

call Highlight('StatusFileName', s:palette.bg0, s:palette.fg0)
call Highlight('StatusFileNameBorderLeft', s:palette.fg0, s:palette.bg0)
call Highlight('StatusFileNameBorderRight', s:palette.fg0, s:palette.bg3)

call Highlight('StatusCoc', s:palette.fg0, s:palette.bg3)
call Highlight('StatusCocBorder', s:palette.bg3, s:palette.none)

call Highlight('StatusLineBackground', s:palette.fg0, s:palette.none)

call Highlight('StatusFileLine', s:palette.bg0, s:palette.aqua)
call Highlight('StatusFileLineBorderRight', s:palette.aqua, s:palette.bg0)
call Highlight('StatusFileLineBorderLeft', s:palette.aqua, s:palette.bg0)

call Highlight('StatusGitBranch', s:palette.bg0, s:palette.fg0)
call Highlight('StatusGitBranchBorderRight', s:palette.fg0, s:palette.bg0)
call Highlight('StatusGitBranchBorderLeft', s:palette.fg0, s:palette.bg0)

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
      call Highlight('StatusFileNameBorderRight', s:palette.fg0, s:palette.none)
    endif

    return ''
  endif

  if !b:coc_status_on || b:coc_status_on == -1
    let b:coc_status_on = 1
    call Highlight('StatusFileNameBorderRight', s:palette.fg0, s:palette.bg3)
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
    call Highlight('StatusFileLineBorderLeft', s:palette.aqua, s:palette.bg0)
    return ''
  endif

  " set background of previous node to white
  call Highlight('StatusFileLineBorderLeft', s:palette.aqua, s:palette.fg0)

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

augroup FzfStatusLine
  autocmd!
  autocmd User FzfStatusLine call <SID>fzf_statusline()
augroup end

" redraw CoC status on update
augroup CocStatusLine
  autocmd!
  autocmd User CocStatusChange redrawstatus
augroup end

" }}}

" -----------------------------------------------------------------------------
" TabLine {{{
" -----------------------------------------------------------------------------

" always show tabline
set showtabline=2

" offset used for when the file explorer is open
let g:tab_line_offset = 0

" padding applied between the tab bar and file explorer (when it's open)
let g:tab_line_offset_padding = 1

" Scope buffers to tabs
lua require('scope').setup({})

call Highlight('TabLineFill', s:palette.bg0, s:palette.none)
call Highlight('TabLinePadding', s:palette.bg0, s:palette.bg1)

call Highlight('BufferTabLineSel', s:palette.bg0, s:palette.fg0, 'bold')
call Highlight('BufferTabLineSelBorder', s:palette.fg0, s:palette.none)

call Highlight('BufferTabLine', s:palette.fg0, s:palette.bg_current_word)
call Highlight('BufferTabLineBorder', s:palette.bg_current_word, s:palette.none)

call Highlight('BufferTabLineIcon', s:palette.bg0, s:palette.aqua, 'bold')
call Highlight('BufferTabLineIconBorderLeft', s:palette.aqua, s:palette.bg0)
call Highlight('BufferTabLineIconBorderRight', s:palette.aqua, s:palette.none)

call Highlight('TabLineSel', s:palette.bg0, s:palette.fg0, 'bold')
call Highlight('TabLineSelBorderLeft', s:palette.fg0, s:palette.bg_current_word)
call Highlight('TabLineSelBorderRight', s:palette.fg0, s:palette.none)

call Highlight('TabLine', s:palette.fg0, s:palette.bg_current_word)
call Highlight('TabLineBorder', s:palette.bg_current_word, s:palette.bg_current_word)

call Highlight('TabLineIcon', s:palette.bg0, s:palette.aqua, 'bold')
call Highlight('TabLineIconBorderLeft', s:palette.aqua, s:palette.bg0)
call Highlight('TabLineIconBorderRight', s:palette.aqua, s:palette.none)

call Highlight('BufferTabLineIcon', s:palette.bg0, s:palette.aqua, 'bold')
call Highlight('BufferTabLineIconBorderLeft', s:palette.aqua, s:palette.bg0)
call Highlight('BufferTabLineIconBorderRight', s:palette.aqua, s:palette.none)

call Highlight('TabLineBorderLast', s:palette.bg_current_word, s:palette.none)

function! TabLine()
  return TabLinePadding() .. Buffers() .. '%=' .. Tabs()
endfunction

function! TabLinePadding()
  if g:tab_line_offset == 0
    return ''
  endif

  return '%#TabLinePadding#' .. repeat(' ', g:tab_line_offset) .. '%#TabLineFill#' .. repeat(' ', g:tab_line_offset_padding)
endfunction

function! Buffers()
  let l:s = '%#BufferTabLineIconBorderLeft#%#BufferTabLineIcon#   %#BufferTabLineIconBorderRight# '
  for i in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let l:selected = i == bufnr()
    if l:selected
      let l:s ..= '%#BufferTabLineSelBorder#%#BufferTabLineSel#  '
    else
      let l:s ..= '%#BufferTabLineBorder#%#BufferTabLine#  '
    endif

    let l:s ..= '%' .. i .. '@BufTabClick@ %{BuffLabel(' .. i .. ')} '

    if l:selected
      let l:s ..= ' %#BufferTabLineSelBorder# '
    else
      let l:s ..= ' %#BufferTabLineBorder# '
    endif
  endfor

  return '%#TabLineFill#%T' .. l:s
endfunction

function! Tabs()
  let l:s = '%#TabLineBorderLast#'
  let l:selected_index = -1
  let l:total_tabs = tabpagenr('$')

  for i in range(1, l:total_tabs)
    let l:selected = i == tabpagenr()

    let l:s ..= '%' .. i .. 'T'
    if l:selected
      let l:selected_index = i
      let l:s ..= '%#TabLineSelBorderLeft#%#TabLineSel# '
    else
      let l:s ..= '%#TabLineBorder#%#TabLine# '
    endif

    let l:s ..= i

    if l:selected
      let l:s ..= ' %#TabLineSelBorderRight#'
    else
      let l:s ..= ' %#TabLineBorder#'
    endif

    let l:s ..= '%T'
  endfor

  if l:selected_index == l:total_tabs
    call Highlight('TabLineIconBorderLeft', s:palette.aqua, s:palette.fg0)

    call Highlight('TabLineSelBorderRight', s:palette.fg0, s:palette.fg0)
    call Highlight('TabLineSelBorderLeft', s:palette.fg0, s:palette.bg_current_word)
  else
    call Highlight('TabLineIconBorderLeft', s:palette.aqua, s:palette.bg_current_word)
    call Highlight('TabLineSelBorderRight', s:palette.fg0, s:palette.bg_current_word)
  endif

  let l:s ..= '%999X%#TabLineIconBorderLeft#% %#TabLineIcon#  %#TabLineIconBorderRight#%X'
  let l:s ..= '%#TabLineFill#%T'

  return l:s
endfunction

function! BuffLabel(n)
  let l:max_length = 25
  let l:name = trim(fnamemodify(bufname(a:n), ':t'))
  if l:name == ''
    return 'NO NAME'
  endif

  return len(l:name) >= l:max_length ? strpart(l:name, 0, l:max_length) .. '…' : l:name
endfunction

function! TabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  let l:name = trim(fnamemodify(bufname(l:buflist[l:winnr - 1]), ':t'))

  return l:name == '' ? 'NO NAME' : l:name
endfunction

function! BufTabClick(minwid, clicks, btn, modifiers) abort
  if a:btn == 'l'
    execute 'buffer ' . a:minwid
  elseif a:btn == 'r'
    execute 'Bdelete ' . a:minwid
    execute 'redrawt'
  endif
endfunction

set tabline=%!TabLine()

" }}}

" vim:foldmethod=marker:foldlevel=1
