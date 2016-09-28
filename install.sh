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

shift $OPTIND-1

run() {
  test $verbose && echo $*
  $*
}

install_module() {
  local module="$1"
  echo "> In module $module"

  # Find base path
  local base="$HOME"
  if [[ -f $module/.basepath ]]; then
    base="$HOME/$(cat $module/.basepath | head -n1)"
  fi

  # Create symlinks for each file or symlink
  find $module '(' -type f -or -type l ')' \
    '!' '(' -name '.git' -or -name '.basepath' ')' -print \
    | while read f
  do
    local src=$(pwd)/$f
    local target=$base/${f/$module\//}

    if [[ -f $target ]]; then
      if [[ ! -z $force ]]; then
        run rm "$target"
      else
        test $verbose && echo "Skipping $target" >&2
        continue
      fi
    fi

    run mkdir -p "$(dirname $target)"
    run ln -s "$src" "$target"
  done
}

if [[ ! -z "$1" ]]; then
  install_module "$1"
else
  for module in *(/); do
    install_module "$module"
  done
fi

