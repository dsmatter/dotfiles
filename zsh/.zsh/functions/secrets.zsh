KPDB_PATH='/home/smatter/Documents/secrets/pws.kdb'

getpass() {
  local what="pass"

  if [[ "$1" == "user" ]] || [[ "$1" == "pass" ]] || [[ "$1" == "dump" ]]; then
    what=$1
    shift
  fi

  keepassc.py open ${KPDB_PATH} dump -f '%(group_name)s/%(title)s|%(username)s|%(password)s' -p | egrep -i "$*" | egrep -i -v "^Backup" |
  while read l; do
    echo You chose $(echo $l | awk -F '|' '{print $1}')
    if [[ "$what" == "dump" ]]; then
      echo $l
    elif [[ "$what" == "user" ]]; then
      echo $l | awk -F '|' '{printf $2}' | xsel
      echo "User copied to clipboard"
    else
      echo $l | awk -F '|' '{printf $3}' | xsel
      echo "Password copied to clipboard"
    fi
    return
  done

  echo "No such entry found"
}

bankdata() {
  cd $HOME/.tmp
  local BANKDIR="$HOME/Documents/Bank"
  local TMPDIR=`mktemp -d bankdata`
  local BANKFN="bank.tar.gz.gpg"

  cp $BANKDIR/$BANKFN $TMPDIR
  if ! gpg -d $TMPDIR/${BANKFN} | tar xzv -C ${TMPDIR}; then
      echo "Wrong password!"
      rm -rf ${TMPDIR}
      return 1
  fi
  open ${TMPDIR}

  for x in `seq 30 -1 1`; do
      if expr ${x} % 15 = 0 &>/dev/null || [ ${x} -lt 16 ]; then
	  echo "Deleting tmp-dir in ${x} seconds"
      fi
      sleep 1
  done
  
  rm -rf ${TMPDIR}
}

mountStick() {
  sudo cryptsetup luksOpen /dev/sandisk-sec sandisk-sec
  sudo mount /dev/mapper/sandisk-sec /media/sandisk-sec
  echo done
}

mountStickGUI() {
  getTheEnvs
  local PW=$(zenity --entry --hide-text --text "Password for sandisk-sec" --title "Password please")
  echo ${PW} | sudo cryptsetup luksOpen /dev/sandisk-sec sandisk-sec 
  sudo mount /dev/mapper/sandisk-sec /media/sandisk-sec 
  echo done
}

passman_() {
  # passman - GPL3 - nibble <develsec.org> 2009
  # Minimal password manager

  PASSFILE=~/Dropbox/passman
  TMPFILE=~/.passmandb.$$

  trap "rm -f ${TMPFILE}" 0 2 15 &&
  umask 177 &&
	if [[ "$1" != "" ]]; then
		gpg -d ${PASSFILE} | egrep -i "$1"
		exit 0
	fi
  if [[ -e ${PASSFILE} ]]; then
    gpg --no-use-agent -o ${TMPFILE} -d ${PASSFILE}
  else
    touch ${TMPFILE}
  fi &&
  vim "+set viminfo=" "+set noswapfile" ${TMPFILE} + &&
  gpg --no-use-agent -r "high" -a -o ${PASSFILE} -e ${TMPFILE} 
}

passman() {
	zsh -ic "passman_ $*"
}

gpgAll() {
  find . -type f ! -name "*.gpg" -exec gpg -r high -e {} ';'
  echo -n "done. Wanna delete unencrypted files? [y/N] > "
  if read -q; then
    find . -type f ! -name "*.gpg" -delete
  fi
}

gpgDecAll() {
  gpg --decrypt-files **/*.gpg
}

showPwDialog() {
	osascript -e 'Tell application "System Events" to display dialog "Password:" default answer "" with hidden answer' -e 'text returned of result'
}

genpasswd() {
	local l=$1
	[[ "$l" == "" ]] && l=16
	tr -dc 'A-Za-z0-9_' < /dev/urandom | head -c ${l} | xargs
}

