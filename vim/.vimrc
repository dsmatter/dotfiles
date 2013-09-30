" Initialize pathogen
filetype off
call pathogen#infect()
filetype plugin indent on

" Vundle settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugins
Bundle 'gmarik/vundle'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/UltiSnips'
Bundle 'jcf/vim-latex'
Bundle 'jergason/scala.vim'
Bundle 'scrooloose/syntastic'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-scripts/CycleColor'
Bundle 'vim-scripts/CSApprox'
Bundle 'gkz/vim-ls'
Bundle 'vim-scripts/Align'
Bundle 'morhetz/gruvbox'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/refactor'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-scripts/buffergrep'

" === Global settings === "

" It's 2013
set nocompatible

" Enable indentation
"set cindent
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

" Display invisible characters
"
" For utf-8 use the following characters
"
"   ▸ for tabs
"   . for trailing spaces
"   ¬ for line breaks
"
" otherwise, fall back to
"
"   > for tabs
"   . for trailing spaces
"   - for line breaks
"
if &encoding == "utf-8"
  set listchars=tab:▸\ ,trail:.,eol:¬
else
  set listchars=tab:>\ ,trail:.,eol:-
endif
set nolist

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

" Highlight characters behind the 80 chars margin
:au BufWinEnter (*.rb|*.py) let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" === Apply .vimrc on write === "
"if has("autocmd")
	"autocmd BufWritePost .vimrc source $MYVIMRC
	"autocmd BufWritePost .gvimrc source $MYGVIMRC
"endif

" === SuperTab === "
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" === MinBufExplorer settings === "
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplUseSingleClick = 1

" === Python settings === "
" Identation
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Completion
if has("autocmd")
	autocmd FileType python set complete+=k/home/smatter/.vim/pydiction-0.5/pydiction isk+=.,(
endif 

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

" === SLIME === "
let g:slime_target = "tmux"

" === Taglist === "
let Tlist_Display_Prototype = 0

" === OmniCppComplete settings === "
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" === LaTeX settings === "
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode --synctex=1 $*'
let g:Tex_ViewRule_pdf = 'skim'

" === TVO settings === "
let g:otl_bold_headers = 1

function! SyncTexForward()
		 let execstr = 'silent! !okular --unique %<.pdf\#src:'.line('.').expand("%").' &'
		 exec execstr
endfunction

" === UltiSnips settings === "

let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" === Remove trailing spaces === "
fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

" === Rainbow parenthesis === "
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


" === Xiki === "
"let $XIKI_DIR = "~/.rvm/gems/ruby-1.9.3-p194/gems/xiki-0.6.3"
"source ~/.rvm/gems/ruby-1.9.3-p194/gems/xiki-0.6.3/etc/vim/xiki.vim

" === Dmenu fuzzy search === "
function! Chomp(str)
	return substitute(a:str, '\n$', '', '')
endfunction

function! DmenuOpen(cmd)
	let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
	if empty(fname)
		return
	endif
	execute a:cmd . " " . fname
endfunction

" === Powerline === "
let g:Powerline_symbols = 'fancy'

" === Link support === "
function! Browser ()
let line = getline (".")
"let line = matchstr (line, "\%(http://\|www\.\)[^ ,;\t]*")
let line = matchstr (line, "\\(http://\\|www\\)[^ ,;\t]*")
exec "!open ".line
endfunction

" === Handling of crontabs === "
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" === Yankring config === "
let g:yankring_history_dir="~/.vim/cache"

"=== YCM config === "
let g:ycm_extra_conf_globlist = ["~/.ycm_extra_conf.py"]

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

map <A-k> <C-w>k
map <A-j> <C-w>j
map <A-h> <C-w>h
map <A-l> <C-w>l

" Mappings for Macvim w/ Command-Key
map <D-k> <C-w>k
map <D-j> <C-w>j
map <D-h> <C-w>h
map <D-l> <C-w>l

map <D-up> <C-w>k
map <D-down> <C-w>j
map <D-left> :bp<CR>
map <D-right> :bn<CR>

" Toggle sidebars
nmap <leader>n :NERDTreeToggle<CR>
map <F4> :NERDTreeToggle<CR>
map <F3> :TagbarToggle<CR>
map <F5> :TagbarToggle<CR>:NERDTreeToggle<CR>

" Destroy current buffer
map <C-d> :bd<CR>

" Toggle search highlighting
map <F8> :set hlsearch! hlsearch?<CR>
map <leader><space> :set hlsearch! hlsearch?<CR>

" Write files using sudo
cmap w!! w !sudo tee % >/dev/null

" Use ; as : (i.e. w/o holding SHIFT)
"nnoremap ; :

" Jump to matching brackets with TAB
nnoremap <tab> %
vnoremap <tab> %

" j and k jump screen lines
nnoremap j gj
nnoremap k gk

" Learn hjkl, idiot!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" === Custom <leader> mappings === "

" Build TeX and open viewer
nmap <Leader>ff :call SyncTexForward()<CR>

" Command-T open dialog
nmap <leader>' :CommandT<CR>

" Toggle spell check
map <leader>s :set spell!<CR>

" Open "Ottl Outline" in new tab
map <leader>t :tabedit ~/Dropbox/Apps/OTL\ Outliner/todo.otl<CR>

" Open link in line
map <Leader>www :call Browser()<CR>

" Clear trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Exit insert mode with jj
inoremap jj <ESC>

" Create new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Start search with ack
nnoremap <leader>a :Ack\ 

" Show yankring
nnoremap <leader>y :YRShow<CR>

" Show rainbow parenthesis
nnoremap <leader>r :RainbowParenthesesToggle<CR>

"Show scratch space
nnoremap <leader>S :Scratch<CR>

" Toggle listchars
noremap <leader>u :set list!<CR>

" Easier window management
noremap <leader>w <C-w>

" Map Command-p to Ctrl-p
map <D-p> <C-p>

" Switch to last buffer
map <C-e> :e#<CR>
nmap <leader>e :e#<CR>

" Move around in buffers
map <C-n> :bn<CR>
map <C-m> :bp<CR>

map <F5> :CycleColorNext<CR>
map <F6> :CycleColorPrev<CR>


