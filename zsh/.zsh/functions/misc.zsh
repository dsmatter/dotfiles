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

# Hook function
function chpwd() {
  [[ -t 1 ]] || return
  command ls -a
}

# Download URL in clipboard
function getit() {
  aria2c $(pbpaste)
}

# Match line with regex and return the content of the first group
function sgrep() {
  cat | perl -ne "print \"\$1\\n\" if $1"
}

function beep() {
  echo -n "\07"
}

function google() {
  open "http://www.google.de/search?q=$*"
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

spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

function sshh() {
  TERM=screen ssh -t $* 'tmux attach || tmux new || screen -DR';
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

function tm() {
  tmux-layout $* 2>/dev/null ||
  tmux-layout $HOME/.tmux-layouts/$1.json 2>/dev/null ||
  tmux $*
}

function ta() {
  tmux attach $* || tm $*
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

function sml() {
  gsed -i '/10.0.0.1/d' $HOME/.ssh/known_hosts
  ssh ml
}

function smll() {
  gsed -i '/masterlockit.local/d' $HOME/.ssh/known_hosts
  ssh root@masterlockit.local
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

function aca {
  a commit $@ -- -a
}

function tmpdir {
  UUID=$(uuid)
  cdmkdir /tmp/$UUID
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

function ffmaster {
  git fetch . HEAD:master && git push origin master
}

function tsvMaxLen {
  awk -F'\t' '{for (i=1; i <= NF; i++) { if(length($i) > max_len) { max_len = length($i) } }} END { print max_len }' $@
}

function rm-quarantine {
  xattr -r -d com.apple.quarantine $*
}

# Less
LESSOPEN="|/usr/bin/lesspipe.sh %s"
export LESSOPEN

