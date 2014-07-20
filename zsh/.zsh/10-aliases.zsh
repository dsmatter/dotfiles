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
alias asearch="apt-cache search "

#abbreviations
alias c="clear"
alias h="history"
alias m='mplayer'
alias n='notify'
alias s='sudo'
alias doch='sudo $(fc -ln -1)'
alias v="vim"
alias :q='exit'
alias ta='tmux attach'
alias svi="sudo vim"
alias ___="source ~/.zshrc && rehash"
alias xx="gpgOpen"
alias xxx="f -e"
alias t="notify lib"
alias tt="todoUrgent"
alias vv="gvim"
alias tma="tmux attach -d -t"
alias jj="marks_jump"

alias grepc="grep --color "
alias pg="ps aux | grep -v grep | grep -i"
alias px="ps auxf"
alias rcd="sudo rc.d"
alias fu="fusermount -u"
alias ssh="TERM=screen ssh"

alias syncTime='sudo ntpdate ntp1.lrz-muenchen.de'
alias iown="sudo chown -R $(id -nu):(id -ng) ."
alias zconf="vim \"+set cmdheight=2\" $HOME/.zshrc $HOME/.zsh/**/*.zsh"
alias serveHTTP="python -m SimpleHTTPServer"

### Things taken from feh ###
# Job-Control
alias 1='fg %1'
alias 2='fg %2'
alias 3='fg %3'
alias 4='fg %4'
alias 5='fg %5'
alias 6='fg %6'

alias 11='bg %1'
alias 22='bg %2'
alias 33='bg %3'
alias 44='bg %4'
alias 55='bg %5'
alias 66='bg %6'

