# Make and change to directory
function cdmkdir {
  if mkdir $1; then
    cd $1
  fi
}

# Extract archives
extract() {
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
cd() {
  [[ -z "$1" ]] && builtin cd && return
  local dest="$1"
  [[ -f "$dest" ]] && dest="$(dirname $dest)"
  builtin cd $dest
}

# Hook function
chpwd() {
  [[ -t 1 ]] || return
  command ls -a
}

# Download URL in clipboard
getit() {
  aria2c $(pbpaste)
}

minimalPrompt() {
  PS1="$ "
  clear
}

# Fuzzy find in current directory
findhere() {
  local what="$1"
  shift
  find . -iname "*${what}*" $*
}

scpunihp() {
  scp $1 uni:../home_page/html-data/$2
  echo "http://home.in.tum.de/~strittma/${2}/${1}"
}

# Match line with regex and return the content of the first group
sgrep() {
  cat | perl -ne "print \"\$1\\n\" if $1"
}

beep() {
  echo -n "\07"
}

google() {
  chromium "http://www.google.de/search?q=$*"
}

pdfmerge() {
  command gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf $*
}

pdfgrayscale() {
  command gs -sOutputFile=grayscale.pdf -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH $*

}

# Open argument or current directory
x() {
  if [[ $# -eq 0 ]]; then
    open . &>/dev/null &|
  else
    open $* &>/dev/null &|
  fi
}

# Nice df layout
df() {
  if [[ -z "$*" ]]; then
    command df -h | column -t
  else
    command df $*
  fi
}

matrix() {
  tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"
}

spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

dotView() {
  if [[ -z $1 ]]; then
    echo "Usage: $0 dotfile [options]"
    exit 1
  fi
  fn="$1"
  shift
  dot -Tpng -o /tmp/${fn:t:r}.png $fn $* && open /tmp/${fn:t:r}.png
}

workflowy2otl() {
	sed -e 's/^\(\s*\)-/\1/' -e 's/  /\t/g' $*
}

sshh() {
  TERM=screen ssh -t $* 'tmux attach || tmux new || screen -DR';
}

dashboard() {
  tmux new-session \; send-keys "cd ~/.hubble && hubble" "C-m" \; split-window -v \; send-keys "while true; do clear; lsof -i -nP | grep -i establish | awk '{print \$1\" \"\$9}'; sleep 10; done" "C-m" \; split-window -h \; send-keys "ssh smserver 'while true; do echo -----------------------------; lsof -i -nP | grep -i listen | sort -u; sleep 10; done'" "C-m"
}

# Send document to kindle email address
send2kindle() {
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
imv() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}

sb() {
  if [[ -z "$1" ]]; then
    subl3 -n .
  else
    subl3 $*
  fi
}

tm() {
  tmux-layout $* 2>/dev/null ||
  tmux-layout $HOME/.tmux-layouts/$1.json 2>/dev/null ||
  tmux $*
}

function ta() {
  tmux attach $* || tm $*
}

lineSelect() {
  local -a lines
  local i=0
  local no

  cat | while read line; do
    lines=($lines $line)
    echo "$i $line"
    (( i += 1 ))
  done >&2
  echo -n "Line: " >&2
  read no </dev/tty
  echo -n "${lines[$no]}"
}

# Less
LESSOPEN="|/usr/bin/lesspipe.sh %s"
export LESSOPEN

