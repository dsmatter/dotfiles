#!/bin/zsh

cfg() {
  if [[ -z $1 ]]; then
    echo "Supply at least one of these arguments:"
    for a in grub zsh mirror rc vi gvi offlineimap sup xm; do
      echo $a
    done
    return 1
  fi

  local cmd=$1
  local edit=vim
  shift

  case $cmd in
    (grub) sudo $edit /boot/grub/grub.cfg $* ;;
    (zsh) zconf $* ;;
    (mirror*) sudo $edit /etc/pacman.d/mirrorlist $* ;;
    (rc*) sudo $edit /etc/rc.* /etc/rc.d $* ;;
    (vi*) $edit $HOME/.vimrc $HOME/.vim $HOME/.gvimrc $* ;;
    (gvi*) $edit $HOME/.gvimrc $* ;;
    (offlineimap) $edit $HOME/.offlineimaprc $HOME/.offlineimap ;;
    (sup) $edit $HOME/.sup ;;
    (xm|xmonad) $edit $HOME/.xmonad/*.hs $HOME/.xmonad/* $* ;;
  esac
}

