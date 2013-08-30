#!/bin/zsh

function zz() {
  for z in $HOME/.zsh/**/*.zsh $HOME/.zshrc; do
    zcompile $z
    echo "Compiled $z"
  done

  source $HOME/.zshrc
  rehash
}

