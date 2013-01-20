" DARK colorscheme.  The purpose of this colorscheme is to make small
" adjustments to the default.

" Restore default colors
hi clear
set background=dark 


if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "DarkDefault"

hi Normal guibg=grey25 guifg=GhostWhite ctermfg=gray ctermbg=black
"hi Normal guifg=#c0c0c0 guibg=#294d4a 

"Omni menu colors
hi Pmenu guibg=#444444
hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff
" Matched brackets
hi MatchParen ctermfg=7 ctermbg=4 

