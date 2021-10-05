" vim: fdm=marker

" {{{ Plugins
call plug#begin(stdpath('data') . '/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'vim-airline/vim-airline'

" Color schemes
Plug 'arcticicestudio/nord-vim'
Plug 'tomasr/molokai'
Plug 'ayu-theme/ayu-vim'

call plug#end()

" }}}
" {{{ Color scheme

set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" }}}
" {{{ General

" It's 2014
set nocompatible

" We're on a virtual terminal, right?
set ttyfast

" Trigger CusorHold faster
set updatetime=300

" Use utf8
set encoding=utf8

" Keep some context around the cursor
set scrolloff=3

" Status bar
set showmode
set showcmd

" Backspace behaviour
set backspace=eol,start,indent
set whichwrap+=<,>,[,]

" Highlight cursor line
set cursorline

" Show line and column number
set ruler

" Always show last window in status bar
set laststatus=2

" Show relative line numbers
set relativenumber

" Disable error bell
set noerrorbells
set vb t_vb=

" Don't reset the cursor when moving around
set nostartofline

if &encoding == "utf-8"
  set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
else
  set listchars=tab:>\ ,trail:.,eol:-
endif
set list

" Allow hidden buffers
set hidden

" Show matching parenthesis
set showmatch

" Ignore case when searching (except when uppercase letters are used in search string)
set ignorecase
set smartcase

" Enable instant search highlighting
set nohlsearch
set incsearch

" Use short messages to avoid 'press enter' dialogs
set shortmess=atToO

" Don't change working directory to the current file's
set noautochdir

" Don't use backup files like in the 70's
set nobackup
set noswapfile

" Change window title
set title

" Always enable syntax highlighting
syntax on
filetype on
filetype plugin indent on
autocmd BufRead,BufNewFile syntax on

" Line wrap settings
set wrap
set textwidth=79
set formatoptions=qn1
set colorcolumn=100

" Default indentation
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set expandtab
set softtabstop=2

" netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 7

" }}}
" {{{ Completion
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
local nvim_lsp = require'lspconfig'

cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" }}}
" {{{ Rust
" Mostly from: https://sharksforarms.dev/posts/neovim-rust/

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF
" }}}
" {{{ LSP

" Have a fixed column for the diagnostics to appear in.
" This removes the jitter when warnings/errors flow in.
set signcolumn=yes

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

lua << EOF
local saga = require 'lspsaga'
--saga.init_lsp_saga()
EOF

" }}}
" {{{ Key Mappings

" Set <leader> to space
let mapleader=" "
let g:mapleader=" "
nnoremap <SPACE> <Nop>

" Window/Buffer Management {{{
nnoremap <leader>w <C-w>
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>n <cmd>bn<CR>
nnoremap <leader>p <cmd>bp<CR>

" Create new vertical split and switch to it
nnoremap <leader>v <C-w>v<C-w>l

" j and k jump screen lines
nnoremap j gj
nnoremap k gk

" Switch to previously edited buffer
nnoremap <leader>e :e#<CR>

" Delete current buffer
nnoremap <leader>dd :bd<CR>

" Open window splits in various places
nnoremap <leader>sh :leftabove vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sk :leftabove new<CR>
nnoremap <leader>sj :rightbelow new<CR>

" Resize splits
nnoremap <leader>0 <cmd>vertical resize +5<CR>
nnoremap <leader>9 <cmd>vertical resize -5<CR>

" Open explorer
nnoremap <leader>E <cmd>Lexplore<CR>

" {{{ Toggles

nnoremap <leader>/ :set hlsearch! hlsearch?<CR>
nnoremap <leader>L :set list!<CR>
nnoremap <leader>P :set paste!<CR>
nnoremap <leader>S :set spell!<CR>


" }}}
" {{{ LSP

nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <C-M-A> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-M-S> <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <C-M-S> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <C-M-T> <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <C-M-R> <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <C-M-F> <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <C-M-V> <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap ga <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <C-M-E> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" LSP Saga
nnoremap <C-M-D> <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <C-M-G> <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <leader><leader> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <C-M-Q> <cmd>lua require('lspsaga.floaterm').close_float_terminal()<CR>


" }}}
" {{{ Telescope

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fF <cmd>Telescope oldfiles<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fe <cmd>Telescope buffers<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>
nnoremap <leader>f/ <cmd>Telescope search_history<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>f<space> <cmd>Telescope builtin<cr>

" }}}
" Misc Functions {{{
" Copy file to clipboard
map <leader>cp :!cat % \| pbcopy<CR>

" Write files using sudo
cmap w!! w !sudo tee % >/dev/null

" Build TeX and open viewer
" nnoremap <Leader>ff :call SyncTexForward()<CR>

" Strip trailing whitespace
nnoremap <leader>tw :%s/\s\+$//e<CR>

" Show yankring
nnoremap <leader>y :YRShow<CR>

"Show scratch space
nnoremap <leader>S :Scratch<CR>

" Open file prompt with current path
nmap <leader>o :e <C-R>=expand("%:p:h") . '/'<CR>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Change the (local) working directory to the current buffer's file's
nmap <leader>cd :lcd %:h<CR>

" Change the (global) working directory to the current buffer's file's
nmap <leader>ccd :cd %:h<CR>

" }}}
