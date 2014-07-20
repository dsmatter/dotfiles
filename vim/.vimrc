" vim: fdm=marker

" Essentials {{{

" Initialize pathogen
filetype off
call pathogen#infect()
filetype plugin indent on

" Vundle settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" }}}
" Plugins {{{

" Essential
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-repeat'

" Sidebars
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/Gundo'

" External Tools
Bundle 'Shougo/vimproc.vim'
Bundle 'mileszs/ack.vim'
Bundle 'jgdavey/tslime.vim'
Bundle 'vim-scripts/buffergrep'

" Coding Helpers
Bundle 'scrooloose/nerdcommenter'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'kien/rainbow_parentheses.vim'

" Text Manipulation
Bundle 'vim-scripts/UltiSnips'
Bundle 'dsmatter/vim-snippets'
Bundle 'ervandew/supertab'
Bundle 'Shougo/neocomplete'
Bundle 'vim-scripts/Align'
Bundle 'godlygeek/tabular'
Bundle 'Lokaltog/vim-easymotion'

" Language Support
Bundle 'scrooloose/syntastic'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jcf/vim-latex'
Bundle 'jergason/scala.vim'
Bundle 'gkz/vim-ls'
Bundle 'vim-scripts/a.vim'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'eagletmt/neco-ghc'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'Twinside/vim-hoogle'
Bundle 'travitch/hasksyn'
Bundle 'begriffs/vim-haskellConceal'
Bundle 'raichoo/purescript-vim'
"Bundle 'lukerandall/haskellmode-vim'

" Fancy
Bundle 'bling/vim-airline'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-scripts/CycleColor'
Bundle 'vim-scripts/CSApprox'
Bundle 'morhetz/gruvbox'
Bundle 'chriskempson/base16-vim'
Bundle 'w0ng/vim-hybrid'

" }}}
" {{{ General Settings

" It's 2014
set nocompatible

" We're on a virtual terminal, right?
set ttyfast
"
" Don't redraw while executing macros
set lazyredraw

" Use utf8
set encoding=utf8

" Keep some context around the cursor
set scrolloff=3

" Status bar
set showmode
set showcmd

" Improved Completion
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.pyc,.git\*,.hg\*,.svn\*

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

" Dont' show intro message, other abbrevs
set shortmess=atI

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

" Large history and undo buffer
set undofile
set undodir=~/.vim/undo
set history=1000
set undolevels=1000

" Don't use backup files like in the 70's
set nobackup
set noswapfile

" Change window title
set title

" Turn off VIM's crazy RegEx behaviour in search
nnoremap / /\v
vnoremap / /\v

" Always enable syntax highlighting
syntax on
filetype on
filetype plugin indent on
autocmd BufRead,BufNewFile syntax on

" Enable the mouse
set mouse=a

" Line wrap settings
set wrap
set textwidth=79
set formatoptions=qn1
set colorcolumn=100

" Make crontab -e work
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" }}}
" Indentation {{{

set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set expandtab
set softtabstop=2

" }}}
" Color scheme {{{

"colorscheme smyck
"colorscheme ir_black_smatter
"colorscheme badwolf
"colorscheme vitamin
"colorscheme monokai
colorscheme bvemu
"colorscheme darkburn

" Color invisible characters
" NonText    affects eol, extends and precedes
" SpecialKey affects nbsp, tab and trail
highlight NonText ctermfg=DarkGrey
highlight SpecialKey ctermfg=DarkGrey

" Color line numbers
highlight LineNr ctermfg=DarkGrey

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" }}}
" Plugin Settings {{{ 

" Completion {{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:SuperTabDefaultCompletionType = "<C-X><C-P>"
set completeopt+=longest

" }}}
" Alignment {{{

let g:loaded_AlignMapsPlugin=1
let g:haskell_tabular = 1

" }}}
" Tags {{{

