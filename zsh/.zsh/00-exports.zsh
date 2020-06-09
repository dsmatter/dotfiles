#!/bin/zsh 

export LANG="en_US.UTF-8"
export COLORTERM=yes
export TERM="xterm-256color"
export DIRSTACKSIZE=10
watch=(notme)
fpath=("$HOME/.zsh/completions" $fpath)

export EDITOR=vim
export PAGER=less

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=5000
export SAVEHIST=1000000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH_HOME/lib/zsh-syntax-highlighting/highlighters"
