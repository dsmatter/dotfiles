#!/bin/zsh

# Acitvate colos
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi

set_theme() {
  source $ZSH_HOME/themes/$1.zsh-theme
}

# Use set_theme function to select a theme
set_theme star

