#!/bin/zsh

# ls
alias l="command eza -alg --git"
alias ll="command eza -lg"
alias lss="command eza -alg | grep -i --color"
alias lt='l -snew'
alias la='l --absolute'

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

#git
alias gs='git status --short -b'
alias gp='git push'
alias gl='git pull'
alias gdd='git diff'
alias gc='git commit'
alias ac='a commit'

# CocoaPods
alias ppod='rbenv exec pod'
alias rbexec='rbenv exec bundle exec'

#abbreviations
alias dut="sudo diskutil"
alias c="clear"
alias h="history"
alias s='sudo'
alias doch='sudo $(fc -ln -1)'
alias svi="sudo nvim"
alias v="nvim"
alias ___="source ~/.zshrc && rehash"
alias e="code"
alias tma="tmux attach -d -t"
alias curljson="curl -H 'Content-Type: application/json'"
alias uuid="python3 -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)' | pbcopy && pbpaste && echo"
alias co="cargo"
alias bat="bat --pager less"
alias python=python3
alias idf="idf.py"
alias lg=lazygit
alias nv=neovide
alias ts="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias fda="fd --hidden --no-ignore"
alias rga="rg --hidden --no-ignore"

alias pg="ps aux | grep -v grep | grep -i"
alias px="ps auxf"
alias ssh="TERM=screen ssh"

alias iown="sudo chown $(id -nu):$(id -ng) -R ."
alias zconf="nvim \"+set cmdheight=2\" $HOME/.zshrc $HOME/.zsh/**/*.zsh"
alias serveHTTP="python3 -m http.server"

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

