" => Global

set nocompatible
syntax enable
filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=500
set number
set relativenumber
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=4
set ruler
set cmdheight=2
set foldcolumn=1
set signcolumn=yes

" Backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic

set showmatch
set mat=2

" Sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Clipboard
set clipboard=unnamedplus " Use "+y to copy from vim

" Returns to last edit position when opening files | Remember
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set colorcolumn=65
"set colorcolumn=80
set encoding=utf8
set ffs=unix,dos,mac
set t_Co=256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
"set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 80 characters
set lbr
"set textwidth=80
"set textwidth=65

" Linebreak on 500 characters for tex files only
"autocmd FileType tex setlocal tw=65
" Linebreak on 500 characters for md files only
"autocmd FileType markdown setlocal tw=500

set autoindent "Auto indent
set smartindent "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Finding Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Provides tab-completion for all file-related tasks
set path+=**
" Display all matching files when tab complete
set wildmenu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Devicons
Plug 'kyazdani42/nvim-web-devicons'

" LSP config
Plug 'neovim/nvim-lspconfig'

" Pretty symbols for nvim-cmp
Plug 'onsails/lspkind.nvim'

" LSP Autocomplete and requires
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" Snip expansion
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'scrooloose/nerdcommenter' " Comment

Plug 'airblade/vim-gitgutter' " Git gutter status

Plug 'nathanaelkane/vim-indent-guides' " Indentation

"Plug 'w0rp/ale' " Linter

"Plug 'tpope/vim-fugitive' " Git comands on vim :Git

"Plug 'luochen1990/rainbow' " Colorize matching brackets, etc.

Plug 'vim-airline/vim-airline' " Vim status bar
Plug 'vim-airline/vim-airline-themes'

"Plug 'lervag/vimtex' " Latex

"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"Plug 'benmills/vimux'

"Plug 'greghor/vim-pyShell'

"Plug 'julienr/vim-cellmode'

"Plug 'tpope/vim-endwise'

"Plug 'tmsvg/pear-tree'

Plug 'NLKNguyen/papercolor-theme'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set completeopt=menu,menuone,noselect

" Switch between light and dark theme based on time of day
if strftime('%H') < 19 && strftime('%H') > 05
    echo "Light"
    set background=light
    " colorscheme PaperColor
else
    echo "Dark"
    set background=dark
    " colorscheme PaperColor
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Paper Color Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:PaperColor_Theme_Options = {
\   'language': {
\       'python': {
\           'highlight_builtins' : 1
\       },
\       'cpp': {
\           'highlight_standard_library': 1
\       },
\       'c': {
\           'highlight_builtins' : 1
\       }
\ }
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1

if strftime('%H') < 19 && strftime('%H') > 05
    let g:rainbow_conf = {
                \ 'ctermfgs': ['Brown', 'Magenta', 'DarkBlue', 'DarkGreen', 'Green', 'DarkRed', 'Blue'],
                \ 'operators': '_+\|-\|*\|\/\|==\|!=\|>\|<\|!_',
                \ }
else
    let g:rainbow_conf = {
                \ 'operators': '_+\|-\|*\|\/\|==\|!=\|>\|<\|!_',
                \ }
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Default: <leader>c<space> NERDCommenterToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Indent Guide
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=240
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_extensions = []
let g:airline_theme='papercolor'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimtex :h vimtex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimtex_enabled=1
let g:vimtex_complete_enabled=1
let g:vimtex_complete_close_braces=1

" \ > CTRL + X > CTL + O Complete Cite/Ref

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim GitGutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Update time between checks
set updatetime=300
let g:gitgutter_sign_added = '█'
let g:gitgutter_sign_modified = '█'
let g:gitgutter_sign_removed = '█'

"highlight GitGutterAdd ctermfg=green
"highlight GitGutterChange ctermfg=yellow
"highlight GitGutterDelete ctermfg=red

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto open preview on file open
let g:mkdp_auto_start = 0

" Show preview URL on terminal
let g:mkdp_echo_preview_url = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim + Conda
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_host_prog=expand('/home/leite/miniconda3/envs/phd/bin/python')
let g:python3_host_prog=expand('/home/leite/miniconda3/envs/phd/bin/python')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell Error
highlight SpellBad ctermfg=13

" ColorColumn
highlight ColorColumn ctermbg=8 ctermfg=white

" Search
hi Search ctermbg=cyan
hi Search ctermfg=black

" Vimdiff colors
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=13 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=13 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=13 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

highlight DiagnosticError cterm=bold ctermfg=13
"highlight DiagnosticWarning cterm=bold ctermfg=10

" Matching Parenteses
highlight MatchParen cterm=bold ctermfg=10 ctermbg=black

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" Spell Check
" z= to cycle between suggestions
nnoremap <leader>ss :setlocal spell! spelllang=en_us<cr>

" Save
nmap <leader>w :w!<cr>

" Buffer Navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Buffer
"nnoremap <leader>bf :ls<cr>:b<Space>
"nnoremap <leader>bb :b#
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>
nnoremap <leader>bq :bd<cr>

" Exit INSERT mode into NORMAL mode
inoremap ji <Esc>

" Copy & Paste
noremap <leader>y "+y
noremap <leader>p "+p

" Load the leite.lua file, careful to name it uniquely
lua require("leite")

" Mapping
" Use CTL + V to open selection on a new vertical buffer
nnoremap <C-_> <cmd>lua require('leite').find_in_buffer() <cr>
" This is a normal call
nnoremap <leader>ff :Telescope find_files <cr>
