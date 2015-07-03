#!/bin/zsh 

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export COLORTERM=yes
export TERM="xterm-256color"
export DIRSTACKSIZE=10
cdpath=(. ~ /media/smServer)
watch=(notme)
fpath=("$HOME/.zsh/completions" $fpath)

export EDITOR=vim
export PAGER=vimpager
export BROWSER=chromium

export DEVELOP_HOME="$HOME/develop"
export BIN_HOME="$HOME/bin"
export DOC_HOME="$HOME/Documents"
export MEDIA_HOME="$HOME/dl/media"
export SMSERVER="$HOME/smserver"
export GOPATH="$DEVELOP_HOME/go/mygo"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home"
export ENWIDA_HOME="$DEVELOP_HOME/projects/enwida/enwida_home"

path=($HOME/bin ${HOME}/.cabal/bin $GOPATH/bin /usr/local/bin /usr/local/sbin /opt/local/bin /usr/local/share/npm/bin /usr/texbin $path)

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=5000
export SAVEHIST=1000000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"

export MPD_HOST=smServer
export MPD_PORT=6600

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH_HOME/lib/zsh-syntax-highlighting/highlighters"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent:4559:1"

export ANDROID_HOME="/usr/local/Cellar/android-sdk/r21.1"

export GISTY_DIR="$DEVELOP_HOME/gists"

export SBT_OPTS=-XX:MaxPermSize=256m
export FZF_DEFAULT_COMMAND="find . -type f"

