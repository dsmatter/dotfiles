#!/bin/zsh

alias -g A='; alert'
alias -g C=' "$(pbpaste)" '
alias -g CC='| pbcopy'
alias -g DN='/dev/null'
alias -g E=' 2>/dev/null'
alias -g EE=' 2>&1'
alias -g F=' "$(fzf)"'
alias -g FF=' | fzf'
alias -g G='| egrep -i --color'
alias -g L='| less'
alias -g P="| $PAGER"
alias -g PE="| peco"
alias -g Q=' &>/dev/null &|'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g V='| vim -'
alias -g X='| xargs'
