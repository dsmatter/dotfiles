# Make and change to directory
function cdmkdir {
  if mkdir $1; then
    cd $1
  fi
}

# Extract archives
function extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)        tar xvjf $1     ;;
      *.tar.gz)         tar xzvf $1     ;;
      *.bz2)            bunzip2 $1      ;;
      *.rar)            unrar x $1      ;;
      *.gz)             gunzip $1       ;;
      *.tar)            tar xvf $1      ;;
      *.tbz2)           tar xvjf $1     ;;
      *.tgz)            tar xzvf $1     ;;
      *.zip)            unzip $1        ;;
      *.Z)              uncompress $1   ;;
      *.7z)             7z x $1         ;;
      *)                echo "dunno how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Change to containing directory if file argument is given
function cd() {
  [[ -z "$1" ]] && builtin cd && return
  local dest="$1"
  [[ -f "$dest" ]] && dest="$(dirname $dest)"
  builtin cd $dest
}

# Change to subdirectory
function scd {
  local matches="$(find . -type d -iname "$1")"
  local match_count="$(echo $matches | wc -l)"
  if [[ -z $matches ]]; then
    echo "No match found"
    return 1
  elif [[ $match_count -eq 1 ]]; then
    cd "$(echo $matches | head -n1)"
  else
    cd "$(echo $matches | lineSelect)"
  fi
}

# Hook function
function chpwd() {
  [[ -t 1 ]] || return
  command ls -a
}

# Download URL in clipboard
function getit() {
  aria2c $(pbpaste)
}

function minimalPrompt() {
  PS1="$ "
  clear
}

# Fuzzy find in current directory
function findhere() {
  local what="$1"
  shift
  find . -iname "*${what}*" $*
}

function scpunihp() {
  scp $1 uni:../home_page/html-data/$2
  echo "http://home.in.tum.de/~strittma/${2}/${1}"
}

# Match line with regex and return the content of the first group
function sgrep() {
  cat | perl -ne "print \"\$1\\n\" if $1"
}

function beep() {
  echo -n "\07"
}

function google() {
  chromium "http://www.google.de/search?q=$*"
}

function pdfmerge() {
  command gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf $*
}

function pdfgrayscale() {
  command gs -sOutputFile=grayscale.pdf -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH $*

}

# Open argument or current directory
function x() {
  if [[ $# -eq 0 ]]; then
    open . &>/dev/null &|
  else
    open $* &>/dev/null &|
  fi
}

# Nice df layout
function df() {
  if [[ -z "$*" ]]; then
    command df -h | column -t
  else
    command df $*
  fi
}

function matrix() {
  tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"
}

spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

function dotView() {
  if [[ -z $1 ]]; then
    echo "Usage: $0 dotfile [options]"
    exit 1
  fi
  fn="$1"
  shift
  dot -Tpng -o /tmp/${fn:t:r}.png $fn $* && open /tmp/${fn:t:r}.png
}

function workflowy2otl() {
	sed -e 's/^\(\s*\)-/\1/' -e 's/  /\t/g' $*
}

function sshh() {
  TERM=screen ssh -t $* 'tmux attach || tmux new || screen -DR';
}

function dashboard() {
  tmux new-session \; send-keys "cd ~/.hubble && hubble" "C-m" \; split-window -v \; send-keys "while true; do clear; lsof -i -nP | grep -i establish | awk '{print \$1\" \"\$9}'; sleep 10; done" "C-m" \; split-window -h \; send-keys "ssh smserver 'while true; do echo -----------------------------; lsof -i -nP | grep -i listen | sort -u; sleep 10; done'" "C-m"
}

# Send document to kindle email address
function send2kindle() {
  local mail_addr="amazon_10697@kindle.com"

  if [[ -z $1 ]]; then
    echo "Please provide a file"
    return 1
  fi

  file_path="$1"
  file_name="$(basename $file_path)"
  local subject="hello"
  if [[ ${file_name:e} == "pdf" ]] && [[ $2 != "noconvert" ]]; then
    echo "Using convert option"
    subject="convert"
  fi
  scp $file_path smt:/tmp
  ssh smt "echo have fun | mutt -s $subject -a \"/tmp/${file_name}\" -- $mail_addr && rm \"/tmp/${file_name}\""
}

# Interactively rename files
function imv() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}

function sb() {
  if [[ -z "$1" ]]; then
    subl3 -n .
  else
    subl3 $*
  fi
}

function tm() {
  tmux-layout $* 2>/dev/null ||
  tmux-layout $HOME/.tmux-layouts/$1.json 2>/dev/null ||
  tmux $*
}

function ta() {
  tmux attach $* || tm $*
}

function lineSelect() {
  local -a lines
  local i=1
  local no

  cat | while read line; do
    [[ -z $line ]] && continue
    lines=($lines $line)
    echo "[$i] $line"
    (( i += 1 ))
  done >&2
  echo -n "Line: " >&2
  read no </dev/tty
  echo -n "${lines[$no]}"
}

function scratch() {
  local scratchfile="$HOME/Documents/scratch"
  local prog="$1"
  shift
  $prog $scratchfile $*
}

function vm() {
  case $1 in
    on     ) shift; VBoxManage startvm $* ;;
    off    ) shift; local vm=$1; shift; VBoxManage controlvm $vm poweroff $* ;;
    pause  ) shift; local vm=$1; shift; VBoxManage controlvm $vm pause $* ;;
    resume ) shift; local vm=$1; shift; VBoxManage controlvm $vm resume $* ;;
    save   ) shift; local vm=$1; shift; VBoxManage controlvm $vm savestate $* ;;
    disk   ) shift; VBoxManage internalcommands createrawvmdk -filename ${2-raw.vmdk} -rawdisk $1 ;;
    *      ) VBoxManage $*
  esac
}

