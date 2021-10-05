#!/bin/zsh

alias -g A='; alert'
alias -g B='$(git symbolic-ref --short HEAD)'
alias -g BB='$(git branch -a | fzf)'
alias -g C=' "$(pbpaste)" '
alias -g CC='| pbcopy'
alias -g DN='/dev/null'
alias -g E=' 2>/dev/null'
alias -g EE=' 2>&1'
alias -g F=' "$(fzf)"'
alias -g FF=' | fzf'
alias -g G='| rg -i'
alias -g L='| bat --pager less'
alias -g P="| $PAGER"
alias -g PE="| peco"
alias -g Q=' &>/dev/null &|'
alias -g R=' "$(gfind ~/Downloads -maxdepth 1 -mindepth 1 -type f \! -name ".DS_Store" -printf "%T@ %p\n"  | sort -rn | cut -d " " -f2- | fzf)"'
alias -g RR=' "$(gfind ~/Desktop -maxdepth 1 -mindepth 1 -type f \! -name ".DS_Store" -printf "%T@ %p\n"  | sort -rn | cut -d " " -f2- | fzf)"'
alias -g S="| percol"
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g V='| vim -'
alias -g VV='| code -'
alias -g X='| xargs'