" Add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/gtk-2.0
set tags+=~/.vim/tags/gtk-3.0
set tags=tags;/,codex.tags;/
set csto=1
set cst
set csverb

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /*.hs call LoadHscope()

" }}}
" Haskell {{{

" Linting
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
autocmd BufNew *.hs setlocal csprg=/Users/smatter/Library/Haskell/bin/hscope

" === Point-{Free/Ful} ===
function! Pointfree()
  call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>H. :call Pointfree()<CR>

function! Pointful()
  call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>H> :call Pointful()<CR>

" Disable conceals by default
let g:no_haskell_conceal=1

" }}}
" Snippets {{{

"let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}
" Airline {{{

let g:airline_theme = "wombat"

" }}}
" Yankring {{{

let g:yankring_history_dir="~/.vim/cache"

" }}}
" {{{ Rainbow Parathesis

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" }}}

" }}}
" Misc Functions {{{ 

" Remove trailing spaces
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" Link support
function! Browser ()
  let line = getline (".")
  "let line = matchstr (line, "\%(http://\|www\.\)[^ ,;\t]*")
  let line = matchstr (line, "\\(http://\\|www\\)[^ ,;\t]*")
  exec "!open ".line
endfunction

" }}}
" Mappings {{{

" Enable Command key
let macvim_skip_cmd_opt_movement = 1

" Set <leader>
let mapleader=","

" Window/Buffer Management {{{
nnoremap <leader>w <C-w>
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <D-k> <C-w>k
nnoremap <D-j> <C-w>j
nnoremap <D-h> <C-w>h
nnoremap <D-l> <C-w>l

" Create new vertical split and switch to it
nnoremap <leader>v <C-w>v<C-w>l

" j and k jump screen lines
nnoremap j gj
nnoremap k gk

" Switch to previously edited buffer
nmap <leader>e :e#<CR>

" Destroy current buffer
nnoremap <C-d> :bd<CR>
" }}}
" Toggles {{{
" Toggle search highlighting
nnoremap <leader>s :set hlsearch! hlsearch?<CR>

" Toggle listchars
nnoremap <leader>L :set list!<CR>

" Toggle past mode
set pastetoggle=<leader>p

" Toggle spell check
nnoremap <leader>sp :set spell!<CR>

" Toggle sidebars
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <leader>g :TagbarToggle<CR>:NERDTreeToggle<CR>

" Toggle rainbow parathesis
noremap <leader>rp :RainbowParenthesesToggle<CR>
" }}}
" Misc Functions {{{
" Copy file to clipboard
map <leader>cp :!cat % \| pbcopy<CR>

" Write files using sudo
cmap w!! w !sudo tee % >/dev/null

" Build TeX and open viewer
nnoremap <Leader>ff :call SyncTexForward()<CR>

" Strip trailing whitespace
nnoremap <leader>tw :%s/\s\+$//e<CR>

" Open link in line
nnoremap <Leader>www :call Browser()<CR>

" Show yankring
nnoremap <leader>y :YRShow<CR>

"Show scratch space
nnoremap <leader>S :Scratch<CR>
" }}}
" Haskell {{{
" GHC-Mod Shortcuts
nnoremap <leader>Ht :GhcModType<CR>
nnoremap <leader>HT :GhcModTypeInsert<CR>
nnoremap <leader>Hl :GhcModCheckAndLintAsync<CR>
nnoremap <leader>Hc :SyntasticCheck ghc_mod<CR>

" Hoogle
nnoremap <leader>Hh :Hoogle<CR>
nnoremap <leader>HH :Hoogle 
nnoremap <leader>Hi :HoogleInfo<CR>
nnoremap <leader>HI :HoogleInfo
nnoremap <leader>Hz :HoogleClose<CR>
" }}}
" Alignment {{{
nnoremap <leader>a= :Tabularize /=<CR>
nnoremap <leader>a, :Tabularize /,<CR>
nnoremap <leader>a<bar> :Tabularize /<bar><CR>
nnoremap <leader>ap :Tabularize 
" }}}
" Tag generation {{{
map <leader>tc<C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <leader>tg :!codex update<CR>:call system("git hscope")<CR><CR>:call LoadHscope()<CR>
nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" }}}
" Umlauts {{{
inoremap ,,a ä
inoremap ,,A Ä
inoremap ,,o ö
inoremap ,,O Ö
inoremap ,,u ü
inoremap ,,U Ü
inoremap ,,s ß
" }}}
" Misc {{{
" Learn hjkl, idiot!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Map Command-p to Ctrl-p
map <D-p> <C-p>

" Colorscheme testing
map <F5> :CycleColorNext<CR>
map <F6> :CycleColorPrev<CR>
" }}}

" }}}
