#!/bin/zsh 

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export COLORTERM=yes
export TERM="xterm-256color"
export DIRSTACKSIZE=10
watch=(notme)
fpath=("$HOME/.zsh/completions" $fpath)

export EDITOR=nvim
export PAGER="bat --pager less"

export BIN_HOME="$HOME/bin"
export DOC_HOME="$HOME/Documents"

path=(${HOME}/bin ${HOME}/.local/bin /usr/local/bin /usr/local/sbin "$HOME/Library/Application Support/Code/User/globalStorage/bmd.stm32-for-vscode/@xpack-dev-tools/arm-none-eabi-gcc/11.2.1-1.1.1/.content/bin" $path)

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$ZSH_HOME/lib/zsh-syntax-highlighting/highlighters"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent:4559:1"

export FZF_DEFAULT_COMMAND="fd --type f"
export JAVA_HOME=/opt/homebrew/opt/openjdk@11
export RBENV_VERSION="2.7.5"
