#!/bin/zsh

zstyle :compinstall filename '/home/smatter/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Prefer local subdirs in cd
zstyle ':completion:*:cd:*' tag-order local-directories

# Extended completion
zstyle ':completion:*' completer _complete _approximate:-one _complete:-extended _approximate:-four
zstyle ':completion:*:approximate-one:*' max-errors 1
zstyle ':completion:*:complete-extended:*' matcher 'r:|[.,_-]=* r:|=*'
zstyle ':completion:*:approximate-four:*' max-errors 4

# Show completion context
zstyle ':completion:*:descriptions' format 'Completing %d'
zstyle ':completion:*' group-name ''

# Colorful menu completion
zstyle ':completion:*' list-colors ''
zstyle ':completion:*vim*' list-colors '=*.(tex|cpp|c|py|rb|js|hs|pl|sh|zsh)=01;32'

# Kill completion
zstyle ':completion:*processes' command 'ps aux'

#Treat // like / in path completion
zstyle ':completion:*' squeeze-slashes true

# Evince completion
zstyle ':completion:*evince*' file-patterns '*.pdf:PDF\ files'
zstyle ':completion:*pdf*' file-patterns '*.pdf:PDF\ files'

compdef _pacman powerpill bauerbill clyde p
compdef _pacman autojump

# Complete dots for parent directories while typing
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

