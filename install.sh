#!/bin/zsh

local force=
local verbose=
local -a cmd

while getopts fv opt; do
  case $opt in
    (f)
      force=yes
      ;;
    (v)
      verbose=yes
      ;;
    (*)
      exit 1
      ;;
  esac
done

run() {
  test $verbose && echo $*
  $*
}

for module in *(/); do
  echo "> In module $module"

  find $module '(' -type f -or -type l ')' '!' -name '.git' -print | while read f; do
    local src=$(pwd)/$f
    local target=$HOME/${f/$module\//}

    if [[ -f $target ]]; then
      if [[ ! -z $force ]]; then
        run rm "$target"
      else
        test $verbose && echo "Skipping $target" >&2
        continue
      fi
    fi

    run mkdir -p $(dirname $target)
    run ln -s "$src" "$target"
  done
done