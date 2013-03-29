#!/bin/zsh

# ls
alias l="command ls -al -G -F"
alias ll="command ls -l -G -F"
alias lss="command ls -al -G -F | grep -i --color"
alias lh='ll -h'
alias lt='ll -t'

# cd
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# cp mv rm
alias cp='cp -v'
alias ccp=ccp.rb
alias mv='mv -v'
alias rm='rm -v'
alias rmvi='rm **/.*.swp'

#fasd (a, s, sd, sf, d, f bound by fasd init script)
alias ss='fasd -s' #s is for sudo
alias j='fasd_cd -d' #emulate autojump
alias o='a -e xdg-open'

#git
alias gs='git status --short -b'
alias gp='git push'
alias gdd='git diff'
alias gc='git commit'

#apt-get
alias apt="sudo apt-get"
alias apdate="sudo apt-get dist-upgrade"
alias asearch="apt-cache search "

#pacman
alias pac="sudo pacman"
alias pacs="clyde -Ss"
alias ya=yaourt
alias yap="yaourt -Syu --aur --noconfirm"
alias yapp="yap --devel"

#abbreviations
alias c="clear"
alias h="history"
alias mm='mplayerTcp -af scaletempo'
alias m='mplay'
alias mx='mplayerx'
alias mp='echo pause >$HOME/mctl'
alias n='notify'
alias s='sudo'
alias v="vim"
alias :q='exit'
alias vipdf='apvlv'
alias pdfvi='apvlv'
alias sup="LD_LIBRARY_PATH=/usr/lib/ruby/gems/1.9.1/gems/xapian-full-1.2.3/lib/ sup"
alias tm='tmux'
alias ta='tmux attach'
alias svi="sudo vim"
alias ___="source ~/.zshrc && rehash"
alias xx="gpgOpen"
alias xxx="f -e"
alias gt="gtodo"
alias t="notify lib"
alias tt="todoUrgent"
alias pdf="open"
alias vv="gvim"
alias dv="dotView"

alias on='setImStatus on'
alias off='setImStatus off'
alias weg='setImStatus weg'

alias grepc="grep --color "
alias pg="ps aux | grep -v grep | grep -i"
alias px="ps auxf"
alias cs="conf_sync"
alias rcd="sudo rc.d"
alias fu="fusermount -u"
alias ssh="TERM=screen ssh"

alias syncTime='sudo ntpdate ntp1.lrz-muenchen.de'
alias xconf="sudo vim /etc/X11/xorg.conf"
alias rmpkg="rm *.pkg.tar.gz"
alias pkginstall="p -U *.pkg.tar.gz"
alias g9="~/dev/python/g9led/G9Led.py"
alias rec='ffmpeg -f x11grab -s 3360x1050 -r 150 -i :0.0 -sameq /tmp/foo.mpg'
alias tag='tmsu'
alias dellServiceTag="sudo dmidecode -s system-serial-number"
alias screen="TERM=xterm-new screen"
alias mo='sleep 1 && xset dpms force off'
alias mol='slock && sleep 1 && xset dpms force off'
alias iown="sudo chown smatter:smatter -R ."
alias bat="watch cat /proc/acpi/battery/BAT1/state"
alias zconf="vim \"+set cmdheight=2\" $HOME/.zshrc $HOME/.zsh/**/*.zsh"
alias gg="gpaste"
alias menubarFix="killall -KILL SystemUIServer"
alias serveHTTP="python -m SimpleHTTPServer"

alias mountRkvm="sshfs rkvm:rootkit /media/rkvm"
alias sm="mountSmServer"

alias androidScreenshot='/home/smatter/dl/apps/androidScreenshot/screenshot'
alias remember='aloop'

### Geklautes von feh ###
# Job-Control: Schnelles In-Den-Vordergrund-Bringen
alias 1='fg %1'
alias 2='fg %2'
alias 3='fg %3'
alias 4='fg %4'
alias 5='fg %5'
alias 6='fg %6'

# ...und wieder zurück!
alias 11='bg %1'
alias 22='bg %2'
alias 33='bg %3'
alias 44='bg %4'
alias 55='bg %5'
alias 66='bg %6'

conf() {
  case $1 in
    (rm|clean) print "Dude don't do that! It'll delete your \$HOME";;
    (pick) command env GIT_DIR=$HOME/.configs.git GIT_WORK_TREE=$HOME git checkout master
           command env GIT_DIR=$HOME/.configs.git GIT_WORK_TREE=$HOME git cherry-pick local
           command env GIT_DIR=$HOME/.configs.git GIT_WORK_TREE=$HOME git push
           command env GIT_DIR=$HOME/.configs.git GIT_WORK_TREE=$HOME git checkout local ;;
    (*) command env GIT_DIR=$HOME/.configs.git GIT_WORK_TREE=$HOME git $@;;
  esac
}

