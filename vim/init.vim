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
set textwidth=65

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
" => Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set completeopt=menu,menuone,noselect

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdcommenter' " Comment

Plug 'airblade/vim-gitgutter' " Git gutter status

Plug 'nathanaelkane/vim-indent-guides' " Indentation

"Plug 'w0rp/ale' " Linter

Plug 'tpope/vim-fugitive' " Git comands on vim :Git

"Plug 'nvim-lua/plenary.nvim'
"Plug 'jose-elias-alvarez/null-ls.nvim'
"Plug 'williamboman/nvim-lsp-installer'

" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Python syntax highlight

"Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete

Plug 'nvim-lua/plenary.nvim' " Lua library

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp' " Auto completion with native lsp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'jose-elias-alvarez/null-ls.nvim' " Other errors inside the LSP

Plug 'luochen1990/rainbow' " Colorize matching brackets, etc.

Plug 'vim-airline/vim-airline' " Vim status bar
Plug 'vim-airline/vim-airline-themes'

Plug 'lervag/vimtex' " Latex

"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"Plug 'benmills/vimux'

"Plug 'greghor/vim-pyShell'

"Plug 'julienr/vim-cellmode'

"Plug 'tpope/vim-endwise'

"Plug 'tmsvg/pear-tree'

Plug 'NLKNguyen/papercolor-theme'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Switch between light and dark theme based on time of day
if strftime('%H') < 19 && strftime('%H') > 05
    echo "Light"
    set background=light
    colorscheme PaperColor
else
    echo "Dark"
    set background=dark
    colorscheme PaperColor
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
" => lsp-config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').pyright.setup{
    capabilities = capabilities,
    on_attach = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
        vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    end,
}



-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  end,
},
mapping = {
  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  ['<C-e>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
},
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'luasnip' }, -- For luasnip users.
}, {
  { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
    }, {
        { name = 'buffer' },
    })
})

-- Vim diagnostic
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = false,
    float = {
        show_header = true,
        source = 'always',
        border = 'rounded',
        },
})

-- null-ls
require('null-ls').setup({
    sources = {
        require("null-ls").builtins.diagnostics.flake8,
        require("null-ls").builtins.diagnostics.pylint,
        --null_ls.builtins.code_actions.gitsigns
    },
})

-- Trying to set auto diagnostic when hover
-- Not working
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--  vim.lsp.diagnostic.on_publish_diagnostics, {
--    virtual_text = false,
--    underline = true,
--    signs = true,
--  }
-- )

-- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
-- vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
    }
)

-- vim.api.nvim_command('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})')
vim.api.nvim_command('autocmd CursorHold * lua vim.diagnostic.open_float()')

local signs = { Error = "🐞", Warn = "⚠️", Hint = "💡", Info = "ℹ️" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pear-Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:pear_tree_repeatable_expand = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Default: <leader>c<space> NERDCommenterToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:airline#extensions#ale#enabled = 1

"let g:deoplete#enable_at_startup = 1

"let g:ale_completion_enabled = 1

" Keeps the gutter always 
"let g:ale_sign_column_always = 1

" Error
"let g:ale_sign_error = '✘'

" Warning
"let g:ale_sign_warning = '!!'

"let g:ale_set_highlights = 0 

"let g:ale_lint_on_save = 1

" let g:ale_echo_cursor = 0

" Clear the BG color that Ale sets
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign

"function! LinterStatus() abort
    "let l:counts = ale#statusline#Count(bufnr(''))

    "let l:all_errors = l:counts.error + l:counts.style_error
    "let l:all_non_errors = l:counts.total - l:all_errors

    "return l:counts.total == 0 ? '' : printf(
    "\   '[%d!! %d✘]  ',
    "\   all_non_errors,
    "\   all_errors
    "\)
"endfunction

"set statusline=%{LinterStatus()}

"let g:ale_echo_msg_error_str = '✘'
"let g:ale_echo_msg_warning_str = '!!'
"let g:ale_echo_msg_format = '%linter%: %s'

"let b:ale_warn_about_trailing_whitespace = 1

"let g:ale_virtualenv_dir_names = []

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => DEOPLETE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GIT GUTTER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:gitgutter_map_keys = 0

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

" Necessary for autocompletion to work, also requires deoplete to work
"call deoplete#custom#var('omni', 'input_patterns', {
      "\ 'tex': g:vimtex#re#deoplete
      "\})

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim GitGutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Update time between checks
set updatetime=300

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
highlight ColorColumn ctermbg=8

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

" Get back to old location
nnoremap <leader>gb <C-t>

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
nnoremap <leader>bf :ls<cr>:b<Space>
"nnoremap <leader>bb :b#
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>
nnoremap <leader>bq :bd<cr>
nnoremap <leader>f :Files<cr>

" Clear highlight, mainly from search
"nmap <leader>/ :noh<cr>

" Exit INSERT mode into NORMAL mode
inoremap ji <Esc>

" Copy & Paste
noremap <leader>y "+y
noremap <leader>p "+p
