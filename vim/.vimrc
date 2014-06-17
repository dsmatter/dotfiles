" Initialize pathogen
filetype off
call pathogen#infect()
filetype plugin indent on

" Vundle settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugins

" Essential
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'

" Sidebars
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/Gundo'

" External Tools
Bundle 'Shougo/vimproc.vim'
Bundle 'mileszs/ack.vim'
Bundle 'jgdavey/tslime.vim'
Bundle 'vim-scripts/buffergrep'

" Text Manipulation
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/UltiSnips'
Bundle 'dsmatter/vim-snippets'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/Align'
Bundle 'godlygeek/tabular'

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
"Bundle 'lukerandall/haskellmode-vim'

" Fancy
Bundle 'bling/vim-airline'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-scripts/CycleColor'
Bundle 'vim-scripts/CSApprox'
Bundle 'morhetz/gruvbox'
Bundle 'chriskempson/base16-vim'
Bundle 'w0ng/vim-hybrid'

" === Global settings === "

" It's 2014
set nocompatible

" Enable indentation
set autoindent

" Tab settings
set shiftwidth=2
set tabstop=2
set expandtab
set softtabstop=2

" Set color scheme (theme)
"colorscheme smyck
"colorscheme ir_black_smatter
"colorscheme badwolf
"colorscheme vitamin
"colorscheme monokai
colorscheme bvemu
"colorscheme darkburn

" Use utf8
set encoding=utf8

" Keep some context around cursor
set scrolloff=3

" Status bar
set showmode
set showcmd

" Improved Completion
set wildmenu
set wildmode=list:longest

" Highlight cursor line
set cursorline

" We're on a virtual terminal, right?
set ttyfast

" Show line and column number
set ruler

" Always show last window in status bar
set laststatus=2

" Show relative line numbers
set relativenumber

" Disable error bell
set noerrorbells

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

" Color invisible characters
"
" NonText    affects eol, extends and precedes
" SpecialKey affects nbsp, tab and trail
highlight NonText ctermfg=DarkGrey
highlight SpecialKey ctermfg=DarkGrey

" Color line numbers
highlight LineNr ctermfg=DarkGrey


" Allow hidden buffers
set hidden

" Show matching parenthesis
set showmatch

" Ignore case when searching (except when uppercase letters are used in search string)
set ignorecase
set smartcase

" Use short messages to avoid 'press enter' dialogs
set shortmess=atToO

" Change working directory to the current file's
set autochdir

" Large history and undo buffer
set undofile
set undodir=~/.vim/undo
set history=1000
set undolevels=1000

" Change window title
set title

" Don't use backup files like in the 70's
set nobackup
set noswapfile

" Turn off VIM's crazy RegEx behaviour in search
nnoremap / /\v
vnoremap / /\v

" Enable instant search highlighting
set nohlsearch
set incsearch

" Enable syntax highlighting
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

" === SuperTab === "
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" === MinBufExplorer settings === "
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplUseSingleClick = 1

" === Tags settings === "
" Add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/gtk-2.0
set tags+=~/.vim/tags/gtk-3.0

" Build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" === Syntastic === "
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 '

" === UltiSnips settings === "

"let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" === Remove trailing spaces === "
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" === Link support === "
function! Browser ()
  let line = getline (".")
  "let line = matchstr (line, "\%(http://\|www\.\)[^ ,;\t]*")
  let line = matchstr (line, "\\(http://\\|www\\)[^ ,;\t]*")
  exec "!open ".line
endfunction

" Airline theme
let g:airline_theme = "wombat"

" === Yankring config === "
let g:yankring_history_dir="~/.vim/cache"

" === Key Mappings === "

" Enable Command key
let macvim_skip_cmd_opt_movement = 1

" Set <leader>
let mapleader=","

" Toggle past mode on F2
set pastetoggle=<F2>

" Window movement mappings
map <leader>k <C-w>k
map <leader>j <C-w>j
map <leader>h <C-w>h
map <leader>l <C-w>l
map <D-k> <C-w>k
map <D-j> <C-w>j
map <D-h> <C-w>h
map <D-l> <C-w>l

" Toggle sidebars
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>b :TagbarToggle<CR>
nmap <leader>g :TagbarToggle<CR>:NERDTreeToggle<CR>

" Destroy current buffer
map <C-d> :bd<CR>

" Toggle search highlighting
map <leader><space> :set hlsearch! hlsearch?<CR>

" Write files using sudo
cmap w!! w !sudo tee % >/dev/null

" j and k jump screen lines
nnoremap j gj
nnoremap k gk

" Learn hjkl, idiot!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Build TeX and open viewer
nmap <Leader>ff :call SyncTexForward()<CR>

" Toggle spell check
map <leader>s :set spell!<CR>

" Strip trailing whitespace
map <leader>tw :%s/\s\+$//e<CR>

" Open link in line
map <Leader>www :call Browser()<CR>

" Create new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Start search with ack
nnoremap <leader>a :Ack 

" Show yankring
nnoremap <leader>y :YRShow<CR>

"Show scratch space
nnoremap <leader>S :Scratch<CR>

" Toggle listchars
noremap <leader>lc :set list!<CR>

" Easier window management
noremap <leader>w <C-w>

" Map Command-p to Ctrl-p
map <D-p> <C-p>

" Switch to last buffer
nmap <leader>e :e#<CR>

" Copy file to clipboard
map <leader>cp :!cat % \| pbcopy<CR>

" Move around in buffers
map <C-n> :bn<CR>
map <C-m> :bp<CR>

map <F5> :CycleColorNext<CR>
map <F6> :CycleColorPrev<CR>

" Umlauts
inoremap ,,a ä
inoremap ,,A Ä
inoremap ,,o ö
inoremap ,,O Ö
inoremap ,,u ü
inoremap ,,U Ü
inoremap ,,s ß