function open-in-emacs() {
  local EMACS="/usr/local/Cellar/emacs-plus/25.1/bin/emacsclient"
  $EMACS $* &>/dev/null &|
}

function sml() {
  gsed -i '/10.0.0.1/d' $HOME/.ssh/known_hosts
  ssh ml
}

function smll() {
  gsed -i '/masterlockit.local/d' $HOME/.ssh/known_hosts
  ssh root@masterlockit.local
}

function sml2() {
  gsed -i '/172.20.50.1/d' $HOME/.ssh/known_hosts
  ssh root@172.20.50.1
}

function ssh-copy-key {
  local pk="$(cat $HOME/.ssh/id_rsa.pub)"

  ssh $1 << EOF
  if [[ ! -e .ssh ]]; then
    mkdir -p .ssh
    chmod 700 .ssh
  fi
  echo $pk >> .ssh/authorized_keys
EOF
}

function trailingWhitespace() {
  sed -i '' -E "s/[[:space:]]*$//" $*
}

function removeDuplicateBlankLines() {
  perl -pe 'BEGIN{$/=undef} s/MARKER\n\n/MARKER\n/g' $1
}

function repod {
  rm -rf Pods && poddev $@ --no-repo-update
}

function aca {
  a commit $@ -- -a
}

function tmpdir {
  UUID=$(uuid)
  cdmkdir /tmp/$UUID
}

function gitMergeIntoMaster {
  git diff-index --quiet --cached HEAD
  local dirty=$?
  local branch="$(git rev-parse --abbrev-ref HEAD)"

  if [[ $dirty != 0 ]]; then
    echo "Stashing local changes!"
    git stash
  fi

  git co master
  git pull
  git mff $branch

  read -q "REPLY?Continue with push? [y/N] "
  echo $REPLY

  if [[ $REPLY == "y" ]]; then
    git push
    git co $branch
    if [[ $dirty != 0 ]]; then
      git pop
    else
      git merge --ff-only master
    fi
  fi
}

function st {
  if [[ $# -eq 0 ]]; then
    open -a Tower "$(git rev-parse --show-toplevel)"
  else
    open -a Tower $@
  fi
}

function md {
  open -a Marked $@
}

function exml {
  tar xzvf "$1"
  tar xzvf update-repository.tar.gz
}

function cheat {
  cat "$HOME/.cheat/$*"
}

function excel() {
  open -a 'Microsoft Excel' $*
}

function xampp {
  if [[ "$1" == "on" ]]; then
    launchctl unload -w  /usr/local/Cellar/mysql/5.7.21/homebrew.mxcl.mysql.plist
    sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
  else
    launchctl load -w  /usr/local/Cellar/mysql/5.7.21/homebrew.mxcl.mysql.plist
    sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist
  fi
}

# Less
LESSOPEN="|/usr/bin/lesspipe.sh %s"
export LESSOPEN

