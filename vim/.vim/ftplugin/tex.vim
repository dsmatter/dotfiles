set sw=2
set iskeyword+=:
set autowrite

function! TexReplaceUmlauts()
  %s/ä/\"a/g
  %s/ö/\"o/g
  %s/ü/\"u/g
  %s/ß/\"s/g
endfunction

map \uu :call TexReplaceUmlauts()


