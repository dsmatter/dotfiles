#!/bin/zsh

# ls
alias l="command exa -alg --git"
alias ll="command exa -lg"
alias lss="command exa -alg | grep -i --color"
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
alias bd=". bd -s"

# cp mv rm
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias rmvi='rm **/.*.swp'
alias mmv='noglob zmv -W'

#fasd (a, s, sd, sf, d, f bound by fasd init script)
alias ss='fasd -s' #s is for sudo
alias j='fasd_cd -d' #emulate autojump
alias o='a -e xdg-open'

#git
alias gs='git status --short -b'
alias gp='git push'
alias gl='git pull'
alias gdd='git diff'
alias gc='git commit'
alias ac='a commit'

# CocoaPods
alias poddev='/Users/smatter/develop/git/Rainforest/CocoaPods/bin/pod'
alias ppod='rbenv exec pod'
alias rbexec='rbenv exec bundle exec'

#apt-get
alias apt="sudo apt-get"
alias apdate="sudo apt-get dist-upgrade"
alias asearch="apt-cache search "

#abbreviations
alias dut="sudo diskutil"
alias sc="scratch vim"
alias scc="scratch mvim"
alias c="clear"
alias h="history"
alias mx='mplayerx'
alias n='notify'
alias s='sudo'
alias doch='sudo $(fc -ln -1)'
alias v="nvim"
alias :q='exit'
alias svi="sudo nvim"
alias ___="source ~/.zshrc && rehash"
alias xx="gpgOpen"
alias xxx="f -e"
alias t="notify lib"
alias tt="todoUrgent"
alias pdf="open"
alias vv="code"
alias e="code"
alias chrome="open -a 'Google Chrome'"
alias 2x="open -a /Applications/Retini.app"
alias ee="/opt/homebrew-cask/Caskroom/emacs/24.4/Emacs.app/Contents/MacOS/Emacs"
alias dv="dotView"
alias tma="tmux attach -d -t"
alias jj="marks_jump"
alias curljson="curl -H 'Content-Type: application/json'"
alias fuck='$(thefuck $(fc -ln -1))'
alias mvn-deploy-nexus="mvn deploy -DaltDeploymentRepository='lockitnetwork-release::default::http://nexus.code.easyscott.com/content/repositories/releases'"
alias mvn-updateDeps="mvn versions:use-latest-versions -DgenerateBackupPoms=false"
alias uuid="python3 -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)' | pbcopy && pbpaste && echo"
#alias lock="pmset displaysleepnow"
alias lock="m lock"
alias co="cargo"
alias bat="bat --pager less"

alias grepc="grep --color "
alias pg="ps aux | grep -v grep | grep -i"
alias px="ps auxf"
alias rcd="sudo rc.d"
alias fu="fusermount -u"
alias ssh="TERM=screen ssh"

alias syncTime='sudo ntpdate ntp1.lrz-muenchen.de'
alias xconf="sudo vim /etc/X11/xorg.conf"
alias rmpkg="rm *.pkg.tar.gz"
alias pkginstall="p -U *.pkg.tar.gz"
alias screen="TERM=xterm-new screen"
alias mo='sleep 1 && xset dpms force off'
alias mol='slock && sleep 1 && xset dpms force off'
alias iown="sudo chown $(id -nu):$(id -ng) -R ."
alias zconf="nvim \"+set cmdheight=2\" $HOME/.zshrc $HOME/.zsh/**/*.zsh"
alias serveHTTP="python3 -m http.server"
alias sleeplog='pmset -g log|grep -e " Sleep  " -e " Wake  "'

alias sm="remountSmServer"

# LockitNetwork Stuff
alias locknetPodLibCreate='pod lib create --template-url=ssh://git@stash.code.easyscott.com:7999/app/pod-template.git'
alias locknetPodPush='git push --tags; pod repo push lockitnetwork --allow-warnings'

### Things from feh ###
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

