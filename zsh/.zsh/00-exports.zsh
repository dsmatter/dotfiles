#!/bin/zsh 

export LANG="en_US.UTF-8"
export COLORTERM=yes
export TERM="xterm-256color"
export DIRSTACKSIZE=10
cdpath=(. ~ /media/smServer)
watch=(notme)
fpath=("$HOME/.zsh/completions" $fpath)

export EDITOR=vim
export PAGER=vimpager
export BROWSER=chromium

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export DEVEL_HOME="$HOME/dev"
export BIN_HOME="$HOME/bin"
export DOC_HOME="$HOME/Documents"
export MEDIA_HOME="$HOME/dl/media"
export SMSERVER="$HOME/smserver"

#export PATH="${PATH}:$HOME/bin:/opt/java/bin"
path=(/usr/local/bin /usr/local/sbin $path $HOME/bin /opt/local/bin /usr/local/share/npm/bin)

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=5000
export SAVEHIST=1000000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"

export MPD_HOST=smServer
export MPD_PORT=6600

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH_HOME/lib/zsh-syntax-highlighting/highlighters"
export GOPATH="$HOME/dev/go/mygo"
