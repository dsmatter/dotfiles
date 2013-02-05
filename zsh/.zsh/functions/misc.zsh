function cdmkdir {
  if mkdir $1; then
    cd $1
  fi
}

extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)        tar xvjf $1     ;;
      *.tar.gz)         tar xzvf $1     ;;
      *.bz2)            bunzip2 $1      ;;
      *.rar)            unrar x $1       ;;
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

connectWlan() {
  echo '>> Trying to connect to '$1
  if [ -f "/etc/wpa_supplicant-$1.conf" ]; then
    sudo pkill wpa_supplicant
    sleep 1
    sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant$1.conf -D wext
    sleep 2
    echo '>> Getting IP'
    sudo pkill -9 dhcpcd
    sleep 1
    sudo dhcpcd wlan0
  else
    print 'No such wpa_supplicant network found'
    return 1
  fi
}

cdmkdir() {
  if mkdir $*; then
    cd $1
  fi
}

cd() {
  [[ -z "$1" ]] && builtin cd && return
  local dest="$1"
  [[ -f "$dest" ]] && dest="$(dirname $dest)"
  builtin cd $dest
}

#hook function
chpwd() {
  [[ -t 1 ]] || return
  command ls -a
}

rv() {
  val=$?
  if [[ "$val" == "0" ]]; then
    echo ':-)'
  else
    echo ':-('
  fi
}

ttt() {
  aoss java -jar /home/smatter/dl/apps/ttt/ttt.jar $@
}

getit() {
  aria2c $(pbpaste)
}

minimalPrompt() {
  PS1="$ "
  clear
}

findhere() {
  local what="$1"
  shift
  find . -iname "*${what}*" $*
}

scpunihp() {
  scp $1 uni:../home_page/html-data/$2
  echo "http://home.in.tum.de/~strittma/${2}/${1}"
}

sop() {
  vlc http://localhost:8908/tv.asf &
  sp-sc $1 3908 8908 
}

fixTouchpad() {
  synclient TapButton1=1
}

sgrep() {
  cat | perl -ne "print \"\$1\\n\" if $1"
}

networkingPids() {
  sudo netstat -np --inet | awk '{ print $7}' | egrep '^[0-9]+' | sort | uniq
}

propstring () {
  echo -n 'Property '
  xprop WM_CLASS | sed 's/.*"\(.*\)", "\(.*\)".*/= "\1,\2" {/g'
  echo '}'
}

lrz() {
  sudo vpnc-disconnect
  sudo vpnc vpnc
}

beep() {
  echo -n "\07"
}

getTheEnvs() {
  local CPID=$(pgrep compiz | head -n1)
  cat /proc/${CPID}/environ | tr '\0' '\n' | while read l; do export "$l"; done
}

fixTilda() {
  cd ${HOME}/.tilda
  cp config_0.save config_0
  tilda &>/dev/null &|
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

mountDesire() {
  PW=`gpg -d /dev/shm/passwords/desire.gpg`
  sudo curlftpfs -v 192.168.220.110:2121 /media/desire -o user=smatter:${PW},allow_other
}

x() {
  if [[ $# -eq 0 ]]; then
    open . &>/dev/null &|
  else
    open $* &>/dev/null &|
  fi
}

sayweather() {
  cliweather | sgrep '/Temperature:\s*(\d+)'/ | espeak
}

df() {
  if [[ -z "$*" ]]; then
    command df -h | column -t
  else
    command df $*
  fi
}

vimbrowser() {
  tabbed=$(tabbed -d); vimprobable -e $tabbed "$@"
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

rmUndoFiles() {
	rm **/.*.un~
}

workflowy2otl() {
	sed -e 's/^\(\s*\)-/\1/' -e 's/  /\t/g' $*
}

gistsearch () {
	local -a gists
	local i=1

	gista -l | egrep -i $* | while read l; do
		gists[i]="$(echo $l | cut -d' ' -f1)"
		echo "$i > $l"
		(( i = i + 1 ))
	done

	if (( i > 1)); then
		echo -n "Choice: "
		read ans

		if (( ans > 0 && ans < i )); then
			gista -f ${gists[ans]}
		else
			echo "Not in range..."
			return 1
		fi
	fi
}

dev() {
	subl -n .
	subl .
	tmux new-session \; split-window -v
}

rmDownloadHistory() {
  sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'
}

openTerminal() {
  osascript -e "tell app \"Terminal\"
    do script \"$*\"
  end tell"
}

sshh() {
  TERM=screen ssh -t $* 'tmux attach || tmux new || screen -DR';
}

dashboard() {
  tmux new-session \; send-keys "cd ~/.hubble && hubble" "C-m" \; split-window -v \; send-keys "while true; do clear; lsof -i -nP | grep -i establish | awk '{print \$1\" \"\$9}'; sleep 10; done" "C-m" \; split-window -h \; send-keys "ssh smserver 'while true; do echo -----------------------------; lsof -i -nP | grep -i listen | sort -u; sleep 10; done'" "C-m"
}

send2kindle() {
  local mail_addr="amazon_68987@kindle.com"

  if [[ -z $1 ]]; then
    echo "Please provide a file"
    return 1
  fi

  file_path="$1"
  file_name="$(basename $file_path)"
  local subject="hello"
  if [[ ${file_name:e} == "pdf" ]]; then
    echo "Using convert option"
    subject="convert"
  fi
  scp $file_path smt:/tmp
  ssh smt "echo have fun | mutt -s $subject -a \"/tmp/${file_name}\" -- $mail_addr && rm \"/tmp/${file_name}\""
}

# Less
LESSOPEN="|/usr/bin/lesspipe.sh %s"
export LESSOPEN

